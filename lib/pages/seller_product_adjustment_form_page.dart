import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_detail_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductAdjustmentFormPage extends StatefulWidget {
  const SellerProductAdjustmentFormPage({super.key});

  @override
  State<SellerProductAdjustmentFormPage> createState() => _SellerProductAdjustmentFormPageState();
}

class _SellerProductAdjustmentFormPageState extends State<SellerProductAdjustmentFormPage> {
  int selectedTab = 0;

  List waitingList = [
    {
      'title': 'Cabai Merah',
      'image': 'assets/images/example_images/cabai-rawit-merah.png',
      'price': [25000, 65000],
    },
  ];
  List activeList = [
    {
      'title': 'Cabai Merah',
      'image': 'assets/images/example_images/cabai-rawit-merah.png',
      'price': [25000, 65000],
    },
  ];
  List completedList = [];

  Widget activeTab() {
    List priceList = [];

    int minPrice = 0;
    int maxPrice = 0;

    switch(selectedTab) {
      case 0:
        if(waitingList.isNotEmpty) {
          priceList = waitingList[0]['price'];

          priceList.sort();
          minPrice = priceList[0];
          maxPrice = priceList[priceList.length - 1];
        }

        return RefreshIndicator(
          onRefresh: () async {

          },
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
                          Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  waitingList[waitingIndex]['image'],
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
                                  waitingList[waitingIndex]['title'],
                                  style: Theme.of(context).textTheme.bodyMedium!,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontBodyWeight.medium(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Segera kirim produk ke koperasi',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xffff9500),
                                    fontWeight: FontBodyWeight.medium(),
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
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
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
          priceList = activeList[0]['price'];

          priceList.sort();
          minPrice = priceList[0];
          maxPrice = priceList[priceList.length - 1];
        }

        return RefreshIndicator(
          onRefresh: () async {

          },
          child: activeList.isNotEmpty ?
          ListView.builder(
            itemCount: activeList.length,
            itemBuilder: (BuildContext waitingContext, int waitingIndex) {
              return Container(
                color: Colors.white,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      MoveToPage(
                        context: context,
                        target: const SellerProductDetailPage(),
                        callback: (callbackResult) {
                          if(callbackResult != null) {
                            if(callbackResult['status'] == false) {
                              List tempList = activeList;

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
                          Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  activeList[waitingIndex]['image'],
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
                                  activeList[waitingIndex]['title'],
                                  style: Theme.of(context).textTheme.bodyMedium!,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontBodyWeight.medium(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Stok: Tersedia',
                                  style: Theme.of(context).textTheme.bodyMedium!,
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
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
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
          priceList = completedList[0]['price'];

          priceList.sort();
          minPrice = priceList[0];
          maxPrice = priceList[priceList.length - 1];
        }

        return RefreshIndicator(
          onRefresh: () async {

          },
          child: completedList.isNotEmpty ?
          ListView.builder(
            itemCount: completedList.length,
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
                          Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  completedList[waitingIndex]['image'],
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
                                  completedList[waitingIndex]['title'],
                                  style: Theme.of(context).textTheme.bodyMedium!,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontBodyWeight.medium(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Stok: Habis',
                                  style: Theme.of(context).textTheme.bodyMedium!,
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
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Yuk titip semua produk yang ingin kamu jual dengan Kenari!',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
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
        return Column();
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
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selectedTab == 0 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Aktif',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selectedTab == 1 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Selesai',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: selectedTab == 2 ? PrimaryColorStyles.primaryMain() : TextColorStyles.textSecondary(),
                            fontWeight: FontBodyWeight.medium(),
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