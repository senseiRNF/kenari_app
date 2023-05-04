import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_detail_page.dart';
import 'package:kenari_app/pages/mandatory_fee_detail_page.dart';
import 'package:kenari_app/pages/temporal_fee_detail_page.dart';
import 'package:kenari_app/services/api/fee_services/api_mandatory_fee_services.dart';
import 'package:kenari_app/services/api/fee_services/api_temporal_fee_services.dart';
import 'package:kenari_app/services/api/loan_services/api_loan_services.dart';
import 'package:kenari_app/services/api/models/loan_model.dart';
import 'package:kenari_app/services/api/models/transaction_order_model.dart';
import 'package:kenari_app/services/api/transaction_services/api_transaction_services.dart';
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

  List<Map> feeList = [];
  List<LoanData> loanList = [];
  List<TransactionOrderData> transactionOrderList = [];

  late TabController tabController;

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

      if(widget.openMenu == 0) {
        loadFeeData();
      }

      if(widget.openMenu == 1) {
        loadLoanData();
      }

      if(widget.openMenu == 2) {
        loadTransactionData();
      }
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

  Future loadFeeData() async {
    List<Map> tempFeeList = [];

    await APITemporalFeeServices(context: context).callAll().then((temporalCallResult) async {
      if(temporalCallResult != null && temporalCallResult.temporalFeeData != null) {
        for(int i = 0; i < temporalCallResult.temporalFeeData!.length; i++) {
          tempFeeList.add({
            'type': 'temporal',
            'data': temporalCallResult.temporalFeeData![i],
          });
        }
      }

      await APIMandatoryFeeServices(context: context).callAll().then((mandatoryCallResult) {
        if(mandatoryCallResult != null && mandatoryCallResult.mandatoryFeeData != null) {
          for(int x = 0; x < mandatoryCallResult.mandatoryFeeData!.length; x++) {
            tempFeeList.add({
              'type': 'mandatory',
              'data': mandatoryCallResult.mandatoryFeeData![x],
            });
          }
        }
      });

      setState(() {
        feeList = tempFeeList;
      });
    });
  }

  Future loadLoanData() async {
    await APILoanServices(context: context).callAll().then((callResult) {
      if(callResult != null) {
        setState(() {
          loanList = callResult.loanData ?? [];
        });
      }
    });
  }

  Future loadTransactionData() async {
    await APITransactionServices(context: context).callAll().then((callResult) {
      if(callResult != null) {
        setState(() {
          transactionOrderList = callResult.transactionOrderData ?? [];
        });
      }
    });
  }

  List<LoanData> filterLoanData() {
    List<LoanData> result = [];

    bool isActiveStatus = selectedStatus == 0 ? true : false;

    if(loanList.isNotEmpty) {
      for(int i = 0; i < loanList.length; i++) {
        if(loanList[i].status == !isActiveStatus) {
          result.add(loanList[i]);
        }
      }
    }

    return result;
  }

  List<Map> filteredFeeData() {
    List<Map> result = [];

    bool temporalFeeStatus = selectedStatus == 0 ? true : false;
    bool mandatoryFeeStatus = selectedStatus == 0 ? true : false;

    if(feeList.isNotEmpty) {
      for(int i = 0; i < feeList.length; i++) {
        if(feeList[i]['type'] == 'mandatory') {
          if(feeList[i]['data'].status == !mandatoryFeeStatus) {
            result.add({
              'type': feeList[i]['type'],
              'data': feeList[i]['data'],
            });
          }
        } else if(feeList[i]['type'] == 'temporal') {
          if(feeList[i]['data'].statusPencairan == !temporalFeeStatus) {
            result.add({
              'type': feeList[i]['type'],
              'data': feeList[i]['data'],
            });
          }
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

                          switch(selectedTab) {
                            case 0:
                              loadFeeData();
                              break;
                            case 1:
                              loadLoanData();
                              break;
                            case 2:
                              loadTransactionData();
                              break;
                            default:
                              loadFeeData();
                              break;
                          }
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
            activeTabWidget(),
            Expanded(
              child: activeMainWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget activeTabWidget() {
    switch(selectedTab) {
      case 0:
        if(selectedStatus > 2) {
          setState(() {
            selectedStatus = 0;
          });
        }

        return Padding(
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
        );
      case 1:
        if(selectedStatus > 2) {
          setState(() {
            selectedStatus = 0;
          });
        }

        return Padding(
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
        );
      case 2:
        setState(() {
          selectedStatus = 0;
        });

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                      return const SizedBox(
                        width: 10.0,
                      );
                    },
                    itemBuilder: (BuildContext listContext, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: selectedStatus == index ? Colors.white : null,
                          border: Border.all(
                            color: selectedStatus == index ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedStatus = index;
                              });
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  index == 0 ? 'Semua' : index == 1 ? 'Menunggu Konfirmasi Penjual' : index == 2 ? 'Diproses' : index == 3 ? 'Selesai' : index == 4 ? 'Gagal' : 'Unknown Status',
                                  style: selectedStatus == index ? STextStyles.medium() : STextStyles.regular(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        setState(() {
          selectedStatus = 0;
        });

        return Padding(
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
        );
    }
  }

  Widget activeMainWidget() {
    switch(selectedTab) {
      case 0:
        return filteredFeeData().isNotEmpty ?
        RefreshIndicator(
          onRefresh: () async {
            loadFeeData();
          },
          child: ListView.builder(
            itemCount: filteredFeeData().length,
            itemBuilder: (BuildContext listContext, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Text(
                      filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : 'Unknown',
                      style: XSTextStyles.regular(),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if(filteredFeeData()[index]['type'] == 'temporal') {
                            MoveToPage(context: context, target: TemporalFeeDetailPage(temporalFeeId: filteredFeeData()[index]['data'].sId!)).go();
                          } else if(filteredFeeData()[index]['type'] == 'mandatory') {
                            MoveToPage(context: context, target: MandatoryFeeDetailPage(mandatoryFeeId: filteredFeeData()[index]['data'].sId!)).go();
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
                                    filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : 'Unknown',
                                    style: STextStyles.medium().copyWith(
                                      color: TextColorStyles.textPrimary(),
                                    ),
                                  ),
                                  Text(
                                    filteredFeeData()[index]['type'] == 'temporal' ?
                                    filteredFeeData()[index]['data'].jumlahIuran != null ? 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredFeeData()[index]['data'].jumlahIuran!))}' : 'Rp 0' :
                                    filteredFeeData()[index]['type'] == 'mandatory' ?
                                    filteredFeeData()[index]['data'].amount != null ? 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredFeeData()[index]['data'].amount!))}' : 'Rp 0' :
                                    'Rp 0',
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
              );
            },
          ),
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
                loadFeeData();
              },
              child: ListView(),
            ),
          ],
        );
      case 1:
        return filterLoanData().isNotEmpty ?
        RefreshIndicator(
          onRefresh: () async {
            loadLoanData();
          },
          child: ListView.separated(
            itemCount: filterLoanData().length,
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
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if(filterLoanData()[index].sId != null) {
                        MoveToPage(
                          context: context,
                          target: LoanDetailPage(
                            loanId: filterLoanData()[index].sId!,
                          ),
                          callback: (callback) {
                            widget.onCallbackFromLoanPage(callback);
                          },
                        ).go();
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
                                'Pendanaan',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                              Text(
                                filterLoanData()[index].jumlahPinjamanPengajuan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filterLoanData()[index].jumlahPinjamanPengajuan!)).replaceAll(',', '.')}" : 'Unknown',
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
                                filterLoanData()[index].jangkaWaktu != null ? '${filterLoanData()[index].jangkaWaktu} Bulan' : 'Unknown',
                                style: STextStyles.regular(),
                              ),
                              filterLoanData()[index].status == false ?
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
                          filterLoanData()[index].status == false ?
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: filterLoanData()[index].jatuhTempo != null ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DateTime.now().isBefore(DateTime.parse(filterLoanData()[index].jatuhTempo!)) || DateTime.now().isAtSameMomentAs(DateTime.parse(filterLoanData()[index].jatuhTempo!)) == true ?
                                Text(
                                  'Jatuh Tempo ${DateFormat('dd MMM yyyy').format(DateTime.parse(filterLoanData()[index].jatuhTempo!))}',
                                  style: XSTextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ) :
                                Text(
                                  'Terlambat ${DateFormat('dd MMM yyyy').format(DateTime.parse(filterLoanData()[index].jatuhTempo!))}',
                                  style: XSTextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ),
                              ],
                            ) :
                            const Material(),
                          ) :
                          const Material(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
                loadLoanData();
              },
              child: ListView(),
            ),
          ],
        );
      case 2:
        return transactionOrderList.isNotEmpty ?
        RefreshIndicator(
          onRefresh: () async {
            loadTransactionData();
          },
          child: ListView.builder(
            itemCount: transactionOrderList.length,
            itemBuilder: (BuildContext listContext, int index) {
              return Container(
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
                                transactionOrderList[index].transactionNo ?? 'Unknown',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                              Text(
                                transactionOrderList[index].status ?? 'Unknown Status',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
                loadTransactionData();
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