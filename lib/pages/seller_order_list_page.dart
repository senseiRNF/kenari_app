import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/miscellaneous/status_color_functions.dart';
import 'package:kenari_app/pages/seller_order_detail_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/seller_order_model.dart';
import 'package:kenari_app/services/api/seller_order_services/api_seller_order_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerOrderListPage extends StatefulWidget {
  const SellerOrderListPage({super.key});

  @override
  State<SellerOrderListPage> createState() => _SellerOrderListPageState();
}

class _SellerOrderListPageState extends State<SellerOrderListPage> {
  int selectedTab = 0;

  List<SellerOrderData> sellerOrderList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    String? status;

    switch(selectedTab) {
      case 0:
        status = null;
        break;
      case 1:
        status = 'waiting';
        break;
      case 2:
        status = 'on proccess';
        break;
      case 3:
        status = 'ready to pickup';
        break;
      case 4:
        status = 'done';
        break;
      case 5:
        status = 'canceled';
        break;
      default:
        status = null;
        break;
    }

    await APISellerOrderServices(context: context).callAll(status).then((callResult) {
      if(callResult != null && callResult.sellerOrderData != null) {
        List<SellerOrderData> tempSellerOrderList = [];

        for(int i = 0; i < callResult.sellerOrderData!.length; i++) {
          tempSellerOrderList.add(callResult.sellerOrderData![i]);
        }

        setState(() {
          sellerOrderList = tempSellerOrderList;
        });
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
                length: 6,
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

                    loadData();
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
                        'Diproses',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Siap Diambil',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 3 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Selesai',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 4 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Dibatalkan',
                        style: MTextStyles.medium().copyWith(
                          color: selectedTab == 5 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
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
                onRefresh: () async => loadData(),
                child: sellerOrderList.isNotEmpty ?
                ListView.builder(
                  itemCount: sellerOrderList.length,
                  itemBuilder: (BuildContext newOrderContext, int newOrderIndex) {
                    return Container(
                      color: Colors.white,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            MoveToPage(
                              context: context,
                              target: SellerOrderDetailPage(sellerOrderId: sellerOrderList[newOrderIndex].sId),
                              callback: (callbackResult) {
                                loadData();
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
                                      sellerOrderList[newOrderIndex].transactionNo ?? '(Nomor tidak diketahui)',
                                      style: STextStyles.medium(),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        color: checkStatusColor(sellerOrderList[newOrderIndex].status).surface,
                                        border: Border.all(
                                          color: checkStatusColor(sellerOrderList[newOrderIndex].status).border,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        sellerOrderList[newOrderIndex].remark ?? '(Status tidak diketahui)',
                                        style: STextStyles.medium().copyWith(
                                          color: checkStatusColor(sellerOrderList[newOrderIndex].status).main,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                sellerOrderList[newOrderIndex].orderDetails != null && sellerOrderList[newOrderIndex].orderDetails!.isNotEmpty ?
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: "$baseURL/${sellerOrderList[newOrderIndex].orderDetails != null &&
                                          sellerOrderList[newOrderIndex].orderDetails!.isNotEmpty &&
                                          sellerOrderList[newOrderIndex].orderDetails![0].product != null &&
                                          sellerOrderList[newOrderIndex].orderDetails![0].product!.images != null &&
                                          sellerOrderList[newOrderIndex].orderDetails![0].product!.images!.isNotEmpty ?
                                      sellerOrderList[newOrderIndex].orderDetails![0].product!.images![0].url ?? '' : ''
                                      }",
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
                                                'Tidak dapat memuat gambar',
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
                                            sellerOrderList[newOrderIndex].orderDetails![0].product != null ? sellerOrderList[newOrderIndex].orderDetails![0].product!.name ?? '(Produk tidak diketahui)' : '(Produk tidak diketahui)',
                                            style: MTextStyles.regular(),
                                          ),
                                          sellerOrderList[newOrderIndex].orderDetails![0].varianName != null ?
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                sellerOrderList[newOrderIndex].orderDetails![0].varianName ?? '',
                                                style: XSTextStyles.regular(),
                                              ),
                                            ],
                                          ) :
                                          const Material(),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerOrderList[newOrderIndex].orderDetails![0].price ?? '0')).replaceAll(',', '.')}',
                                                style: MTextStyles.medium(),
                                              ),
                                              Text(
                                                'x${sellerOrderList[newOrderIndex].orderDetails![0].qty}',
                                                style: MTextStyles.regular(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ) :
                                const Material(),
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
                                        '1 Hari',
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
                                      'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerOrderList[newOrderIndex].totalAmount ?? '0')).replaceAll(',', '.')}',
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