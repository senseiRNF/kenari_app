import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/services/local/models/local_product_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SearchFragment extends StatefulWidget {
  final TextEditingController searchController;
  final List<LocalProductData> productList;

  const SearchFragment({
    super.key,
    required this.searchController,
    required this.productList,
  });

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  late TextEditingController searchController;

  List<LocalProductData> productList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      searchController = widget.searchController;
      productList = widget.productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                      hintText: 'Cari produk',
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
        const SizedBox(
          height: 35.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Kategori',
            style: STextStyles.medium(),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50.0,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 5.0),
                      child: Container(
                        width: 150.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icon_elektronik.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Elektronik',
                                  style: XSTextStyles.regular(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 150.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icon_makanan.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Makanan',
                                  style: XSTextStyles.regular(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 150.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BorderColorStyles.borderStrokes(),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icon_sembako.png',
                                width: 20.0,
                                height: 20.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Sembako',
                                  style: XSTextStyles.regular(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
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
            child: InkWell(
              onTap: () {

              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Filter : ',
                      style: STextStyles.medium(),
                    ),
                    Expanded(
                      child: Text(
                        'Terbaru',
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
            physics: const NeverScrollableScrollPhysics(),
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
            itemBuilder: (BuildContext popularContext, int popularIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      productList[popularIndex].imagePath[0] ?? '',
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
                            productList[popularIndex].name,
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
                                    productList[popularIndex].type,
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
                                child: productList[popularIndex].discountPrice[0] != 0 ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Rp ${NumberFormat('#,###', 'en_id').format(productList[popularIndex].discountPrice).replaceAll(',', '.')}',
                                      style: STextStyles.regular().copyWith(
                                        color: PrimaryColorStyles.primaryMain(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Rp ${NumberFormat('#,###', 'en_id').format(productList[popularIndex].normalPrice).replaceAll(',', '.')}',
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
                                      'Rp ${NumberFormat('#,###', 'en_id').format(productList[popularIndex].normalPrice).replaceAll(',', '.')}',
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
    );
  }
}