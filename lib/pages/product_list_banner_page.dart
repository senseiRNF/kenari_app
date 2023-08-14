import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/banner_detail_model.dart';
import 'package:kenari_app/services/api/models/banner_model.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/product_services/api_banner_services.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductListBannerPage extends StatefulWidget {
  final BannerData bannerData;

  const ProductListBannerPage({
    super.key,
    required this.bannerData,
  });

  @override
  State<ProductListBannerPage> createState() => _ProductListBannerPageState();
}

class _ProductListBannerPageState extends State<ProductListBannerPage> {
  TextEditingController searchController = TextEditingController();

  List<TrolleyData> trolleyList = [];

  List<String> filterList = [
    'Tampilkan Semua',
    'Terbaru',
    'Terlaris',
    'Diskon',
    'Harga Terendah',
    'Harga Tertinggi',
  ];

  String filterType = 'Tampilkan Semua';

  BannerDetailData? bannerDetailData;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    String? filter;

    switch(filterType) {
      case 'Tampilkan Semua':
        filter = null;
        break;
      case 'Terbaru':
        filter = 'new_product';
        break;
      case 'Terlaris':
        filter = 'best_seller';
        break;
      case 'Diskon':
        filter = 'discount';
        break;
      case 'Harga Terendah':
        filter = 'lower_price';
        break;
      case 'Harga Tertinggi':
        filter = 'higher_price';
        break;
    }

    await APIBannerServices(context: context).callById(widget.bannerData.sId, {
      'filter_by': filter,
      'keyword': searchController.text,
    }).then((callResult) {
      if(callResult != null) {
        setState(() {
          bannerDetailData = callResult.bannerDetailData;
        });
      }

      loadTrolley();
    });
  }

  Future loadTrolley() async {
    await APITrolleyServices(context: context).call().then((trolleyResult) {
      if(trolleyResult != null && trolleyResult.trolleyData != null) {
        setState(() {
          trolleyList = trolleyResult.trolleyData!;
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
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
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: NeutralColorStyles.neutral02(),
                        isDense: true,
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Cari sesuatu',
                      ),
                      controller: searchController,
                      onSubmitted: (_) => loadData(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      MoveToPage(
                        context: context,
                        target: const TrolleyPage(),
                        callback: (callbackResult) {
                          if(callbackResult != null) {
                            BackFromThisPage(context: context, callbackData: callbackResult).go();
                          }
                        },
                      ).go();
                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            size: 20.0,
                            color: IconColorStyles.iconColor(),
                          ),
                          trolleyList.isNotEmpty ?
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: const EdgeInsets.only(left: 15.0),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${trolleyList.length}',
                                style: XSTextStyles.regular().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ) :
                          const Material(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CachedNetworkImage(
                imageUrl: "$baseURL/${bannerDetailData != null && bannerDetailData!.bannerDetailImage != null ? bannerDetailData!.bannerDetailImage!.url ?? '' : ''}",
                imageBuilder: (context, imgProvider) => Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: imgProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (errContext, url, error) {
                  return SizedBox(
                    height: 150.0,
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
            ),
            bannerDetailData != null ? bannerDetailData!.type == 'Product' ?
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Filter : ',
                                  style: STextStyles.medium(),
                                ),
                                Expanded(
                                  child: Text(
                                    filterType,
                                    style: STextStyles.regular(),
                                  ),
                                ),
                                Icon(
                                  Icons.expand_more,
                                  color: IconColorStyles.iconColor(),
                                ),
                              ],
                            ),
                          ),
                          DropdownButton(
                            onChanged: (newValue) {
                              if(newValue != null) {
                                setState(() {
                                  filterType = newValue;
                                });

                                loadData();
                              }
                            },
                            borderRadius: BorderRadius.circular(10.0),
                            isExpanded: true,
                            icon: const Icon(
                              Icons.expand_more,
                              color: Colors.transparent,
                            ),
                            underline: const Material(),
                            items: filterList.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                  child: Text(
                                    value,
                                    style: STextStyles.regular(),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: bannerDetailData != null && bannerDetailData!.products != null && bannerDetailData!.products!.isNotEmpty ?
                    RefreshIndicator(
                      onRefresh: () async => loadData(),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: bannerDetailData!.products!.length,
                        separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                            child: Divider(
                              thickness: 0.5,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          );
                        },
                        itemBuilder: (BuildContext popularContext, int index) {
                          return Padding(
                            padding: index == bannerDetailData!.products!.length - 1 ?
                            const EdgeInsets.only(left: 25.0, bottom: 20.0, right: 25.0) :
                            const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: "$baseURL/${bannerDetailData!.products![index].images != null && bannerDetailData!.products![index].images!.isNotEmpty && bannerDetailData!.products![index].images![0].url != null ? bannerDetailData!.products![index].images![0].url! : ''}",
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
                                          'Tidak dapat memuat gambar',
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
                                        bannerDetailData!.products![index].name ?? '(Produk tidak diketahui)',
                                        style: STextStyles.medium(),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: BorderColorStyles.borderStrokes(),
                                              ),
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                              // child: Text(
                                              //   bannerDetailData!.products![index].productCategory != null && bannerDetailData!.products![index].productCategory!.name != null ? bannerDetailData!.products![index].productCategory!.name! : '',
                                              //   style: XSTextStyles.regular(),
                                              // ),
                                              child: Text(
                                                bannerDetailData!.products![index].productCategory ?? '',
                                                style: XSTextStyles.regular(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: bannerDetailData!.products![index].promoPrice != null && bannerDetailData!.products![index].promoPrice != '' ?
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(bannerDetailData!.products![index].promoPrice ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: PrimaryColorStyles.primaryMain(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(bannerDetailData!.products![index].price ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: TextColorStyles.textDisabled(),
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ) :
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(
                                                  height: 25.0,
                                                ),
                                                Text(
                                                  'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(bannerDetailData!.products![index].price ?? '0')).replaceAll(',', '.')}',
                                                  style: STextStyles.regular().copyWith(
                                                    color: PrimaryColorStyles.primaryMain(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.shopping_cart,
                                            color: IconColorStyles.iconColor(),
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ) :
                    Stack(
                      children: [
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80.0),
                              child: Image.asset(
                                'assets/images/icon_empty.png',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                '',
                                style: MTextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        RefreshIndicator(
                          onRefresh: () async => loadData(),
                          child: ListView(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) :
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      bannerDetailData!.textAnnouncement ?? '',
                      style: MTextStyles.regular(),
                    ),
                  ),
                ],
              ),
            ) :
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: Image.asset(
                          'assets/images/icon_empty.png',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          '',
                          style: MTextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async => loadData(),
                    child: ListView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}