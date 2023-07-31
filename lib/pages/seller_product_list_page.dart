import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_detail_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/seller_product_model.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductListPage extends StatefulWidget {
  const SellerProductListPage({super.key});

  @override
  State<SellerProductListPage> createState() => _SellerProductListPageState();
}

class _SellerProductListPageState extends State<SellerProductListPage> {
  int selectedTab = 0;

  List<SellerProductData> sellerProductDataList = [];
  
  String status = 'waiting';

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    List<SellerProductData> tempSellerProductDataList = [];

    await APISellerProductServices(context: context).call(status).then((callResult) {
      if(callResult != null && callResult.sellerProductData != null) {
        for(int i = 0; i < callResult.sellerProductData!.length; i++) {
          tempSellerProductDataList.add(callResult.sellerProductData![i]);
        }
      }
    });

    setState(() {
      sellerProductDataList = tempSellerProductDataList;
    });
  }

  Widget activeTab() {
    switch(selectedTab) {
      case 0:
        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: sellerProductDataList.isNotEmpty ?
          ListView.builder(
            itemCount: sellerProductDataList.length,
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
                            imageUrl: "$baseURL/${sellerProductDataList[waitingIndex].images != null && sellerProductDataList[waitingIndex].images!.isNotEmpty ? sellerProductDataList[waitingIndex].images![0].url ?? '' : ''}",
                            width: 110.0,
                            height: 100.0,
                            imageBuilder: (context, imgProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
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
                                  sellerProductDataList[waitingIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDataList[waitingIndex].price ?? '0')).replaceAll(',', '.')}',
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
        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: sellerProductDataList.isNotEmpty ?
          ListView.builder(
            itemCount: sellerProductDataList.length,
            itemBuilder: (BuildContext activeContext, int activeIndex) {
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if(sellerProductDataList[activeIndex].sId != null) {
                        MoveToPage(
                          context: context,
                          target: SellerProductDetailPage(productId: sellerProductDataList[activeIndex].sId!),
                          callback: (callbackResult) async {
                            if(callbackResult != null && callbackResult == true) {
                              await loadData();
                            }
                          },
                        ).go();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: "$baseURL/${sellerProductDataList[activeIndex].images != null && sellerProductDataList[activeIndex].images!.isNotEmpty ? sellerProductDataList[activeIndex].images![0].url ?? '' : ''}",
                            width: 110.0,
                            height: 100.0,
                            imageBuilder: (context, imgProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
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
                                  sellerProductDataList[activeIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDataList[activeIndex].price ?? '0')).replaceAll(',', '.')}',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Stok: ${sellerProductDataList[activeIndex].isStockAlwaysAvailable != null && sellerProductDataList[activeIndex].isStockAlwaysAvailable! == true ? 'Selalu Tersedia' : sellerProductDataList[activeIndex].stock ?? '0'}',
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
        return RefreshIndicator(
          onRefresh: () async => loadData(),
          child: sellerProductDataList.isNotEmpty ?
          ListView.builder(
            itemCount: sellerProductDataList.length,
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
                            imageUrl: "$baseURL/${sellerProductDataList[completedIndex].images != null && sellerProductDataList[completedIndex].images!.isNotEmpty ? sellerProductDataList[completedIndex].images![0].url ?? '' : ''}",
                            width: 110.0,
                            height: 100.0,
                            imageBuilder: (context, imgProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
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
                                  sellerProductDataList[completedIndex].name ?? '',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDataList[completedIndex].price ?? '0')).replaceAll(',', '.')}',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  sellerProductDataList[completedIndex].isStockAlwaysAvailable != null && sellerProductDataList[completedIndex].isStockAlwaysAvailable! == true ?
                                  'Stok: Tidak Tersedia' :
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

                        switch(index) {
                          case 0:
                            status = 'waiting';
                            break;
                          case 1:
                            status = 'verified';
                            break;
                          case 2:
                            status = 'cancelled';
                            break;
                          default:
                            status = 'waiting';
                            break;
                        }

                        loadData();
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