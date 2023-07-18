import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_detail_page.dart';
import 'package:kenari_app/services/api/models/seller_product_model.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductAdjustmentFormPage extends StatefulWidget {
  const SellerProductAdjustmentFormPage({super.key});

  @override
  State<SellerProductAdjustmentFormPage> createState() => _SellerProductAdjustmentFormPageState();
}

class _SellerProductAdjustmentFormPageState extends State<SellerProductAdjustmentFormPage> {
  int selectedTab = 0;

  List<SellerProductData> waitingList = [];
  List<SellerProductData> activeList = [];
  List<SellerProductData> completedList = [];

  List<SellerProductData> sellerProductDataList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    List<SellerProductData> tempSellerProductDataList = [];
    List<SellerProductData> tempWaitingList = [];
    List<SellerProductData> tempActiveList = [];
    List<SellerProductData> tempCompletedList = [];

    await APISellerProductServices(context: context).call().then((callResult) {
      if(callResult != null && callResult.sellerProductData != null) {
        for(int i = 0; i < callResult.sellerProductData!.length; i++) {
          tempSellerProductDataList.add(callResult.sellerProductData![i]);

          if(callResult.sellerProductData![i].verifyAt != null) {
            if(callResult.sellerProductData![i].status == true) {
              tempActiveList.add(callResult.sellerProductData![i]);
            } else {
              tempCompletedList.add(callResult.sellerProductData![i]);
            }
          } else {
            tempWaitingList.add(callResult.sellerProductData![i]);
          }
        }
      }
    });

    setState(() {
      sellerProductDataList = tempSellerProductDataList;
      waitingList = tempWaitingList;
      activeList = tempActiveList;
      completedList = tempCompletedList;
    });
  }

  Widget activeTab() {
    List priceList = [];

    int minPrice = 0;
    int maxPrice = 0;

    switch(selectedTab) {
      case 0:
        if(waitingList.isNotEmpty) {
          priceList.add(waitingList[0].price ?? '0');

          priceList.sort();
          minPrice = priceList[0];
          maxPrice = priceList[priceList.length - 1];
        }

        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: waitingList.isNotEmpty ?
          ListView.builder(
            itemCount: waitingList.length,
            itemBuilder: (BuildContext waitingContext, int waitingIndex) {
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: waitingList[waitingIndex].images != null && waitingList[waitingIndex].images!.isNotEmpty ? waitingList[waitingIndex].images![0].url ?? '' : '',
                            fit: BoxFit.contain,
                            width: 110.0,
                            height: 100.0,
                            errorWidget: (errContext, url, error) {
                              return Column(
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
                                  waitingList[waitingIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Segera kirim produk ke koperasi',
                                  style: STextStyles.medium().copyWith(
                                    color: const Color(0xffff9500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: IconColorStyles.iconColor(),
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
                      'assets/images/icon_seller_product_empty.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Kamu Belum Menitipkan Produk',
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
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
        );
      case 1:
        if(activeList.isNotEmpty) {
          priceList.add(activeList[0].price ?? '0');

          priceList.sort();
          minPrice = int.parse(priceList[0] ?? '0');
          maxPrice = int.parse(priceList[priceList.length - 1] ?? '0');
        }

        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: activeList.isNotEmpty ?
          ListView.builder(
            itemCount: activeList.length,
            itemBuilder: (BuildContext activeContext, int activeIndex) {
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      MoveToPage(
                        context: context,
                        target: SellerProductDetailPage(sellerProductData: activeList[activeIndex]),
                        callback: (callbackResult) {
                          if(callbackResult != null) {
                            if(callbackResult['status'] == false) {
                              List<SellerProductData> tempList = activeList;

                              setState(() {
                                completedList = tempList;

                                activeList = [];
                              });
                            } else {
                              BackFromThisPage(context: context, callbackData: callbackResult).go();
                            }
                          }
                        }
                      ).go();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: activeList[activeIndex].images != null && activeList[activeIndex].images!.isNotEmpty ? activeList[activeIndex].images![0].url ?? '' : '',
                            fit: BoxFit.contain,
                            width: 110.0,
                            height: 100.0,
                            errorWidget: (errContext, url, error) {
                              return Column(
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
                                  activeList[activeIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Stok: ${activeList[activeIndex].isStockAlwaysAvailable != null && activeList[activeIndex].isStockAlwaysAvailable! == true ? 'Selalu Tersedia' : activeList[activeIndex].stock ?? '0'}',
                                  style: MTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: IconColorStyles.iconColor(),
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
                      'assets/images/icon_seller_product_empty.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Kamu Belum Menitipkan Produk',
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
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
        );
      case 2:
        if(completedList.isNotEmpty) {
          priceList.add(completedList[0].price ?? '0');

          priceList.sort();
          minPrice = priceList[0];
          maxPrice = priceList[priceList.length - 1];
        }

        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: completedList.isNotEmpty ?
          ListView.builder(
            itemCount: completedList.length,
            itemBuilder: (BuildContext completedContext, int completedIndex) {
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: completedList[completedIndex].images != null && completedList[completedIndex].images!.isNotEmpty ? completedList[completedIndex].images![0].url ?? '' : '',
                            fit: BoxFit.contain,
                            width: 110.0,
                            height: 100.0,
                            errorWidget: (errContext, url, error) {
                              return Column(
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
                                  completedList[completedIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Stok: Habis',
                                  style: MTextStyles.regular(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.navigate_next,
                            color: IconColorStyles.iconColor(),
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
                      'assets/images/icon_seller_product_empty.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Kamu Belum Menitipkan Produk',
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
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
        );
      default:
        return const Material();
    }
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
                            'Atur Produk',
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 3,
                  child: TabBar(
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
                    tabs: [
                      Tab(
                        child: Text(
                          'Menunggu',
                          style: MTextStyles.medium().copyWith(
                            color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Aktif',
                          style: MTextStyles.medium().copyWith(
                            color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Selesai',
                          style: MTextStyles.medium().copyWith(
                            color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            Expanded(
              child: activeTab(),
            ),
          ],
        ),
      ),
    );
  }
}