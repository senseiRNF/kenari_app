import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_order_detail_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerOrderListPage extends StatefulWidget {
  const SellerOrderListPage({super.key});

  @override
  State<SellerOrderListPage> createState() => _SellerOrderListPageState();
}

class _SellerOrderListPageState extends State<SellerOrderListPage> {
  int selectedTab = 0;

  List sellerOrderList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  List loadData() {
    List result = [];

    switch(selectedTab) {
      case 0:
        result = sellerOrderList;
        return result;
      case 1:
        for(int i = 0; i < sellerOrderList.length; i++) {
          if(sellerOrderList[i]['status'] == 'Konfirmasi Pesanan' || sellerOrderList[i]['status'] == 'Segera Siapkan Pesanan') {
            result.add(sellerOrderList[i]);
          }
        }

        return result;
      case 2:
        for(int i = 0; i < sellerOrderList.length; i++) {
          if(sellerOrderList[i]['status'] == 'Siap diambil Pembeli') {
            result.add(sellerOrderList[i]);
          }
        }

        return result;
      case 3:
        for(int i = 0; i < sellerOrderList.length; i++) {
          if(sellerOrderList[i]['status'] == 'Selesai') {
            result.add(sellerOrderList[i]);
          }
        }

        return result;
      case 4:
        for(int i = 0; i < sellerOrderList.length; i++) {
          if(sellerOrderList[i]['status'].toString().contains('Dibatalkan')) {
            result.add(sellerOrderList[i]);
          }
        }

        return result;
      default:
        return result;
    }
  }

  Map checkStatusColor(String status) {
    Map result = {};

    if(status == 'Konfirmasi Pesanan' || status == 'Segera Siapkan Pesanan') {
      result = {
        'surface': WarningColorStyles.warningSurface(),
        'border': WarningColorStyles.warningBorder(),
        'main': WarningColorStyles.warningMain(),
      };
    } else if(status == 'Siap diambil Pembeli') {
      result = {
        'surface': InfoColorStyles.infoSurface(),
        'border': InfoColorStyles.infoBorder(),
        'main': InfoColorStyles.infoMain(),
      };
    } else if(status == 'Selesai') {
      result = {
        'surface': SuccessColorStyles.successSurface(),
        'border': SuccessColorStyles.successBorder(),
        'main': SuccessColorStyles.successMain(),
      };
    } else {
      result = {
        'surface': DangerColorStyles.dangerSurface(),
        'border': DangerColorStyles.dangerBorder(),
        'main': DangerColorStyles.dangerMain(),
      };
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
                            'Penjualan',
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
              child: DefaultTabController(
                initialIndex: 0,
                length: 5,
                child: TabBar(
                  isScrollable: true,
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
                  },
                  padding: const EdgeInsets.only(left: 25.0),
                  tabs: [
                    Tab(
                      child: Text(
                        'Semua',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pesanan Baru',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Siap Diambil',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Selesai',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 3 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Dibatalkan',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 4 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {

                },
                child: loadData().isNotEmpty ?
                ListView.builder(
                  itemCount: loadData().length,
                  itemBuilder: (BuildContext newOrderContext, int newOrderIndex) {
                    return Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            MoveToPage(
                              context: context,
                              target: SellerOrderDetailPage(orderData: loadData()[newOrderIndex]),
                              callback: (callbackResult) {
                                setState(() {

                                });
                              },
                            ).go();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      loadData()[newOrderIndex]['order_no'],
                                      style: STextStyles.medium(),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: checkStatusColor(loadData()[newOrderIndex]['status'])['surface'],
                                        border: Border.all(
                                          color: checkStatusColor(loadData()[newOrderIndex]['status'])['border'],
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        loadData()[newOrderIndex]['status'],
                                        style: STextStyles.medium().copyWith(
                                          color: checkStatusColor(loadData()[newOrderIndex]['status'])['main'],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 65.0,
                                      height: 65.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            loadData()[newOrderIndex]['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            loadData()[newOrderIndex]['title'],
                                            style: MTextStyles.regular(),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            loadData()[newOrderIndex]['variant'],
                                            style: XSTextStyles.regular(),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Rp ${NumberFormat('#,###', 'en_id').format(loadData()[newOrderIndex]['price']).replaceAll(',', '.')}',
                                                style: MTextStyles.medium(),
                                              ),
                                              Text(
                                                'x${loadData()[newOrderIndex]['qty']}',
                                                style: MTextStyles.regular(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: InfoColorStyles.infoSurface(),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Batas Respon',
                                        style: STextStyles.regular(),
                                      ),
                                      Text(
                                        '${loadData()[newOrderIndex]['respond_limit']} Hari',
                                        style: STextStyles.medium().copyWith(
                                          color: InfoColorStyles.infoMain(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Divider(
                                    height: 1.0,
                                    thickness: 1.0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '1 Produk',
                                      style: MTextStyles.regular(),
                                    ),
                                    Text(
                                      'Rp ${NumberFormat('#,###', 'en_id').format(loadData()[newOrderIndex]['price'] * loadData()[newOrderIndex]['qty']).replaceAll(',', '.')}',
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
                ) :
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          child: Image.asset(
                            'assets/images/icon_seller_order_empty.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Belum Ada Pesanan',
                                style: HeadingTextStyles.headingS(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Yuk mulai tingkatin penjualanmu!',
                                style: MTextStyles.medium(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}