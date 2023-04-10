import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/detail_loan_page.dart';
import 'package:kenari_app/pages/detail_mandatory_fee_page.dart';
import 'package:kenari_app/pages/detail_term_fee_page.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TransactionFragment extends StatefulWidget {
  final int openMenu;
  final Function changeTab;
  final Function onCallbackFromLoanPage;

  const TransactionFragment({
    super.key,
    required this.openMenu,
    required this.changeTab,
    required this.onCallbackFromLoanPage,
  });

  @override
  State<TransactionFragment> createState() => _TransactionFragmentState();
}

class _TransactionFragmentState extends State<TransactionFragment> with TickerProviderStateMixin {
  int selectedTab = 0;
  int selectedStatus = 0;

  String? name;
  String? companyCode;

  List<Map<bool, String>> feeTransactionList = [
    {true: 'wajib'},
    {true: 'berjangka'},
    {false: 'berjangka'},
  ];

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

  List<bool> orderTransactionList = [];

  late TabController tabController;

  List<Map<bool, Map?>> filterLoanTransactionList() {
    List<Map<bool, Map?>> result = [];

    bool convertStatus = selectedStatus == 0 ? true : false;

    for(int i = 0; i < loanTransactionList.length; i++) {
      if(loanTransactionList[i].keys.elementAt(0) == convertStatus) {
        result.add(loanTransactionList[i]);
      }
    }

    return result;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      tabController = TabController(length: 3, vsync: this);
    });

    loadData();
  }

  Future loadData() async {
    setState(() {
      selectedTab = widget.openMenu;
      tabController.animateTo(widget.openMenu);
    });

    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        name = nameResult;
      });

      await LocalSharedPrefs().readKey('company_code').then((codeResult) {
        setState(() {
          companyCode = codeResult;
        });
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
              padding: const EdgeInsets.only(top: 15.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TabBar(
                      controller: tabController,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: PrimaryColorStyles.primaryMain(),
                        ),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                      ),
                      onTap: (index) {
                        setState(() {
                          selectedTab = index;
                        });

                        widget.changeTab(index);
                      },
                      tabs: [
                        Tab(
                          child: Text(
                            'Iuran',
                            style: MTextStyles.medium().copyWith(
                              color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Pendanaan',
                            style: MTextStyles.medium().copyWith(
                              color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Pesanan',
                            style: MTextStyles.medium().copyWith(
                              color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1.0,
                      color: BorderColorStyles.borderDivider(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedStatus == 0 ? Colors.white : null,
                        border: Border.all(
                          color: selectedStatus == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if(selectedStatus != 0) {
                            setState(() {
                              selectedStatus = 0;
                            });
                          }
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Aktif',
                            style: selectedStatus == 0 ? STextStyles.medium() : STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedStatus == 1 ? Colors.white : null,
                        border: Border.all(
                          color: selectedStatus == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if(selectedStatus != 1) {
                            setState(() {
                              selectedStatus = 1;
                            });
                          }
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Selesai',
                            style: selectedStatus == 1 ? STextStyles.medium() : STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: activeList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget activeList() {
    switch(selectedTab) {
      case 0:
        return feeTransactionList.isNotEmpty ?
        ListView.builder(
          itemCount: feeTransactionList.length,
          itemBuilder: (BuildContext listContext, int index) {
            bool convertStatus = selectedStatus == 0 ? true : false;

            String type = feeTransactionList[index].values.elementAt(0) == 'wajib' ? 'Iuran Wajib' : 'Iuran Berjangka';
            String amount = feeTransactionList[index].values.elementAt(0) == 'wajib' ? 'Rp 1.200.000' : 'Rp 100.000';

            return feeTransactionList[index].keys.elementAt(0) == convertStatus ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text(
                    type,
                    style: XSTextStyles.regular(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if(feeTransactionList[index].values.elementAt(0) == 'wajib') {
                          MoveToPage(context: context, target: const DetailMandatoryFeePage()).go();
                        } else {
                          MoveToPage(context: context, target: DetailTermFeePage(title: '$type $index', feeId: 'fee_id', status: convertStatus)).go();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$type $index',
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                                Text(
                                  amount,
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              companyCode ?? 'Unknown Company',
                              style: XSTextStyles.regular(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'a.n ${name ?? 'Unknown User'}',
                              style: XSTextStyles.regular(),
                            ),
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
        ) :
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/icon_transaction_empty.png',
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Belum Ada Transaksi',
                    style: HeadingTextStyles.headingS(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Yuk mulai transaksi Iuranmu\nmelalui aplikasi Kenari!',
                    style: MTextStyles.regular(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView(),
            ),
          ],
        );
      case 1:
        return loanTransactionList.isNotEmpty ?
        ListView.separated(
          itemCount: filterLoanTransactionList().length,
          separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Divider(
                height: 1.0,
                color: BorderColorStyles.borderDivider(),
              ),
            );
          },
          itemBuilder: (BuildContext listContext, int index) {
            String? periode;
            DateTime? dueDate;

            if(filterLoanTransactionList()[index].values.elementAt(0) != null) {
              periode = '${filterLoanTransactionList()[index].values.elementAt(0)!.values.elementAt(0)}/${filterLoanTransactionList()[index].values.elementAt(0)!.values.elementAt(1)}';

              if(filterLoanTransactionList()[index].values.elementAt(0)!.values.length > 2) {
                dueDate = filterLoanTransactionList()[index].values.elementAt(0)!.values.elementAt(2);
              }
            }

            return Container(
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    MoveToPage(
                      context: context,
                      target: DetailLoanPage(
                        loanData: filterLoanTransactionList()[index],
                      ),
                      callback: (callback) {
                        widget.onCallbackFromLoanPage(callback);
                      },
                    ).go();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pendanaan ${index + 1}',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            Text(
                              'Rp 3.000.000',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${periode ?? 'Unknown'} Periode',
                              style: STextStyles.regular(),
                            ),
                            filterLoanTransactionList()[index].keys.elementAt(0) == true ?
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: WarningColorStyles.warningSurface(),
                                border: Border.all(
                                  color: WarningColorStyles.warningBorder(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Pendanaan Berjalan',
                                style: STextStyles.medium().copyWith(
                                  color: WarningColorStyles.warningMain(),
                                ),
                              ),
                            ) :
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: SuccessColorStyles.successSurface(),
                                border: Border.all(
                                  color: SuccessColorStyles.successBorder(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Selesai',
                                style: STextStyles.medium().copyWith(
                                  color: SuccessColorStyles.successMain(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        filterLoanTransactionList()[index].keys.elementAt(0) == true ?
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DateTime.now().isBefore(dueDate!) || DateTime.now().isAtSameMomentAs(dueDate) == true ?
                              Text(
                                'Jatuh Tempo ${DateFormat('dd MMM yyyy').format(dueDate)}',
                                style: XSTextStyles.medium().copyWith(
                                  color: DangerColorStyles.dangerMain(),
                                ),
                              ) :
                              Text(
                                'Terlambat ${DateFormat('dd MMM yyyy').format(dueDate)}',
                                style: XSTextStyles.medium().copyWith(
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
              ),
            );
          },
        ) :
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/icon_transaction_empty.png',
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Belum Ada Transaksi',
                    style: HeadingTextStyles.headingS(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Yuk mulai transaksi Iuranmu\nmelalui aplikasi Kenari!',
                    style: MTextStyles.regular(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView(),
            ),
          ],
        );
      case 2:
        return orderTransactionList.isNotEmpty ?
        ListView.builder(
          itemCount: orderTransactionList.length,
          itemBuilder: (BuildContext listContext, int index) {
            bool convertStatus = selectedStatus == 0 ? true : false;

            return orderTransactionList[index] == convertStatus ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Text(
                    'Unknown Order',
                    style: XSTextStyles.regular(),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Unknown',
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                                Text(
                                  'Unknown Amount',
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              companyCode ?? 'Unknown Company',
                              style: XSTextStyles.regular(),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'a.n ${name ?? 'Unknown User'}',
                              style: XSTextStyles.regular(),
                            ),
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
        ) :
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/icon_transaction_empty.png',
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    'Belum Ada Transaksi',
                    style: HeadingTextStyles.headingS(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Yuk mulai transaksi Iuranmu\nmelalui aplikasi Kenari!',
                    style: MTextStyles.regular(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView(),
            ),
          ],
        );
      default:
        return const Material();
    }
  }
}