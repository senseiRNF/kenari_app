import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_payment_result_page.dart';
import 'package:kenari_app/services/api/fee/api_temporal_fee_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_temporal_fee_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TemporalFeeDepositPage extends StatefulWidget {
  const TemporalFeeDepositPage({super.key});

  @override
  State<TemporalFeeDepositPage> createState() => _TemporalFeeDepositPageState();
}

class _TemporalFeeDepositPageState extends State<TemporalFeeDepositPage> {
  TextEditingController feeAmountController = TextEditingController();

  int? selectedTerm;
  late int dipayAmount;

  String? name;

  late bool isDipayActive;
  bool showUnmatchedAmountFee = false;
  bool showInsufficientAmountBalance = false;

  List<Map<int, String>> termList = [
    {1: '5.75'},
    {3: '6'},
    {6: '6.25'},
    {12: '7'},
    {18: '7.5'},
    {24: '8'},
  ];

  List<bool> randomActivation = [
    true,
    false,
  ];

  List<int> randomNumber = [
    5000,
    150000,
    500000,
    1000000,
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      dipayAmount = (randomNumber.toList()..shuffle()).first;
      isDipayActive = (randomActivation.toList()..shuffle()).first;

      if(dipayAmount < 100000) {
        showInsufficientAmountBalance = true;
      }
    });

    loadData();
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
                            'Setor Iuran Berjangka',
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffaeaeb2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Nama',
                                            style: XSTextStyles.regular(),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            name ?? 'Unknown User',
                                            style: STextStyles.medium().copyWith(
                                              color: TextColorStyles.textPrimary(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                thickness: 1.0,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Image.asset(
                                        'assets/images/dipay_logo_only.png',
                                        width: 25.0,
                                        height: 25.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Saldo Dipay',
                                            style: XSTextStyles.regular(),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            isDipayActive == true ? 'Rp ${NumberFormat('#,###', 'en_id').format(dipayAmount).replaceAll(',', '.')}' : 'Belum Aktif',
                                            style: STextStyles.medium().copyWith(
                                              color: TextColorStyles.textPrimary(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isDipayActive ?
                  showInsufficientAmountBalance ?
                  Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
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
                                  'Saldo Dipay Anda tidak cukup, silahkan isi ulang saldo Dipay Anda',
                                  style: XSTextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) :
                  const Material() :
                  Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
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
                              Text(
                                'Lakukan aktivasi pada akun Dipay anda.',
                                style: XSTextStyles.medium().copyWith(
                                  color: DangerColorStyles.dangerMain(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: termList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: selectedTerm == termList[index].keys.elementAt(0) ?
                              PrimaryColorStyles.primaryMain() :
                              BorderColorStyles.borderStrokes(),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTerm = termList[index].keys.elementAt(0);
                                });
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${termList[index].keys.elementAt(0)} Bulan',
                                    style: selectedTerm == termList[index].keys.elementAt(0) ?
                                    STextStyles.medium().copyWith(
                                      color: TextColorStyles.textPrimary(),
                                      fontWeight: FontWeight.bold,
                                    ) :
                                    STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '(${termList[index].values.elementAt(0)}%)',
                                    style: selectedTerm == termList[index].keys.elementAt(0) ?
                                    STextStyles.medium().copyWith(
                                      color: TextColorStyles.textPrimary(),
                                      fontWeight: FontWeight.bold,
                                    ) :
                                    STextStyles.regular(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Jumlah Iuran',
                          style: STextStyles.medium(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          controller: feeAmountController,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Text("Rp "),
                            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                            hintText: '0',
                            errorText: showUnmatchedAmountFee ? 'Minimal kelipatan Rp 100.000' : null,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (newData) {
                            setState(() {
                              if(newData != '') {
                                if(int.parse(newData) % 100000 != 0) {
                                  setState(() {
                                    showUnmatchedAmountFee = true;
                                  });
                                } else {
                                  setState(() {
                                    showUnmatchedAmountFee = false;
                                  });

                                  if(dipayAmount < int.parse(newData)) {
                                    setState(() {
                                      showInsufficientAmountBalance = true;
                                    });
                                  } else {
                                    setState(() {
                                      showInsufficientAmountBalance = false;
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  showUnmatchedAmountFee = false;
                                  showInsufficientAmountBalance = false;
                                });
                              }
                            });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Estimasi saldo akhir sebelum pajak',
                          style: STextStyles.regular(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(feeAmountController.text != '' ? feeAmountController.text : '0')).replaceAll(',', '.')}',
                          style: MTextStyles.medium().copyWith(
                            color: TextColorStyles.textPrimary(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(isDipayActive == true && showUnmatchedAmountFee == false && showInsufficientAmountBalance == false && selectedTerm != null) {
                      showFeeDetailBottomDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDipayActive == true && showUnmatchedAmountFee == false && showInsufficientAmountBalance == false && selectedTerm != null ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Setor',
                      style: LTextStyles.medium().copyWith(
                        color: isDipayActive == true && showUnmatchedAmountFee == false && showInsufficientAmountBalance == false && selectedTerm != null ? LTextStyles.regular().color : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showFeeDetailBottomDialog() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        String yearlyReturnPercentage = '0';

        for(int i = 0; i < termList.length; i++) {
          if(selectedTerm != null && selectedTerm == termList[i].keys.elementAt(0)) {
            yearlyReturnPercentage = termList[i].values.elementAt(0);
          }
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: 5.0,
                width: 60.0,
                color: NeutralColorStyles.neutral04(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Rincian Iuran',
                style: STextStyles.medium().copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah Iuran',
                    style: STextStyles.regular(),
                  ),
                  Text(
                    'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(feeAmountController.text != '' ? feeAmountController.text : '0')).replaceAll(',', '.')}',
                    style: STextStyles.medium().copyWith(
                      color: TextColorStyles.textPrimary(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jangka Waktu',
                    style: STextStyles.regular(),
                  ),
                  Text(
                    '$selectedTerm Bulan',
                    style: STextStyles.medium().copyWith(
                      color: TextColorStyles.textPrimary(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Imbal hasil pertahun',
                    style: STextStyles.regular(),
                  ),
                  Text(
                    '$yearlyReturnPercentage %',
                    style: STextStyles.medium().copyWith(
                      color: TextColorStyles.textPrimary(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal Pencairan',
                    style: STextStyles.regular(),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy').format(DateTime.now().add(const Duration(days: 30))),
                    style: STextStyles.medium().copyWith(
                      color: TextColorStyles.textPrimary(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                height: 1.0,
                thickness: 1.0,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pembayaran',
                    style: STextStyles.regular(),
                  ),
                  Text(
                    'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(feeAmountController.text != '' ? feeAmountController.text : '0')).replaceAll(',', '.')}',
                    style: STextStyles.medium().copyWith(
                      color: TextColorStyles.textPrimary(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pembayaran',
                    style: STextStyles.regular(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                        child: Image.asset(
                          'assets/images/dipay_logo_only.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Dipay',
                        style: MTextStyles.medium().copyWith(
                          color: TextColorStyles.textPrimary(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                onPressed: () {
                  BackFromThisPage(context: context, callbackData: true).go();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColorStyles.primaryMain(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Konfirmasi',
                    style: LTextStyles.medium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((result) async {
      if(result != null && result == true) {
        await LocalSharedPrefs().readKey('member_id').then((memberId) async {
          String yearlyReturnPercentage = '0';

          for(int i = 0; i < termList.length; i++) {
            if(selectedTerm != null && selectedTerm == termList[i].keys.elementAt(0)) {
              yearlyReturnPercentage = termList[i].values.elementAt(0);
            }
          }

          await APITemporalFeeServices(context: context).writeTransaction(LocalTemporalFeeData(memberId: memberId, amount: int.parse(feeAmountController.text), period: selectedTerm!, profit: double.parse(yearlyReturnPercentage), startDate: DateTime.now(), disbursementDate: DateTime.now().add(Duration(days: (30 * selectedTerm!))), paymentMethod: 'Dipay')).then((writeResult) {
            if(writeResult.apiResult == true) {
              MoveToPage(
                context: context,
                target: FeePaymentResultPage(
                  status: writeResult.apiResult,
                  transactionName: 'Iuran Berjangka',
                  transactionNumber: 'PAY0000000000001',
                  feeAmount: 'Rp ${NumberFormat('#,###').format(int.parse(feeAmountController.text != '' ? feeAmountController.text : '0')).replaceAll(',', '.')}',
                  date: DateTime.now(),
                ),
                callback: (callbackResult) {
                  if(callbackResult != null) {
                    BackFromThisPage(context: context, callbackData: callbackResult).go();
                  }
                },
              ).go();
            } else {
              OkDialog(context: context, message: 'Gagal mengirim permintaan, silahkan coba lagi').show();
            }
          });
        });
      }
    });
  }
}