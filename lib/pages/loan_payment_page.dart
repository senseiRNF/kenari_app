import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_payment_result_page.dart';
import 'package:kenari_app/services/api/models/loan_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanPaymentPage extends StatefulWidget {
  final LoanData loanData;

  const LoanPaymentPage({
    super.key,
    required this.loanData,
  });

  @override
  State<LoanPaymentPage> createState() => _LoanPaymentPageState();
}

class _LoanPaymentPageState extends State<LoanPaymentPage> {
  late DateTime dueDate;

  late int dipayAmount;

  List<int> randomNumber = [
    50000,
    5000000,
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      dipayAmount = (randomNumber.toList()..shuffle()).first;

      if(widget.loanData.jatuhTempo != null) {
        dueDate = DateTime.parse(widget.loanData.jatuhTempo!);
      }
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
                            'Payment Summary',
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
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Jatuh Tempo',
                              style: STextStyles.regular(),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(dueDate),
                              style: STextStyles.medium().copyWith(
                                color: DangerColorStyles.dangerMain(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Pembayaran',
                              style: STextStyles.regular(),
                            ),
                            Text(
                              'Rp 1.118.594',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Denda Keterlambatan',
                              style: STextStyles.regular(),
                            ),
                            Text(
                              DateTime.now().isAfter(dueDate) == true ? 'Rp 100.000' : 'Rp 0',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(
                            height: 1.0,
                            color: BorderColorStyles.borderDivider(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total',
                              style: STextStyles.regular(),
                            ),
                            Text(
                              DateTime.now().isAfter(dueDate) == true ? 'Rp 1.218.594' : 'Rp Rp 1.118.594',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: STextStyles.regular(),
                            ),
                            Text(
                              'Saldo Dipay',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/dipay_logo_only.png',
                                    width: 25.0,
                                    height: 25.0,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Dipay',
                                    style: MTextStyles.regular(),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Rp ${NumberFormat('#,###', 'en_id').format(dipayAmount).replaceAll(',', '.')}",
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        dipayAmount < 1000000 ?
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
                                  'Saldo Dipay Anda tidak cukup, silahkan isi ulang saldo Dipay Anda',
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
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(dipayAmount > 1000000) {
                      MoveToPage(
                        context: context,
                        target: const LoanPaymentResultPage(),
                        callback: (callback) {
                          BackFromThisPage(context: context, callbackData: callback).go();
                        },
                      ).go();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dipayAmount < 1000000 ? NeutralColorStyles.neutral04() : PrimaryColorStyles.primaryMain(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Konfirmasi',
                      style: LTextStyles.medium().copyWith(
                        color: dipayAmount < 1000000 ? Colors.black54 : Colors.white,
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
}