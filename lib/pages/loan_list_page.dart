import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanListPage extends StatefulWidget {
  const LoanListPage({super.key});

  @override
  State<LoanListPage> createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  bool isNotPaidOff = true;

  List<Map<bool, Map?>> loanTransactionList = [
    {
      true: {
        'month_paid_off': 2,
        'max_month': 3,
        'tempo': DateTime(2023, DateTime.now().month + 1, 29),
      },
    },
    {
      true: {
        'month_paid_off': 4,
        'max_month': 12,
        'tempo': DateTime(2023, DateTime.now().month - 1, 31),
      },
    },
    {
      false: {
        'month_paid_off': 6,
        'max_month': 6,
        'tempo': DateTime(2023, DateTime.now().month, DateTime.now().day),
      },
    },
  ];

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
                            'Pembayaran Pendanaan',
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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total Tagihan',
                    style: STextStyles.regular(),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Rp 1.487.094',
                    style: LTextStyles.medium(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: BorderColorStyles.borderStrokes(),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: isNotPaidOff == true ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isNotPaidOff = true;
                                });
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Text(
                                    'Belum Di bayar',
                                    style: XSTextStyles.medium().copyWith(
                                      color: isNotPaidOff == true ? TextColorStyles.textPrimary() : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: isNotPaidOff == false ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isNotPaidOff = false;
                                });
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Text(
                                    'Berhasil di bayar',
                                    style: XSTextStyles.medium().copyWith(
                                      color: isNotPaidOff == false ? TextColorStyles.textPrimary() : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: loanTransactionList.length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  bool isActive = isNotPaidOff;

                  return Container(
                    color: Colors.white,
                    child: loanTransactionList[separatorIndex].keys.elementAt(0) == isActive ?
                    Divider(
                      height: 1.0,
                      indent: 25.0,
                      endIndent: 25.0,
                      color: NeutralColorStyles.neutral05(),
                    ) :
                    const Material(),
                  );
                },
                itemBuilder: (BuildContext listContext, int index) {
                  bool isActive = isNotPaidOff;

                  return loanTransactionList[index].keys.elementAt(0) == isActive ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      index == 0 ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                        child: Text(
                          DateFormat('yyyy').format(DateTime.now()),
                          style: XSTextStyles.regular(),
                        ),
                      ) :
                      const Material(),
                      Container(
                        color: Colors.white,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              BackFromThisPage(context: context, callbackData: loanTransactionList[index]).go();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Pendanaan ${index + 1}',
                                          style: MTextStyles.medium().copyWith(
                                            color: TextColorStyles.textPrimary(),
                                          ),
                                        ),
                                        Text(
                                          'Rp 1.118.594',
                                          style: STextStyles.medium().copyWith(
                                            color: TextColorStyles.textPrimary(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    isNotPaidOff == true ? '2/3 Telah dibayar' : '3/3 Telah dibayar',
                                    style: STextStyles.regular(),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                   isNotPaidOff == true ?
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     children: [
                                       Text(
                                         "Jatuh tempo ${DateFormat('dd MMM yyyy').format(loanTransactionList[index].values.elementAt(0)!.values.elementAt(2))}",
                                         style: STextStyles.regular().copyWith(
                                           color: DangerColorStyles.dangerMain(),
                                         ),
                                       ),
                                       const SizedBox(
                                         height: 10.0,
                                       ),
                                     ],
                                   ) :
                                   const Material(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) :
                  const Material();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}