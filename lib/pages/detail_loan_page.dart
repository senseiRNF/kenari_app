import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_payment_page.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class DetailLoanPage extends StatefulWidget {
  final Map? loanData;

  const DetailLoanPage({
    super.key,
    required this.loanData,
  });

  @override
  State<DetailLoanPage> createState() => _DetailLoanPageState();
}

class _DetailLoanPageState extends State<DetailLoanPage> {
  String? name;

  DateTime? dueDate;

  @override
  void initState() {
    super.initState();

    loadData();

    if(widget.loanData != null) {
      if(widget.loanData!.values.elementAt(0).values.toList().length > 2) {
        setState(() {
          dueDate = widget.loanData!.values.elementAt(0).values.elementAt(2);
        });
      }
    }
  }

  Future loadData() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) {
      setState(() {
        name = nameResult;
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
                            widget.loanData != null && widget.loanData!.keys.elementAt(0) == true ? 'Detail Tagihan' : 'Detail Transaksi Pendanaan',
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
                            'Rp 1.118.594',
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
                                'Rp 3.000.000',
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
                                'Rp 30.000',
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
                                '${widget.loanData!.values.elementAt(0).values.elementAt(1)} Bulan',
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
                                'Rp 2.970.000',
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
                                'Rp 1.118.594',
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
                  widget.loanData != null && widget.loanData!.keys.elementAt(0) == false ?
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
                            itemCount: widget.loanData != null ? widget.loanData!.values.elementAt(0).values.elementAt(1) : 0,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return separatorIndex < widget.loanData!.values.elementAt(0).values.elementAt(1) ?
                              const SizedBox(
                                height: 15.0,
                              ) :
                              const Material();
                            },
                            itemBuilder: (BuildContext listContext, int index) {
                              bool paidOff = false;

                              if(widget.loanData!.values.elementAt(0).values.elementAt(0) > index) {
                                paidOff = true;
                              }

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
                                        paidOff == true ?
                                        '${index + 1}/${widget.loanData!.values.elementAt(0).values.elementAt(1)} Paid' :
                                        '${index + 1}/${widget.loanData!.values.elementAt(0).values.elementAt(1)} To Pay',
                                        style: XSTextStyles.regular().copyWith(
                                          color: paidOff == true ? Colors.white : XSTextStyles.regular().color,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        paidOff == true ?
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15.0),
                                          child: Text(
                                            DateFormat('dd MMM yyyy').format(dueDate!.subtract(Duration(days: ((widget.loanData!.values.elementAt(0).values.elementAt(1) - index) * 30)))),
                                            style: XSTextStyles.regular(),
                                          ),
                                        ) :
                                        const Material(),
                                        Text(
                                          'Rp 1.118.594',
                                          style: STextStyles.medium(),
                                        ),
                                      ],
                                    ),
                                  ),
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
            widget.loanData != null && widget.loanData!.keys.elementAt(0) == true ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    MoveToPage(
                      context: context,
                      target: LoanPaymentPage(loanData: widget.loanData!),
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
                        color: LTextStyles.regular().color,
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