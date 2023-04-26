import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_detail_page.dart';
import 'package:kenari_app/services/api/loan_services/api_loan_services.dart';
import 'package:kenari_app/services/api/models/loan_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanListPage extends StatefulWidget {
  const LoanListPage({super.key});

  @override
  State<LoanListPage> createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  bool isNotPaidOff = true;

  double totalLoan = 0.0;

  List<LoanData> loanList = [];

  @override
  void initState() {
    super.initState();
    
    loadData();
  }

  Future loadData() async {
    await APILoanServices(context: context).callAll().then((callResult) {
      if(callResult != null) {
        setState(() {
          loanList = callResult.loanData ?? [];
        });

        double tempTotalLoan = 0;

        if(loanList.isNotEmpty) {
          for(int i = 0; i < loanList.length; i++) {
            if(loanList[i].status != null && loanList[i].status == false && loanList[i].bayarBulanan != null) {
              tempTotalLoan = tempTotalLoan + double.parse(loanList[i].bayarBulanan!);
            }
          }

          setState(() {
            totalLoan = tempTotalLoan;
          });
        }
      }
    });
  }

  List<LoanData> filteredData() {
    List<LoanData> result = [];

    if(loanList.isNotEmpty) {
      for(int i = 0; i < loanList.length; i++) {
        if(loanList[i].status == !isNotPaidOff) {
          result.add(loanList[i]);
        }
      }
    }

    return result;
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
                            'Pembayaran Pendanaan',
                            style: Theme.of(context).textTheme.headlineSmall,
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
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Rp ${NumberFormat('#,###', 'en_id').format(totalLoan).replaceAll(',', '.')}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontBodyWeight.medium(),
                    ),
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
                                    style: TextThemeXS.medium().copyWith(
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
                                    style: TextThemeXS.medium().copyWith(
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
              child: filteredData().isNotEmpty ?
              ListView.separated(
                itemCount: filteredData().length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  return Container(
                    color: Colors.white,
                    child: filteredData()[separatorIndex].status != null && filteredData()[separatorIndex].status == false ?
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
                  int countPaid = 0;

                  if(filteredData()[index].peminjamanDetails != null) {
                    for(int i = 0; i < filteredData()[index].peminjamanDetails!.length; i++) {
                      if(filteredData()[index].peminjamanDetails![i].status == true) {
                        countPaid = countPaid + 1;
                      }
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      index == 0 || index > 0 && filteredData()[index].createdAt != null && DateFormat('yyyy').format(DateTime.parse(filteredData()[index].createdAt!)) != DateFormat('yyyy').format(DateTime.parse(filteredData()[index - 1].createdAt!)) ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                        child: Text(
                          DateFormat('yyyy').format(DateTime.now()),
                          style: TextThemeXS.regular(),
                        ),
                      ) :
                      const Material(),
                      Container(
                        color: Colors.white,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if(loanList[index].sId != null) {
                                MoveToPage(context: context, target: LoanDetailPage(loanId: loanList[index].sId!)).go();
                              }
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
                                          'Pendanaan',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: TextColorStyles.textPrimary(),
                                            fontWeight: FontBodyWeight.medium(),
                                          ),
                                        ),
                                        Text(
                                          filteredData()[index].bayarBulanan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(double.parse(filteredData()[index].bayarBulanan!)).replaceAll(',', '.')}" : 'Unknown',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: TextColorStyles.textPrimary(),
                                            fontWeight: FontBodyWeight.medium(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '$countPaid/${filteredData()[index].jangkaWaktu} Telah dibayar',
                                    style: Theme.of(context).textTheme.bodySmall!,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  isNotPaidOff == true ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        filteredData()[index].jatuhTempo != null ? "Jatuh tempo ${DateFormat('dd MMM yyyy').format(DateTime.parse(filteredData()[index].jatuhTempo!))}" : 'Unknown',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  );
                },
              ) :
              Center(
                child: Text(
                  'Tidak ditemukan data yang cocok...',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontBodyWeight.medium(),
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