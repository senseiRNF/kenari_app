import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_page.dart';
import 'package:kenari_app/pages/loan_page.dart';
import 'package:kenari_app/pages/notification_page.dart';
import 'package:kenari_app/pages/product_list_banner_page.dart';
import 'package:kenari_app/pages/product_list_page.dart';
import 'package:kenari_app/pages/product_page.dart';
import 'package:kenari_app/pages/seller_page.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/banner_model.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomeFragment extends StatefulWidget {
  final Function onFeePageCallback;
  final Function onLoanPageCallback;
  final Function onTransactionPageCallback;

  const HomeFragment({
    super.key,
    required this.onFeePageCallback,
    required this.onLoanPageCallback,
    required this.onTransactionPageCallback,
  });

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<ProductData> newProductList = [];
  List<ProductData> popularProductList = [];
  List<ProductData> discountProductList = [];

  List<CategoryData> categoryList = [];

  List<TrolleyData> trolleyList = [];

  List<BannerData> bannerList = [];

  int selectedCard = 0;

  @override
  void initState() {
    super.initState();
    
    loadData();
  }
  
  Future loadData() async {
    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await LocalSharedPrefs().readKey('company_id').then((companyId) async {
          await APIOptions.init().then((dio) async {
            LoadingDialog(context: context).show();

            try {
              await dio.get(
                '/product-category',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                ),
              ).then((getResult) async {
                CategoryModel? tempCategoryModel = CategoryModel.fromJson(getResult.data);

                List<ProductData> tempNewProductList = [];
                List<ProductData> tempPopularProductList = [];
                List<ProductData> tempDiscountProductList = [];

                try {
                  await dio.get(
                    '/transaction/product',
                    options: Options(
                      headers: {
                        'Authorization': 'Bearer $token',
                      },
                    ),
                    queryParameters: {
                      'take': '5',
                      'filter_by': 'new_product',
                    },
                  ).then((getResult) async {
                    ProductModel? tempNewProductModel = ProductModel.fromJson(getResult.data);

                    tempNewProductList = tempNewProductModel.productData ?? [];

                    try {
                      await dio.get(
                        '/transaction/product',
                        options: Options(
                          headers: {
                            'Authorization': 'Bearer $token',
                          },
                        ),
                        queryParameters: {
                          'take': '3',
                          'filter_by': 'populer',
                        },
                      ).then((getResult) async {
                        ProductModel? tempPopularProductModel = ProductModel.fromJson(getResult.data);

                        tempPopularProductList = tempPopularProductModel.productData ?? [];

                        try {
                          await dio.get(
                            '/transaction/product',
                            options: Options(
                              headers: {
                                'Authorization': 'Bearer $token',
                              },
                            ),
                            queryParameters: {
                              'take': '5',
                              'filter_by': 'discount',
                            },
                          ).then((getResult) async {
                            ProductModel? tempDiscountProductModel = ProductModel.fromJson(getResult.data);

                            tempDiscountProductList = tempDiscountProductModel.productData ?? [];

                            try {
                              await dio.get(
                                '/banner',
                                options: Options(
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                  },
                                ),
                                queryParameters: {
                                  'company_id': companyId,
                                },
                              ).then((getResult) async {
                                BannerModel? tempBannerModel = BannerModel.fromJson(getResult.data);

                                try {
                                  await dio.get(
                                    '/transaction/cart',
                                    options: Options(
                                      headers: {
                                        'Authorization': 'Bearer $token',
                                      },
                                    ),
                                    queryParameters: {
                                      'member_id': memberId,
                                    },
                                  ).then((getResult) {
                                    TrolleyModel? tempTrolleyModel = TrolleyModel.fromJson(getResult.data);

                                    setState(() {
                                      categoryList = tempCategoryModel.categoryData ?? [];
                                      newProductList = tempNewProductList;
                                      popularProductList = tempPopularProductList;
                                      discountProductList = tempDiscountProductList;
                                      bannerList = tempBannerModel.bannerData ?? [];
                                      trolleyList = tempTrolleyModel.trolleyData ?? [];
                                    });

                                    BackFromThisPage(context: context).go();
                                  });
                                } on DioException catch(dioExc) {
                                  BackFromThisPage(context: context).go();

                                  ErrorHandler(context: context, dioExc: dioExc).handle();
                                }
                              });
                            } on DioException catch(dioExc) {
                              BackFromThisPage(context: context).go();

                              ErrorHandler(context: context, dioExc: dioExc).handle();
                            }
                          });
                        } on DioException catch(dioExc) {
                          BackFromThisPage(context: context).go();

                          ErrorHandler(context: context, dioExc: dioExc).handle();
                        }
                      });
                    } on DioException catch(dioExc) {
                      BackFromThisPage(context: context).go();

                      ErrorHandler(context: context, dioExc: dioExc).handle();
                    }
                  });
                } on DioException catch(dioExc) {
                  BackFromThisPage(context: context).go();

                  ErrorHandler(context: context, dioExc: dioExc).handle();
                }
              });
            } on DioException catch(dioExc) {
              BackFromThisPage(context: context).go();

              ErrorHandler(context: context, dioExc: dioExc).handle();
            }
          });
        });
      });
    });
  }

  Future loadTrolley() async {
    await APITrolleyServices(context: context).call().then((callResult) {
      if(callResult != null) {
        setState(() {
          trolleyList = callResult.trolleyData ?? [];
        });
      }
    });
  }

  Future updateTrolley(int index, ProductData product, int qty) async {
    String? price = product.varians != null && product.varians!.isNotEmpty ?
    product.varians![index].isPromo != null && product.varians![index].isPromo == true ? product.varians![index].promoPrice ?? '0' : product.varians![index].price ?? '0' :
    product.isPromo != null && product.isPromo == true ? product.promoPrice ?? '0' : product.price ?? '0';

    await APITrolleyServices(context: context).update(
      LocalTrolleyProduct(
        isSelected: true,
        trolleyData: TrolleyData(
          price: price,
          varian: product.varians != null && product.varians!.isNotEmpty ?
          Varian(
            sId: product.varians![index].sId,
            price: product.varians![index].price,
            name1: product.varians![index].name1,
            stock: product.varians![index].stock,
            isStockAlwaysAvailable: product.varians![index].isStockAlwaysAvailable,
            // varianType1: varType1,
            promoPrice: product.varians![index].promoPrice,
            isPromo: product.varians![index].isPromo,
          ) :
          null,
          product: Product(
            sId: product.sId,
          ),
        ),
        qty: qty,
      ),
    ).then((updateResult) {
      loadTrolley();

      if(updateResult == true) {
        showToastSuccessMessage();
      } else {
        showToastFailedMessage();
      }
    });
  }

  Future showAllMenuBottomDialog() async {
    List<Map> menuBottom = [
      {
        'title': 'Keuangan',
        'data': [
          {
            'images': 'assets/images/icon_iuran.png',
            'title': 'Iuran',
            'description': 'Bayar Iuran wajib dan berjangka Perusahaan kamu disini',
            'function': () => MoveToPage(
              context: context,
              target: const FeePage(),
              callback: (callbackResult) {
                if(callbackResult != null) {
                  widget.onFeePageCallback(callbackResult);
                } else {
                  loadData();
                }
              },
            ).go(),
          },
          {
            'images': 'assets/images/icon_pinjaman.png',
            'title': 'Pinjaman',
            'description': 'Dapatkan pinjaman uang untuk pengembangan usaha mu dan kebutuhan lainnya disini',
            'function': () => MoveToPage(
              context: context,
              target: const LoanPage(),
              callback: (callbackResult) {
                if(callbackResult != null) {
                  widget.onLoanPageCallback(callbackResult);
                } else {
                  loadData();
                }
              },
            ).go(),
          },
        ],
      },
      {
        'title': 'Jualan Produk',
        'data': [
          {
            'images': 'assets/images/icon_titip_jual.png',
            'title': 'Titip Jual',
            'description': 'Dapatkan penghasilan tambahan dengan Titip Jual barang apapun disini',
            'function': () => MoveToPage(
              context: context,
              target: const SellerPage(),
              callback: (_) => loadData(),
            ).go(),
          },
        ],
      },
      {
        'title': 'Coming Soon',
        'data': [
          {
            'images': 'assets/images/icon_reksadana.png',
            'title': 'Reksadana',
            'description': 'Sisihkan gaji untuk Investasi yang kekinian, nggak ribet, dan bisa dimulai dengan modal kecil.',
            'function': () {

            },
          },
          {
            'images': 'assets/images/icon_ppob.png',
            'title': 'PPOB',
            'description': 'Memudahkanmu dalam membayarkan berbagai jenis tagihan bulanan.',
            'function': () {

            },
          },
        ],
      },
    ];

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalBottomContext) {
        return FractionallySizedBox(
          heightFactor: 0.70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 5.0,
                  width: 60.0,
                  color: NeutralColorStyles.neutral04(),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuBottom.length,
                  separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                    return const SizedBox(
                      height: 15.0,
                    );
                  },
                  itemBuilder: (BuildContext listContext, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            menuBottom[index]['title'],
                            style: STextStyles.medium().copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menuBottom[index]['data'].length,
                          separatorBuilder: (BuildContext subSeparatorContext, int subSeparatorIndex) {
                            return const SizedBox(
                              height: 15.0,
                            );
                          },
                          itemBuilder: (BuildContext subListContext, int subIndex) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: InkWell(
                                onTap: () => BackFromThisPage(context: context, callbackData: () => menuBottom[index]['data'][subIndex]).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 54.0,
                                      height: 54.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: BorderColorStyles.borderStrokes(),
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          menuBottom[index]['data'][subIndex]['images'],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            menuBottom[index]['data'][subIndex]['title'],
                                            style: STextStyles.medium(),
                                          ),
                                          Text(
                                            menuBottom[index]['data'][subIndex]['description'],
                                            style: XSTextStyles.regular(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ).then((dialogResult) {
      if(dialogResult != null) {
        dialogResult['function']();
      }
    });
  }

  Future showProductBottomDialog(ProductData product) async {
    int index = 0;
    int qty = 1;
    int stock = product.varians != null && product.varians!.isNotEmpty ?
    product.varians![index].isStockAlwaysAvailable != null && product.varians![index].isStockAlwaysAvailable == true ? 1 : int.parse(product.varians![index].stock != null && product.varians![index].stock != '' ? product.varians![index].stock! : '0') :
    product.isStockAlwaysAvailable != null && product.isStockAlwaysAvailable! == true ? 1 : int.parse(product.stock != null && product.stock != '' ? product.stock! : '0');

    String price = product.varians != null && product.varians!.isNotEmpty ? product.varians![index].isPromo != null && product.varians![index].isPromo == true ?
    'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].promoPrice ?? '0')).replaceAll(',', '.')}' : 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].price ?? '0')).replaceAll(',', '.')}' :
    product.isPromo != null && product.isPromo == true ?
    'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.promoPrice ?? '0')).replaceAll(',', '.')}' : 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';

    String imagePath = "$baseURL/${product.images != null && product.images!.isNotEmpty && product.images![0].url != null ? product.images![0].url! : ''}";
    String? variant;

    if(product.varians != null && product.varians!.isNotEmpty) {
      variant = product.varians![index].name1 ?? '(Varian tidak diketahui)';
    }

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, stateSetter) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 5.0,
                    width: 60.0,
                    color: NeutralColorStyles.neutral04(),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    product.varians != null ? 'Varian Produk' : 'Tambah Troli',
                    style: LTextStyles.medium().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CachedNetworkImage(
                          imageUrl: imagePath,
                          imageBuilder: (context, imgProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const SizedBox(
                                width: 80.0,
                                height: 80.0,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return SizedBox(
                              width: 80.0,
                              height: 80.0,
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
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              product.name ?? '(Produk tidak diketahui)',
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            variant != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: NeutralColorStyles.neutral04(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                    child: Text(
                                      variant!,
                                      style: XSTextStyles.medium(),
                                    ),
                                  ),
                                ),
                              ],
                            ) :
                            const Material(),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              price,
                              style: LTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Stok:',
                                  style: STextStyles.regular(),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                product.varians != null && product.varians!.isNotEmpty ?
                                Expanded(
                                  child: Text(
                                    product.varians![index].isStockAlwaysAvailable != null && product.varians![index].isStockAlwaysAvailable! == true ? 'Selalu ada' : stock.toString(),
                                    style: STextStyles.medium(),
                                  ),
                                ) :
                                Expanded(
                                  child: Text(
                                    product.isStockAlwaysAvailable != null && product.isStockAlwaysAvailable! == true ? 'Selalu ada' : stock.toString(),
                                    style: STextStyles.medium(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                product.varians != null && product.varians!.isNotEmpty ?
                Column (
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Pilih Varian :',
                        style: STextStyles.medium().copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        height: 30.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: product.varians!.length,
                          separatorBuilder: (BuildContext separatorContext, int index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          itemBuilder: (BuildContext gridContext, int itemIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: index == itemIndex ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: InkWell(
                                onTap: () => stateSetter(() {
                                  index = itemIndex;
                                  qty = 1;

                                  variant = product.varians![itemIndex].name1 ?? '(Varian tidak diketahui)';

                                  if(product.varians != null && product.varians!.isNotEmpty) {
                                    if(product.varians![index].isPromo != null && product.varians![index].isPromo == true) {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].promoPrice ?? '0')).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].price ?? '0')).replaceAll(',', '.')}';
                                    }
                                  } else {
                                    if(product.isPromo != null && product.isPromo == true) {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.promoPrice ?? '0')).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';
                                    }
                                  }

                                  if(product.varians != null && product.varians!.isNotEmpty) {
                                    if(product.varians![index].isStockAlwaysAvailable != null && product.varians![index].isStockAlwaysAvailable == true) {
                                      stock = 1;
                                    } else {
                                      stock = int.parse(product.varians![index].stock != null && product.varians![index].stock != '' ? product.varians![index].stock! : '0');
                                    }
                                  } else {
                                    if(product.isStockAlwaysAvailable != null && product.isStockAlwaysAvailable! == true) {
                                      stock = 1;
                                    } else {
                                      stock = int.parse(product.stock != null && product.stock != '' ? product.stock! : '0');
                                    }
                                  }
                                }),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    product.varians![itemIndex].name1 ?? '(Varian tidak diketahui)',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ) :
                const Material(),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: qty > 1 ? NeutralColorStyles.neutral04() : NeutralColorStyles.neutral03(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(qty > 1) {
                              stateSetter(() {
                                qty = qty - 1;
                              });
                            }
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: qty > 1 ? IconColorStyles.iconColor() : NeutralColorStyles.neutral04(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          '$qty',
                          style: HeadingTextStyles.headingS(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: product.isStockAlwaysAvailable == null || product.isStockAlwaysAvailable! == false ? qty == stock || stock == 0 ? NeutralColorStyles.neutral03() : NeutralColorStyles.neutral04() : NeutralColorStyles.neutral04(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(product.varians != null && product.varians!.isNotEmpty && product.varians![index].isStockAlwaysAvailable != null) {
                              if(product.varians![index].isStockAlwaysAvailable == null || product.varians![index].isStockAlwaysAvailable! == false) {
                                if(qty < stock) {
                                  stateSetter(() {
                                    qty = qty + 1;
                                  });
                                }
                              } else {
                                stateSetter(() {
                                  qty = qty + 1;
                                });
                              }
                            } else {
                              if(product.isStockAlwaysAvailable == null || product.isStockAlwaysAvailable! == false) {
                                if(qty < stock) {
                                  stateSetter(() {
                                    qty = qty + 1;
                                  });
                                }
                              } else {
                                stateSetter(() {
                                  qty = qty + 1;
                                });
                              }
                            }
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.add,
                            color: product.varians != null && product.varians!.isNotEmpty && product.varians![index].isStockAlwaysAvailable != null ?
                            product.varians![index].isStockAlwaysAvailable == null || product.varians![index].isStockAlwaysAvailable! == false ?
                            qty == stock || stock == 0 ?
                            NeutralColorStyles.neutral04() :
                            IconColorStyles.iconColor() :
                            IconColorStyles.iconColor() :
                            product.isStockAlwaysAvailable == null || product.isStockAlwaysAvailable! == false ?
                            qty == stock || stock == 0 ?
                            NeutralColorStyles.neutral04() :
                            IconColorStyles.iconColor() :
                            IconColorStyles.iconColor(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if(stock > 0) {
                              BackFromThisPage(context: context).go();

                              updateTrolley(index, product, qty);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: stock > 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: stock > 0 ? Colors.white : NeutralColorStyles.neutral06(),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Tambah ke Troli',
                                  style: LTextStyles.medium().copyWith(
                                    color: stock > 0 ? Colors.white : NeutralColorStyles.neutral06(),
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
              ],
            );
          },
        );
      },
    );
  }

  showToastSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Card(
          color: SuccessColorStyles.successSurface(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: SuccessColorStyles.successMain(),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Produk berhasil ditambahkan ke Troli.',
                  style: XSTextStyles.medium().copyWith(
                    color: SuccessColorStyles.successMain(),
                  ),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  showToastFailedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Card(
          color: DangerColorStyles.dangerSurface(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: DangerColorStyles.dangerMain(),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Produk gagal ditambahkan ke Troli!',
                  style: XSTextStyles.medium().copyWith(
                    color: DangerColorStyles.dangerMain(),
                  ),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  showExitToastMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Card(
          color: InfoColorStyles.infoSurface(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: InfoColorStyles.infoMain(),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Tekan sekali lagi untuk menutup aplikasi!',
                  style: XSTextStyles.medium().copyWith(
                    color: InfoColorStyles.infoMain(),
                  ),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xffff4700),
                Color(0xffff5f0a),
                Color(0xffff7613),
                Color(0xffff7f17),
                Color(0xffff7a15),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 31.0,
                  height: 36.0,
                  child: Image.asset(
                    'assets/images/white_main_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    'Selamat datang di\nKenari!',
                    style: MTextStyles.medium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => MoveToPage(
                      context: context,
                      target: const TrolleyPage(),
                      callback: (callbackResult) {
                        if(callbackResult != null && callbackResult['target'] == 'transaction') {
                          widget.onTransactionPageCallback(callbackResult);
                        } else {
                          loadTrolley();
                        }
                      },
                    ).go(),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
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
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => MoveToPage(
                      context: context,
                      target: const NotificationPage(),
                      callback: (_) => loadData(),
                    ).go(),
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: BackgroundColorStyles.pageBackground(),
            child: RefreshIndicator(
              onRefresh: () async => loadData(),
              child: ListView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 0.90,
                      onPageChanged: (page, reason) {
                        setState(() {
                          selectedCard = page;
                        });
                      },
                    ),
                    items: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff242424),
                                Color(0xff363636),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      'assets/images/dipay_logo.png',
                                      fit: BoxFit.fitWidth,
                                      width: 50.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    'Aktivasi akun Dipay untuk segala\nmacam transaksi di Kenari',
                                    style: STextStyles.medium().copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              'Aktivasi Akun',
                                              style: XSTextStyles.medium().copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            const Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff101828),
                                Color(0xff475467),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Image.asset(
                                      'assets/images/indofund_logo_white.png',
                                      fit: BoxFit.fitWidth,
                                      width: 50.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    'Aktivasi akun Indofund untuk\nkemudahan fitur pinjaman di Kenari',
                                    style: STextStyles.medium().copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              'Aktivasi Akun',
                                              style: XSTextStyles.medium().copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            const Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: selectedCard == 0 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const SizedBox(
                          height: 3.0,
                          width: 20.0,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: selectedCard == 1 ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const SizedBox(
                          height: 3.0,
                          width: 20.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => MoveToPage(
                                    context: context,
                                    target: const FeePage(),
                                    callback: (callbackResult) {
                                      if(callbackResult != null) {
                                        widget.onFeePageCallback(callbackResult);
                                      } else {
                                        loadData();
                                      }
                                    },
                                  ).go(),
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_iuran.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Iuran',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => MoveToPage(
                                    context: context,
                                    target: const LoanPage(),
                                    callback: (callbackResult) {
                                      if(callbackResult != null) {
                                        widget.onLoanPageCallback(callbackResult);
                                      } else {
                                        loadData();
                                      }
                                    },
                                  ).go(),
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_pinjaman.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Pinjaman',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => MoveToPage(
                                    context: context,
                                    target: const SellerPage(),
                                    callback: (_) => loadData(),
                                  ).go(),
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_titip_jual.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Titip Jual',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: BorderColorStyles.borderStrokes(),
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => showAllMenuBottomDialog(),
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      'assets/images/icon_semua.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Semua',
                              style: STextStyles.medium(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Produk Terbaru',
                          style: MTextStyles.medium(),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => MoveToPage(
                              context: context,
                              target: const ProductListPage(
                                filterType: 'Terbaru',
                              ),
                              callback: (callbackResult) {
                                if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                  widget.onTransactionPageCallback(callbackResult);
                                } else {
                                  loadData();
                                }
                              },
                            ).go(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Lihat semua',
                                style: MTextStyles.medium().copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: newProductList.isNotEmpty ?
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: newProductList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        String price = '';
                        String? discountPrice;

                        if(newProductList[index].varians == null || newProductList[index].varians!.isEmpty) {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(newProductList[index].price ?? '0')).replaceAll(',', '.')}';

                          if(newProductList[index].isPromo != null && newProductList[index].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(newProductList[index].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        } else {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(newProductList[index].varians![0].price ?? '0')).replaceAll(',', '.')}';

                          if(newProductList[index].varians![0].isPromo != null && newProductList[index].varians![0].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(newProductList[index].varians![0].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        }

                        return Padding(
                          padding: index == 0 ? const EdgeInsets.only(left: 20.0, right: 1.0) : index == newProductList.length - 1 ?
                          const EdgeInsets.only(left: 1.0, right: 25.0) :
                          const EdgeInsets.symmetric(horizontal: 1.0),
                          child: SizedBox(
                            width: 150.0,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () => MoveToPage(
                                  context: context,
                                  target: ProductPage(productId: newProductList[index].sId!),
                                  callback: (callbackResult) {
                                    if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                      widget.onTransactionPageCallback(callbackResult);
                                    } else {
                                      loadData();
                                    }
                                  },
                                ).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: "$baseURL/${newProductList[index].images != null && newProductList[index].images!.isNotEmpty && newProductList[index].images![0].url != null ? newProductList[index].images![0].url! : ''}",
                                        imageBuilder: (context, imgProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imgProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (errContext, url, error) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              newProductList[index].productCategory != null && newProductList[index].productCategory!.name != null ? newProductList[index].productCategory!.name! : 'Unknow Category',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Text(
                                                newProductList[index].name ?? '(Produk tidak diketahui)',
                                                style: STextStyles.medium(),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    discountPrice ?? price,
                                                    style: XSTextStyles.medium().copyWith(
                                                      color: PrimaryColorStyles.primaryMain(),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => showProductBottomDialog(newProductList[index]),
                                                  customBorder: const CircleBorder(),
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    size: 15.0,
                                                    color: IconColorStyles.iconColor(),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/icon_empty.png',
                          width: 150,
                          height: 130,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Oops! Untuk saat ini kategori ini masih kosong',
                          style: STextStyles.medium(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  bannerList.isNotEmpty ?
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 150,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.9,
                          ),
                          items: bannerList.map((bannerData) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: InkWell(
                                onTap: () => MoveToPage(
                                  context: context,
                                  target: ProductListBannerPage(
                                    bannerData: bannerData,
                                  ),
                                  callback: (callbackResult) {
                                    if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                      widget.onTransactionPageCallback(callbackResult);
                                    } else {
                                      loadData();
                                    }
                                  },
                                ).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: bannerData.bannerImage != null ?
                                CachedNetworkImage(
                                  imageUrl: "$baseURL/${bannerData.bannerImage!.url ?? ''}",
                                  imageBuilder: (context, imgProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: imgProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (errContext, url, error) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
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
                                ) :
                                Column(
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
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ) :
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Text(
                      'Kategori Produk',
                      style: MTextStyles.medium(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50.0,
                          child: categoryList.isNotEmpty ?
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length,
                            itemBuilder: (BuildContext categoryContext, int categoryIndex) {
                              return Padding(
                                padding: categoryIndex == 0 ? const EdgeInsets.only(left: 25.0, right: 5) : categoryIndex == categoryList.length - 1 ? const EdgeInsets.only(left: 5.0, right: 25.0,) : const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: BorderColorStyles.borderStrokes(),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => MoveToPage(
                                        context: context,
                                        target: ProductListPage(
                                          filterType: 'Kategori_${categoryList[categoryIndex].name}',
                                          categoryData: categoryList[categoryIndex],
                                        ),
                                        callback: (callbackResult) {
                                          if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                            widget.onTransactionPageCallback(callbackResult);
                                          } else {
                                            loadData();
                                          }
                                        },
                                      ).go(),
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
                          ) :
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Kategori tidak ditemukan...',
                              style: MTextStyles.medium(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                    child: Text(
                      'Produk Populer',
                      style: MTextStyles.medium(),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: popularProductList.isNotEmpty ?
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: popularProductList.length,
                      separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            thickness: 0.5,
                            height: 1.0,
                            color: BorderColorStyles.borderDivider(),
                          ),
                        );
                      },
                      itemBuilder: (BuildContext popularContext, int index) {
                        String price = '';
                        String? discountPrice;

                        if(popularProductList[index].varians == null || popularProductList[index].varians!.isEmpty) {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].price ?? '0')).replaceAll(',', '.')}';

                          if(popularProductList[index].isPromo != null && popularProductList[index].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        } else {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].varians![0].price ?? '0')).replaceAll(',', '.')}';

                          if(popularProductList[index].varians![0].isPromo != null && popularProductList[index].varians![0].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(popularProductList[index].varians![0].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        }

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => MoveToPage(
                              context: context,
                              target: ProductPage(productId: popularProductList[index].sId!),
                              callback: (callbackResult) {
                                if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                  widget.onTransactionPageCallback(callbackResult);
                                } else {
                                  loadData();
                                }
                              },
                            ).go(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$baseURL/${popularProductList[index].images != null && popularProductList[index].images!.isNotEmpty && popularProductList[index].images![0].url != null ? popularProductList[index].images![0].url! : ''}",
                                    imageBuilder: (context, imgProvider) => Container(
                                      width: 110.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                          image: imgProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (errContext, url, error) {
                                      return SizedBox(
                                        width: 110.0,
                                        height: 100.0,
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
                                          popularProductList[index].name ?? '(Produk tidak diketahui)',
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
                                                  popularProductList[index].productCategory != null && popularProductList[index].productCategory!.name != null ? popularProductList[index].productCategory!.name! : '(Kategori tidak diketahui)',
                                                  style: XSTextStyles.regular(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        discountPrice != null ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              discountPrice,
                                              style: STextStyles.regular().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ],
                                        ) :
                                        const Material(),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    price,
                                                    style: STextStyles.regular().copyWith(
                                                      color: discountPrice != null ? TextColorStyles.textDisabled() : PrimaryColorStyles.primaryMain(),
                                                      decoration: discountPrice != null ? TextDecoration.lineThrough : null,
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
                        );
                      },
                    ) :
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/icon_empty.png',
                            width: 150,
                            height: 130,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Oops! Untuk saat ini kategori ini masih kosong',
                            style: STextStyles.medium(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diskon',
                          style: MTextStyles.medium(),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => MoveToPage(
                              context: context,
                              target: const ProductListPage(
                                filterType: 'Diskon',
                              ),
                              callback: (callbackResult) {
                                if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                  widget.onTransactionPageCallback(callbackResult);
                                } else {
                                  loadData();
                                }
                              },
                            ).go(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Lihat semua',
                                style: MTextStyles.medium().copyWith(
                                  color: PrimaryColorStyles.primaryMain(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    child: discountProductList.isNotEmpty ?
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: discountProductList.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        String price = '';
                        String? discountPrice;

                        if(discountProductList[index].varians == null || discountProductList[index].varians!.isEmpty) {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].price ?? '0')).replaceAll(',', '.')}';

                          if(discountProductList[index].isPromo != null && discountProductList[index].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        } else {
                          price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].varians![0].price ?? '0')).replaceAll(',', '.')}';

                          if(discountProductList[index].varians![0].isPromo != null && discountProductList[index].varians![0].isPromo == true) {
                            discountPrice = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(discountProductList[index].varians![0].promoPrice ?? '0')).replaceAll(',', '.')}';
                          }
                        }

                        return Padding(
                          padding: index == 0 ? const EdgeInsets.only(left: 25.0, right: 1.0) : index == discountProductList.length - 1 ?
                          const EdgeInsets.only(left: 1.0, right: 25.0) :
                          const EdgeInsets.symmetric(horizontal: 1.0),
                          child: SizedBox(
                            width: 150.0,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () => MoveToPage(
                                  context: context,
                                  target: ProductPage(productId: discountProductList[index].sId!),
                                  callback: (callbackResult) {
                                    if(callbackResult != null && callbackResult['target'] == 'transaction') {
                                      widget.onTransactionPageCallback(callbackResult);
                                    } else {
                                      loadData();
                                    }
                                  },
                                ).go(),
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: "$baseURL/${discountProductList[index].images != null && discountProductList[index].images!.isNotEmpty && discountProductList[index].images![0].url != null ? discountProductList[index].images![0].url! : ''}",
                                        imageBuilder: (context, imgProvider) => Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imgProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (errContext, url, error) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              discountProductList[index].productCategory != null && discountProductList[index].productCategory!.name != null ? discountProductList[index].productCategory!.name! : '(Kategori tidak diketahui)',
                                              style: XSTextStyles.regular(),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Text(
                                                discountProductList[index].name ?? '(Produk tidak diketahui)',
                                                style: STextStyles.medium(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          discountPrice != null ?
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(
                                              discountPrice,
                                              style: XSTextStyles.medium().copyWith(
                                                color: PrimaryColorStyles.primaryMain(),
                                              ),
                                            ),
                                          ) :
                                          const Material(),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    price,
                                                    style: XSTextStyles.medium().copyWith(
                                                      color: discountPrice != null ? TextColorStyles.textDisabled() : PrimaryColorStyles.primaryMain(),
                                                      decoration: discountPrice != null ? TextDecoration.lineThrough : null,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => showProductBottomDialog(discountProductList[index]),
                                                  customBorder: const CircleBorder(),
                                                  child: Icon(
                                                    Icons.more_horiz,
                                                    size: 15.0,
                                                    color: IconColorStyles.iconColor(),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/icon_empty.png',
                          width: 150,
                          height: 130,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Oops! Untuk saat ini kategori ini masih kosong',
                          style: STextStyles.medium(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}