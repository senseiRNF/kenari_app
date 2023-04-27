import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_payment_page.dart';
import 'package:kenari_app/services/api/loan_services/api_loan_services.dart';
import 'package:kenari_app/services/api/models/loan_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanDetailPage extends StatefulWidget {
  final String loanId;

  const LoanDetailPage({
    super.key,
    required this.loanId,
  });

  @override
  State<LoanDetailPage> createState() => _LoanDetailPageState();
}

class _LoanDetailPageState extends State<LoanDetailPage> {
  String? name;

  DateTime? dueDate;

  LoanData? loanData;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        name = nameResult;
      });

      await APILoanServices(context: context).callById(widget.loanId).then((callResult) {
        setState(() {
          loanData = callResult;
        });

        if(loanData != null && loanData!.jatuhTempo != null) {
          setState(() {
            dueDate = DateTime.parse(loanData!.jatuhTempo!);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            BackFromThisPage(context: context).go();
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.chevron_left,
                              size: 30.0,
                              color: IconColorStyles.iconColor(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            'Detail Transaksi Pendanaan',
                            style: HeadingTextStyles.headingS(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: NeutralColorStyles.neutral05(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: BorderColorStyles.borderStrokes(),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Tagihan',
                          style: STextStyles.regular(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            loanData != null && loanData!.bayarBulanan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(loanData!.bayarBulanan!)).replaceAll(',', '.')}" : 'Unknown',
                            style: LTextStyles.medium(),
                          ),
                        ),
                        dueDate != null ?
                        Row(
                          children: [
                            Text(
                              DateTime.now().isAfter(dueDate!) == true ? 'Terlambat ' : 'Jatuh Tempo ',
                              style: STextStyles.medium(),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(dueDate!),
                              style: STextStyles.medium().copyWith(
                                color: DangerColorStyles.dangerMain(),
                              ),
                            ),
                          ],
                        ) :
                        const Material(),
                        dueDate != null && DateTime.now().isAfter(dueDate!) == true ?
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: DangerColorStyles.dangerSurface(),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info,
                                color: DangerColorStyles.dangerMain(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Tagihan bertambah karena ada biaya keterlambatan pembayaran. Mohon selesaikan pembayaran.',
                                  style: XSTextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) :
                        const Material(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Kode Pinjaman',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                'Pinjaman',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Jumlah yang diajukan',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                loanData != null && loanData!.jumlahPinjamanPengajuan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(loanData!.jumlahPinjamanPengajuan!)).replaceAll(',', '.')}" : 'Unknown',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Biaya admin',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                loanData != null && loanData!.biayaAdminAmount != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(loanData!.biayaAdminAmount!)).replaceAll(',', '.')}" : 'Unknown',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Periode',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                loanData != null && loanData!.jangkaWaktu != null ? '${loanData!.jangkaWaktu} Bulan' : 'Unknown',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Jumlah yang diterima',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                loanData != null && loanData!.jumlahPinjamanDiterima != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(loanData!.jumlahPinjamanDiterima!)).replaceAll(',', '.')}" : 'Unknown',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pembayaran Pinjaman Bulanan',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                loanData != null && loanData!.bayarBulanan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(loanData!.bayarBulanan!)).replaceAll(',', '.')}" : 'Unknown',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          dueDate != null && DateTime.now().isAfter(dueDate!) == true ?
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Denda Keterlambatan',
                                  style: STextStyles.regular(),
                                ),
                                Text(
                                  'Rp 100.000',
                                  style: STextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ),
                              ],
                            ),
                          ) :
                          const Material(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  loanData != null && loanData!.status == true ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Di transfer ke',
                                style: STextStyles.regular(),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/dipay_logo_only.png',
                                      fit: BoxFit.contain,
                                      width: 25.0,
                                      height: 25.0,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      name ?? 'Unknown User',
                                      style: STextStyles.medium(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ) :
                  const Material(),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Jadwal Pembayaran',
                            style: MTextStyles.medium(),
                          ),
                          Divider(
                            color: NeutralColorStyles.neutral03(),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: loanData != null && loanData!.peminjamanDetails != null ? loanData!.peminjamanDetails!.length : 0,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return separatorIndex < loanData!.peminjamanDetails!.length ?
                              const SizedBox(
                                height: 15.0,
                              ) :
                              const Material();
                            },
                            itemBuilder: (BuildContext listContext, int index) {
                              bool paidOff = loanData!.peminjamanDetails![index].status ?? false;

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  paidOff == true ?
                                  Icon(
                                    Icons.check_circle,
                                    size: 20.0,
                                    color: SuccessColorStyles.successMain(),
                                  ) :
                                  Container(
                                    width: 18.0,
                                    height: 18.0,
                                    margin: const EdgeInsets.only(left: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: BorderColorStyles.borderStrokes(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: paidOff == true ? SuccessColorStyles.successMain() : NeutralColorStyles.neutral03(),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '${index + 1}/${loanData!.peminjamanDetails!.length} ${paidOff == true ? 'Paid' : 'To Pay'}',
                                        style: XSTextStyles.regular().copyWith(
                                          color: paidOff == true ? Colors.white : XSTextStyles.regular().color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       paidOff == true ?
                                  //       Padding(
                                  //         padding: const EdgeInsets.only(right: 15.0),
                                  //         child: Text(
                                  //           DateFormat('dd MMM yyyy').format(),
                                  //           style: XSTextStyles.regular(),
                                  //         ),
                                  //       ) :
                                  //       const Material(),
                                  //       Text(
                                  //         'Rp 1.118.594',
                                  //         style: STextStyles.medium(),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            loanData != null && loanData!.status == false ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    MoveToPage(
                      context: context,
                      target: LoanPaymentPage(loanData: loanData!),
                      callback: (callback) {
                        if(callback != null) {
                          BackFromThisPage(context: context, callbackData: callback).go();
                        }
                      },
                    ).go();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColorStyles.primaryMain(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Bayar Tagihan',
                      style: LTextStyles.medium().copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ) :
            const Material(),
          ],
        ),
      ),
    );
  }
}