import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/models/local_product_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductListBannerPage extends StatefulWidget {
  final String bannerType;
  final List<LocalProductData> productList;
  final List<String> filterList;

  const ProductListBannerPage({
    super.key,
    required this.bannerType,
    required this.productList,
    required this.filterList,
  });

  @override
  State<ProductListBannerPage> createState() => _ProductListBannerPageState();
}

class _ProductListBannerPageState extends State<ProductListBannerPage> {
  late String filterType;

  TextEditingController searchController = TextEditingController();

  List<LocalProductData> productList = [];

  List<String> filterList = [];

  @override
  void initState() {
    super.initState();

    List<LocalProductData> tempProductList = [];

    if(widget.bannerType == 'discount') {
      setState(() {
        filterType = 'Diskon';
      });

      for(int i = 0; i < widget.productList.length; i++) {
        if(widget.productList[i].discountFlag == true) {
          tempProductList.add(widget.productList[i]);
        }
      }
    } else {
      setState(() {
        filterType = 'Terbaru';
      });

      for(int i = 0; i < widget.productList.length; i++) {
        if(widget.productList[i].type == 'Outfit') {
          tempProductList.add(widget.productList[i]);
        }
      }
    }

    setState(() {
      filterList = widget.filterList;
      productList = tempProductList;
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
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 20.0,
                        color: IconColorStyles.iconColor(),
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
              child: Container(
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.bannerType == 'discount' ?
                      'assets/images/banner_discount.png' :
                      'assets/images/banner_new_collection.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
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
              child: productList.isNotEmpty ?
              ListView.separated(
                shrinkWrap: true,
                itemCount: productList.length,
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
                    padding: index == productList.length - 1 ?
                    const EdgeInsets.only(left: 25.0, bottom: 20.0, right: 25.0) :
                    const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          productList[index].imagePath[0] ?? '',
                          fit: BoxFit.cover,
                          width: 110.0,
                          height: 100.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                productList[index].name,
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
                                      child: Text(
                                        productList[index].type,
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
                                    child: productList[index].discountPrice[0] != 0 ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Rp ${NumberFormat('#,###', 'en_id').format(productList[index].discountPrice[0]).replaceAll(',', '.')}',
                                          style: STextStyles.regular().copyWith(
                                            color: PrimaryColorStyles.primaryMain(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Rp ${NumberFormat('#,###', 'en_id').format(productList[index].normalPrice[0]).replaceAll(',', '.')}',
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
                                          'Rp ${NumberFormat('#,###', 'en_id').format(productList[index].normalPrice[0]).replaceAll(',', '.')}',
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
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Oops! Produk yang kamu cari di halaman ini tidak dapat ditemukan',
                      style: MTextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
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