import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/loan_detail_page.dart';
import 'package:kenari_app/pages/mandatory_fee_detail_page.dart';
import 'package:kenari_app/pages/temporal_fee_detail_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
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
  int feeTabIndex = 0;
  int loanTabIndex = 0;
  int orderTabIndex = 0;

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

  List<Map> filteredFeeData() {
    List<Map> result = [];

    bool temporalFeeStatus = feeTabIndex == 0 ? true : false;
    bool mandatoryFeeStatus = feeTabIndex == 0 ? true : false;

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

  List<LoanData> filteredLoanData() {
    List<LoanData> result = [];

    bool isActiveStatus = feeTabIndex == 0 ? true : false;

    if(loanList.isNotEmpty) {
      for(int i = 0; i < loanList.length; i++) {
        if(loanList[i].status == !isActiveStatus) {
          result.add(loanList[i]);
        }
      }
    }

    return result;
  }

  List<TransactionOrderData> filteredOrderData() {
    List<TransactionOrderData> result = [];

    if(transactionOrderList.isNotEmpty) {
      for(int i = 0; i < transactionOrderList.length; i++) {
        if(transactionOrderList[i].status != null) {
          if(orderTabIndex == 0) {
            result.add(transactionOrderList[i]);
          } else if(orderTabIndex == 1) {
            if(transactionOrderList[i].status == 'waiting') {
              result.add(transactionOrderList[i]);
            }
          } else if (orderTabIndex == 2) {
            if(transactionOrderList[i].status == 'processed') {
              result.add(transactionOrderList[i]);
            }
          } else if (orderTabIndex == 3) {
            if(transactionOrderList[i].status == 'completed') {
              result.add(transactionOrderList[i]);
            }
          } else if (orderTabIndex == 4) {
            if(transactionOrderList[i].status == 'cancelled') {
              result.add(transactionOrderList[i]);
            }
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
                          style: selectedTab == 0 ?
                          MTextStyles.medium().copyWith(
                            color: PrimaryColorStyles.primaryMain(),
                          ) :
                          STextStyles.medium(),
                        ),
                      ),
                      Tab(
                        child: Wrap(
                          children: [
                            Text(
                              'Pinjaman',
                              style: selectedTab == 1 ?
                              MTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ) :
                              STextStyles.medium(),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Pesanan',
                          style: selectedTab == 2 ?
                          MTextStyles.medium().copyWith(
                            color: PrimaryColorStyles.primaryMain(),
                          ) :
                          STextStyles.medium(),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: feeTabIndex == 0 ? Colors.white : null,
                    border: Border.all(
                      color: feeTabIndex == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(feeTabIndex != 0) {
                        setState(() {
                          feeTabIndex = 0;
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
                        style: feeTabIndex == 0 ? STextStyles.medium() : STextStyles.regular(),
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
                    color: feeTabIndex == 1 ? Colors.white : null,
                    border: Border.all(
                      color: feeTabIndex == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(feeTabIndex != 1) {
                        setState(() {
                          feeTabIndex = 1;
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
                        style: feeTabIndex == 1 ? STextStyles.medium() : STextStyles.regular(),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: loanTabIndex == 0 ? Colors.white : null,
                    border: Border.all(
                      color: loanTabIndex == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(loanTabIndex != 0) {
                        setState(() {
                          loanTabIndex = 0;
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
                        style: loanTabIndex == 0 ? STextStyles.medium() : STextStyles.regular(),
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
                    color: loanTabIndex == 1 ? Colors.white : null,
                    border: Border.all(
                      color: loanTabIndex == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(loanTabIndex != 1) {
                        setState(() {
                          loanTabIndex = 1;
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
                        style: loanTabIndex == 1 ? STextStyles.medium() : STextStyles.regular(),
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
                          color: orderTabIndex == index ? Colors.white : null,
                          border: Border.all(
                            color: orderTabIndex == index ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                orderTabIndex = index;
                              });
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  index == 0 ? 'Semua' : index == 1 ? 'Menunggu Konfirmasi Penjual' : index == 2 ? 'Diproses' : index == 3 ? 'Selesai' : index == 4 ? 'Gagal' : '(Tidak diketahui) Status',
                                  style: orderTabIndex == index ? STextStyles.medium() : STextStyles.regular(),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: feeTabIndex == 0 ? Colors.white : null,
                    border: Border.all(
                      color: feeTabIndex == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(feeTabIndex != 0) {
                        setState(() {
                          feeTabIndex = 0;
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
                        style: feeTabIndex == 0 ? STextStyles.medium() : STextStyles.regular(),
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
                    color: feeTabIndex == 1 ? Colors.white : null,
                    border: Border.all(
                      color: feeTabIndex == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(feeTabIndex != 1) {
                        setState(() {
                          feeTabIndex = 1;
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
                        style: feeTabIndex == 1 ? STextStyles.medium() : STextStyles.regular(),
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
                      filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : '(Tidak diketahui)',
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
                                    filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : '(Tidak diketahui)',
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
                                companyCode ?? '(Nama perusahaan tidak terdaftar)',
                                style: XSTextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'a.n ${name ?? '(Pengguna tidak diketahui)'}',
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
        return filteredLoanData().isNotEmpty ?
        RefreshIndicator(
          onRefresh: () async {
            loadLoanData();
          },
          child: ListView.separated(
            itemCount: filteredLoanData().length,
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
                      if(filteredLoanData()[index].sId != null) {
                        MoveToPage(
                          context: context,
                          target: LoanDetailPage(
                            loanId: filteredLoanData()[index].sId!,
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
                                'Pinjaman',
                                style: STextStyles.medium().copyWith(
                                  color: TextColorStyles.textPrimary(),
                                ),
                              ),
                              Text(
                                filteredLoanData()[index].jumlahPinjamanPengajuan != null ? "Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredLoanData()[index].jumlahPinjamanPengajuan!)).replaceAll(',', '.')}" : '(Tidak diketahui)',
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
                                filteredLoanData()[index].jangkaWaktu != null ? '${filteredLoanData()[index].jangkaWaktu} Bulan' : '(Tidak diketahui)',
                                style: STextStyles.regular(),
                              ),
                              filteredLoanData()[index].status == false ?
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
                                  'Pinjaman Berjalan',
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
                          filteredLoanData()[index].status == false ?
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: filteredLoanData()[index].jatuhTempo != null ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DateTime.now().isBefore(DateTime.parse(filteredLoanData()[index].jatuhTempo!)) || DateTime.now().isAtSameMomentAs(DateTime.parse(filteredLoanData()[index].jatuhTempo!)) == true ?
                                Text(
                                  'Jatuh Tempo ${DateFormat('dd MMM yyyy').format(DateTime.parse(filteredLoanData()[index].jatuhTempo!))}',
                                  style: XSTextStyles.medium().copyWith(
                                    color: DangerColorStyles.dangerMain(),
                                  ),
                                ) :
                                Text(
                                  'Terlambat ${DateFormat('dd MMM yyyy').format(DateTime.parse(filteredLoanData()[index].jatuhTempo!))}',
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
        return filteredOrderData().isNotEmpty ?
        RefreshIndicator(
          onRefresh: () async {
            loadTransactionData();
          },
          child: ListView.separated(
            itemCount: filteredOrderData().length,
            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemBuilder: (BuildContext listContext, int index) {
              late String status;

              switch(filteredOrderData()[index].status) {
                case 'waiting':
                  status = 'Menunggu Konfirmasi Penjual';
                  break;
                default:
                  status = '(Tidak diketahui)';
                  break;
              }

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
                              Expanded(
                                child: Text(
                                  filteredOrderData()[index].transactionNo ?? '(Tidak diketahui)',
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: WarningColorStyles.warningSurface(),
                                  border: Border.all(
                                    color: WarningColorStyles.warningBorder(),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  status,
                                  style: STextStyles.medium().copyWith(
                                    color: WarningColorStyles.warningMain(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          filteredOrderData()[index].orderDetails != null && filteredOrderData()[index].orderDetails!.isNotEmpty ?
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: "$baseURL/${filteredOrderData()[index].orderDetails![0].product != null && filteredOrderData()[index].orderDetails![0].product!.images != null && filteredOrderData()[index].orderDetails![0].product!.images!.isNotEmpty && filteredOrderData()[index].orderDetails![0].product!.images![0].url != null ? filteredOrderData()[index].orderDetails![0].product!.images![0].url! : ''}",
                                imageBuilder: (context, imgProvider) {
                                  return Container(
                                    width: 65.0,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: imgProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return SizedBox(
                                    width: 65.0,
                                    height: 65.0,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Icon(
                                          Icons.broken_image_outlined,
                                          color: IconColorStyles.iconColor(),
                                        ),
                                        Text(
                                          'Unable to load image',
                                          style: XSTextStyles.medium(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      filteredOrderData()[index].orderDetails![0].product != null && filteredOrderData()[index].orderDetails![0].product!.name != null ? filteredOrderData()[index].orderDetails![0].product!.name! : '(Produk tidak diketahui)',
                                      style: MTextStyles.medium(),
                                    ),
                                    filteredOrderData()[index].orderDetails![0].varianName != null ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          filteredOrderData()[index].orderDetails![0].varianName ?? '(Varian tidak diketahui)',
                                          style: STextStyles.regular(),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ) :
                                    const SizedBox(
                                      height: 25.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredOrderData()[index].orderDetails != null && filteredOrderData()[index].orderDetails![0].price != null && filteredOrderData()[index].orderDetails![0].price != '' ? filteredOrderData()[index].orderDetails![0].price! : '0')).replaceAll(',', '.')}',
                                          style: MTextStyles.medium().copyWith(
                                            color: PrimaryColorStyles.primaryMain(),
                                          ),
                                        ),
                                        Text(
                                          '${filteredOrderData()[index].orderDetails != null && filteredOrderData()[index].orderDetails![0].qty != null && filteredOrderData()[index].orderDetails![0].qty != '' ? filteredOrderData()[index].orderDetails![0].qty : '0'}x',
                                          style: MTextStyles.regular(),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ) :
                          const Material(),
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
                                '${filteredOrderData()[index].orderDetails != null && filteredOrderData()[index].orderDetails!.isNotEmpty ? filteredOrderData()[index].orderDetails!.length : '0'} Produk',
                                style: MTextStyles.medium(),
                              ),
                              Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(filteredOrderData()[index].orderDetails != null && filteredOrderData()[index].orderDetails!.isNotEmpty && filteredOrderData()[index].orderDetails![0].total != null && filteredOrderData()[index].orderDetails![0].total != '' ? filteredOrderData()[index].orderDetails![0].total! : '0')).replaceAll(',', '.')}',
                                style: MTextStyles.medium(),
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
                      filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : '(Tidak diketahui)',
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
                                    filteredFeeData()[index]['type'] == 'temporal' ? 'Iuran Berjangka' : filteredFeeData()[index]['type'] == 'mandatory' ? 'Iuran Wajib' : '(Tidak diketahui)',
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
                                companyCode ?? '(Nama perusahaan tidak terdaftar)',
                                style: XSTextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'a.n ${name ?? '(Pengguna tidak diketahui)'}',
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
    }
  }
}