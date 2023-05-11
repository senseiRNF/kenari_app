import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/fragments/home_fragment.dart';
import 'package:kenari_app/fragments/profile_fragment.dart';
import 'package:kenari_app/fragments/search_fragment.dart';
import 'package:kenari_app/fragments/transaction_fragment.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/fee_page.dart';
import 'package:kenari_app/pages/loan_page.dart';
import 'package:kenari_app/pages/product_page.dart';
import 'package:kenari_app/pages/seller_page.dart';
import 'package:kenari_app/pages/seller_product_form_page.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/product_services/api_category_services.dart';
import 'package:kenari_app/services/api/product_services/api_product_services.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedMenu = 0;
  int selectedCard = 0;
  int openMenuFromPage = 0;

  String? name;
  String? companyCode;
  String filterType = 'Tampilkan Semua';

  TextEditingController searchController = TextEditingController();

  List<ProductData> productList = [];

  List<CategoryData> categoryList = [];

  List<TrolleyData> trolleyList = [];

  List<String> filterList = [
    'Tampilkan Semua',
    'Terbaru',
    'Terlaris',
    'Diskon',
    'Harga Terendah',
    'Harga Tertinggi',
  ];

  CategoryData? selectedCategory;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        name = nameResult;
      });

      await LocalSharedPrefs().readKey('company_code').then((companyCodeResult) async {
        setState(() {
          companyCode = companyCodeResult;
        });

        await loadCategory().then((_) async {
          await loadProduct().then((_) async {
            await loadTrolley();
          });
        });
      });
    });
  }

  Future loadCategory() async {
    await APICategoryServices(context: context).call().then((categoryResult) async {
      if(categoryResult != null && categoryResult.categoryData != null) {
        setState(() {
          categoryList = categoryResult.categoryData!;
        });
      }
    });
  }

  Future loadProduct() async {
    await APIProductServices(context: context).call().then((productResult) async {
      if(productResult != null && productResult.productData != null) {
        setState(() {
          productList = productResult.productData!;
        });
      }
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

  Widget activeFragment() {
    switch(selectedMenu) {
      case 0:
        List<ProductData> newProductList = [];
        List<ProductData> popularProductList = [];
        List<ProductData> discountProductList = [];

        for(int i = 0; i < productList.length; i++) {
          if(productList[i].createdAt != null) {
            if(DateTime.now().difference(DateTime.parse(productList[i].createdAt!)) < const Duration(days: 7)) {
              newProductList.add(productList[i]);
            }
          }

          if(productList[i].isRecomendation == true) {
            popularProductList.add(productList[i]);
          }

          if(productList[i].isPromo == true) {
            discountProductList.add(productList[i]);
          }
        }

        return HomeFragment(
          selectedCard: selectedCard,
          filterList: filterList,
          productList: productList,
          newProductList: newProductList,
          popularProductList: popularProductList,
          discountProductList: discountProductList,
          categoryList: categoryList,
          trolleyList: trolleyList,
          onChangeSelectedPage: (int page) {
            setState(() {
              selectedCard = page;
            });
          },
          onShowAllMenuBottomDialog: () => showAllMenuBottomDialog(),
          onShowProductBottomDialog: (ProductData product) => showProductBottomDialog(product),
          onProductSelected: (ProductData product) => MoveToPage(
              context: context,
              target: ProductPage(productId: product.sId!),
              callback: (callback) {
                loadTrolley();

                if(callback != null) {
                  if(callback == true) {
                    setState(() {
                      selectedMenu = 0;
                    });
                  } else {
                    setState(() {
                      selectedMenu = 2;
                      openMenuFromPage = 2;
                    });
                  }
                }
              },
            ).go(),
          onCallbackFromFeePage: (dynamic callback) {
            if(callback != null) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                  openMenuFromPage = 0;
                });
              }
            }
          },
          onCallbackFromLoanPage: (dynamic callback) {
            if(callback != null) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                  openMenuFromPage = 1;
                });
              }
            }
          },
          onCallbackFromSellerPage: (dynamic callback) {
            if(callback != null) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                  openMenuFromPage = 2;
                });
              }
            }
          },
          onCallbackFromTrolleyPage: (dynamic callback) {
            if(callback != null) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                  openMenuFromPage = 2;
                });
              }
            }
          },
          onCallbackFromProductListPage: (dynamic callback) {
            if(callback != null) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                  openMenuFromPage = 2;
                });
              }
            }
          },
          onRefreshPage: () => loadData(),
          onReloadTrolley: () => loadTrolley(),
        );
      case 1:
        List<ProductData> queryData = [];

        for(int i = 0; i < productList.length; i++) {
          if(selectedCategory != null) {
            if(filterType == 'Tampilkan Semua') {
              if(productList[i].productCategory != null && productList[i].productCategory!.sId == selectedCategory!.sId) {
                queryData.add(productList[i]);
              }
            } else {

            }
          } else {
            if(filterType == 'Tampilkan Semua') {
              queryData = productList;
            } else {

            }
          }
        }

        return SearchFragment(
          searchController: searchController,
          productList: queryData,
          categoryList: categoryList,
          filterList: filterList,
          filterType: filterType,
          onCategoryChange: (CategoryData? newSelectedCategory) {
            setState(() {
              selectedCategory = newSelectedCategory;
            });
          },
          onFilterChange: (String? selectedFilter) {
            if(selectedFilter != null) {
              setState(() {
                filterType = selectedFilter;
              });
            }
          },
          onRefreshPage: () => loadData(),
          onProductSelected: (ProductData product) => MoveToPage(
              context: context,
              target: ProductPage(productId: product.sId!),
              callback: (callback) {
                if(callback != null) {
                  if(callback == true) {
                    setState(() {
                      selectedMenu = 0;
                    });
                  } else {
                    setState(() {
                      selectedMenu = 2;
                      openMenuFromPage = 2;
                    });
                  }
                }
              },
            ).go(),
          selectedCategory: selectedCategory,
        );
      case 2:
        return TransactionFragment(
          openMenu: openMenuFromPage,
          changeTab: (index) {
            setState(() {
              openMenuFromPage = index;
            });
          },
          onCallbackFromLoanPage: (callback) {
            if(callback != null && callback == true) {
              if(callback == true) {
                setState(() {
                  selectedMenu = 0;
                });
              } else {
                setState(() {
                  selectedMenu = 2;
                });
              }
            }
          },
        );
      case 3:
        return ProfileFragment(
          name: name,
          companyCode: companyCode,
          refreshPage: () => loadData(),
          onLogout: () async => await LocalSharedPrefs().removeAllKey().then((removeResult) {
            if(removeResult == true) {
              RedirectToPage(context: context, target: const SplashPage()).go();
            }
          }),
        );
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Terjadi kesalahan....',
              style: HeadingTextStyles.headingM(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Silahkan muat ulang aplikasi, apabila kesalahan terus terjadi, mohon untuk segera menghubungi administrator.',
              style: LTextStyles.medium(),
              textAlign: TextAlign.center,
            ),
          ],
        );
    }
  }

  Future updateTrolley(int index, ProductData product, int qty) async {
    String? price = product.varians != null && product.varians!.isNotEmpty ?
    product.varians![index].isPromo != null && product.varians![index].isPromo == true ? product.varians![index].promoPrice : product.varians![index].price :
    product.isPromo != null && product.isPromo == true ? product.promoPrice : product.price;

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
            varianType1: product.varians![index].varianType1,
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

  Future<void> showAllMenuBottomDialog() async {
    List<Map> menuBottom = [
      {
        'title': 'Keuangan',
        'data': [
          {
            'images': 'assets/images/icon_iuran.png',
            'title': 'Iuran',
            'description': 'Bayar Iuran wajib dan berjangka Perusahaan kamu disini',
            'function': () {
              MoveToPage(
                context: context,
                target: const FeePage(),
                callback: (callbackResult) {
                  if(callbackResult != null) {
                    BackFromThisPage(context: context, callbackData: [callbackResult, 0]).go();
                  }
                },
              ).go();
            },
          },
          {
            'images': 'assets/images/icon_pinjaman.png',
            'title': 'Pinjaman',
            'description': 'Dapatkan pinjaman uang untuk pengembangan usaha mu dan kebutuhan lainnya disini',
            'function': () {
              MoveToPage(
                context: context,
                target: const LoanPage(),
                callback: (callbackResult) {
                  if(callbackResult != null) {
                    BackFromThisPage(context: context, callbackData: [callbackResult, 1]).go();
                  }
                },
              ).go();
            },
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
            'function': () {
              MoveToPage(
                context: context,
                target: const SellerPage(),
                callback: (callbackResult) {
                  if(callbackResult != null) {
                    BackFromThisPage(context: context, callbackData: [callbackResult, 2]).go();
                  }
                },
              ).go();
            },
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
                                onTap: () {
                                  menuBottom[index]['data'][subIndex]['function']();
                                },
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
    ).then((result) {
      if(result != null && result!.isNotEmpty && result![0] == false) {
        setState(() {
          selectedMenu = 2;
          openMenuFromPage = result![1];
        });
      }
    });
  }

  Future<void> showProductBottomDialog(ProductData product) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        int index = 0;
        int qty = 1;
        int stock = product.stock != null && product.stock != '' ? int.parse(product.stock!) : 0;

        String price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';
        String imagePath = "$baseURL/${product.images != null && product.images![0].url != null ? product.images![0].url! : ''}";
        String? variant;

        if(product.varians != null && product.varians!.isNotEmpty) {
          variant = product.varians![index].name1 ?? 'Unknown Variant';
        }

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
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const SizedBox(
                                width: 80.0,
                                height: 80.0,
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
                              product.name ?? 'Unknown Product',
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
                product.varians != null ?
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
                                onTap: () {
                                  stateSetter(() {
                                    index = itemIndex;
                                    variant = product.varians![itemIndex].name1 ?? 'Unknown Variant';

                                    if(product.isPromo != null && product.isPromo == true) {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.promoPrice ?? '0')).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';
                                    }
                                  });
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    product.varians![itemIndex].name1 ?? 'Unknown Variant',
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
                            color: product.isStockAlwaysAvailable == null || product.isStockAlwaysAvailable! == false ? qty == stock ? NeutralColorStyles.neutral03() : NeutralColorStyles.neutral04() : NeutralColorStyles.neutral04(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
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
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Icon(
                            Icons.add,
                            color: product.isStockAlwaysAvailable == null || product.isStockAlwaysAvailable! == false ? qty == stock ? NeutralColorStyles.neutral04() : IconColorStyles.iconColor() : IconColorStyles.iconColor(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            BackFromThisPage(context: context).go();

                            updateTrolley(index, product, qty);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryColorStyles.primaryMain(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Tambah ke Troli',
                                  style: LTextStyles.medium().copyWith(
                                    color: Colors.white,
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
          color: SuccessColorStyles.successSurface(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedMenu == 0 ? const Color(0xffff7a15) : Colors.white,
      body: SafeArea(
        child: activeFragment(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 0) {
                          setState(() {
                            selectedMenu = 0;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Beranda',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 0 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 1) {
                          setState(() {
                            selectedMenu = 1;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Pencarian',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 1 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 2) {
                          setState(() {
                            selectedMenu = 2;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper,
                              color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Transaksi',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 2 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25.0,
                    ),
                    InkWell(
                      onTap: () {
                        if(selectedMenu != 3) {
                          setState(() {
                            selectedMenu = 3;
                          });
                        }
                      },
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Profile',
                              style: XSTextStyles.regular().copyWith(
                                color: selectedMenu == 3 ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral05(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MoveToPage(context: context, target: const SellerProductFormPage()).go();
        },
        backgroundColor: PrimaryColorStyles.primaryMain(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}