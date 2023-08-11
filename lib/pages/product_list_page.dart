import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/product_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/services/api/product_services/api_category_services.dart';
import 'package:kenari_app/services/api/product_services/api_product_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductListPage extends StatefulWidget {
  final String? filterType;

  const ProductListPage({
    super.key,
    this.filterType,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String title = '';
  String searchHint = '';
  String filterType = '';

  TextEditingController searchController = TextEditingController();

  List<ProductData> productList = [];

  List<CategoryData> categoryList = [];

  List<String> filterList = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APICategoryServices(context: context).call().then((result) async {
      if(result != null && result.categoryData != null) {
        setState(() {
          categoryList = result.categoryData!;
        });
      }

      await APIProductServices(context: context).call().then((productResult) {
        if(productResult != null && productResult.productData != null) {
          setState(() {
            productList = productResult.productData!;
          });
        }
      });
    });

    if(widget.filterType != null) {
      setState(() {
        if(widget.filterType! == 'Terbaru') {
          filterType = widget.filterType!;
          title = 'Produk Terbaru';
          searchHint = 'Cari di produk terbaru';
        } else if(widget.filterType! == 'Diskon') {
          filterType = widget.filterType!;
          title = 'Diskon';
          searchHint = 'Cari Produk';
        } else if(widget.filterType!.contains('Kategori')) {
          filterType = 'Tampilkan Semua';
          title = 'Kategori';
          searchHint = 'Cari di ${widget.filterType!.substring(widget.filterType!.indexOf('_'), widget.filterType!.length).replaceAll('_', '')}';
        } else {
          filterType = 'Tampilkan Semua';
          title = 'Cari Produk';
          searchHint = 'Cari Produk';
        }
      });
    }
  }

  void applyAnyFilter() {
    
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
                            title,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Material(
                      color: NeutralColorStyles.neutral02(),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.search,
                              color: IconColorStyles.iconColor(),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: searchHint,
                                hintStyle: MTextStyles.regular(),
                              ),
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (query) {

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Kategori',
                style: STextStyles.medium(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext categoryContext, int categoryIndex) {
                          return Padding(
                            padding: categoryIndex == 0 ? const EdgeInsets.only(left: 25.0, right: 5) : categoryIndex == categoryList.length - 1 ? const EdgeInsets.only(left: 5.0, right: 25.0,) : const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if(widget.filterType!.contains('Kategori')) {
                                      setState(() {
                                        searchHint = 'Cari di ${categoryList[categoryIndex].name}';
                                      });
                                    }
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        categoryList[categoryIndex].name ?? '(Kategori tidak diketahui)',
                                        style: MTextStyles.regular(),
                                      ),
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
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
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
                    Expanded(
                      child: productList.isNotEmpty ?
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: productList.length,
                        separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Divider(
                              height: 1.0,
                              thickness: 0.5,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          );
                        },
                        itemBuilder: (BuildContext popularContext, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  MoveToPage(
                                    context: context,
                                    target: ProductPage(productId: productList[index].sId!),
                                    callback: (callbackResult) {
                                      if(callbackResult != null) {
                                        BackFromThisPage(context: context, callbackData: callbackResult).go();
                                      }
                                    },
                                  ).go();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: "$baseURL/${productList[index].images != null && productList[index].images!.isNotEmpty && productList[index].images![0].url != null ? productList[index].images![0].url! : ''}",
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
                                              productList[index].name ?? '(Produk tidak diketahui)',
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
                                                      productList[index].productCategory != null && productList[index].productCategory!.name != null ? productList[index].productCategory!.name! : '(Kategori tidak diketahui)',
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
                                                  child: productList[index].promoPrice != null && productList[index].promoPrice != '' ?
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(productList[index].promoPrice ?? '0')).replaceAll(',', '.')}',
                                                        style: STextStyles.regular().copyWith(
                                                          color: PrimaryColorStyles.primaryMain(),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(productList[index].price ?? '0')).replaceAll(',', '.')}',
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
                                                        'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(productList[index].price ?? '0')).replaceAll(',', '.')}',
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
                                ),
                              ),
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
            ),
          ],
        ),
      ),
    );
  }
}