import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/detail_product_model.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/api/product_services/api_product_services.dart';
import 'package:kenari_app/services/api/trolley_services/api_trolley_services.dart';
import 'package:kenari_app/services/local/jsons/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  const ProductPage({
    super.key,
    required this.productId,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<TrolleyData> trolleyList = [];

  TextEditingController searchController = TextEditingController();

  DetailProductData? detailProductData;

  int? selectedVarian;
  int imageSelected = 1;
  int productPrice = 0;

  bool expandDesc = false;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APIProductServices(context: context).callById(widget.productId).then((detailResult) {
      if(detailResult != null && detailResult.detailProductData != null) {
        setState(() {
          detailProductData = detailResult.detailProductData;
        });

        if(detailResult.detailProductData!.varians != null && detailResult.detailProductData!.varians!.isNotEmpty) {
          setState(() {
            selectedVarian = 0;

            if(detailResult.detailProductData!.varians![0].isPromo != null && detailResult.detailProductData!.varians![0].isPromo == true) {
              productPrice = int.parse(detailResult.detailProductData!.varians![0].promoPrice ?? '0');
            } else {
              productPrice = int.parse(detailResult.detailProductData!.varians![0].price ?? '0');
            }
          });
        } else {
          setState(() {
            if(detailResult.detailProductData!.isPromo != null && detailResult.detailProductData!.isPromo == true) {
              productPrice = int.parse(detailResult.detailProductData!.promoPrice ?? '0');
            } else {
              productPrice = int.parse(detailResult.detailProductData!.price ?? '0');
            }
          });
        }
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

  Future updateTrolley(int index, DetailProductData product, int qty) async {
    String? price = product.varians != null && product.varians!.isNotEmpty ?
    product.varians![index].isPromo != null && product.varians![index].isPromo == true ? product.varians![index].promoPrice ?? '0': product.varians![index].price ?? '0' :
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

  Future showProductBottomDialog(DetailProductData product, int selectedIndex) async {
    int index = selectedIndex;
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
                      CachedNetworkImage(
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
                                      variant,
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
                                onTap: () {
                                  stateSetter(() {
                                    index = itemIndex;
                                    qty = 1;

                                    if(product.varians != null && product.varians!.isNotEmpty) {
                                      if(product.varians![index].isPromo != null && product.varians![index].isPromo == true) {
                                        price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].promoPrice ?? '0')).replaceAll(',', '.')}';

                                        setState(() {
                                          productPrice = int.parse(product.varians![index].promoPrice ?? '0');
                                        });
                                      } else {
                                        price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.varians![index].price ?? '0')).replaceAll(',', '.')}';

                                        setState(() {
                                          productPrice = int.parse(product.varians![index].price ?? '0');
                                        });
                                      }
                                    } else {
                                      if(product.isPromo != null && product.isPromo == true) {
                                        price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.promoPrice ?? '0')).replaceAll(',', '.')}';

                                        setState(() {
                                          productPrice = int.parse(product.promoPrice ?? '0');
                                        });
                                      } else {
                                        price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';

                                        setState(() {
                                          productPrice = int.parse(product.price ?? '0');
                                        });
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
                                  });

                                  setState(() {
                                    selectedVarian = itemIndex;
                                  });
                                },
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
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
                        MoveToPage(
                          context: context,
                          target: const TrolleyPage(),
                          callback: (callbackResult) {
                            if(callbackResult != null) {
                              BackFromThisPage(context: context, callbackData: callbackResult).go();
                            } else {
                              loadData();
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
            ),
            Expanded(
              child: detailProductData != null ?
              RefreshIndicator(
                onRefresh: () async {
                  loadData();
                },
                child: ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          detailProductData!.images != null && detailProductData!.images!.isNotEmpty ?
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300,
                              enableInfiniteScroll: detailProductData!.images!.length > 1 ? true : false,
                              viewportFraction: 1.0,
                              onPageChanged: (page, whyChanged) {
                                setState(() {
                                  imageSelected = page + 1;
                                });
                              },
                            ),
                            items: detailProductData!.images!.map((product) {
                              return CachedNetworkImage(
                                imageUrl: "$baseURL/${product.url ?? ''}",
                                imageBuilder: (context, imgProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imgProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: Card(
                                          color: Colors.black38,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                            child: Text(
                                              '$imageSelected / ${detailProductData!.images!.length}',
                                              style: MTextStyles.medium().copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                errorWidget: (context, url, error) {
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
                              );
                            }).toList(),
                          ) :
                          SizedBox(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Icon(
                                  Icons.image_search,
                                  size: 40.0,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  'Produk tidak memiliki gambar',
                                  style: MTextStyles.medium(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              detailProductData!.name ?? '(Produk tidak diketahui)',
                              style: LTextStyles.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Rp ${NumberFormat('#,###', 'en_id').format(productPrice).replaceAll(',', '.')}',
                              style: LTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Divider(
                              height: 1.0,
                              color: BorderColorStyles.borderDivider(),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                Container(
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
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                                      child: Text(
                                        detailProductData!.productCategory != null && detailProductData!.productCategory!.name != null ? detailProductData!.productCategory!.name! : '(Produk tidak diketahui)',
                                        style: XSTextStyles.regular(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Detail Produk',
                                  style: STextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Min Pemesanan',
                                          style: STextStyles.regular(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '1 Buah',
                                          style: STextStyles.medium().copyWith(
                                            color: TextColorStyles.textPrimary(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                detailProductData!.varians != null && detailProductData!.varians!.isNotEmpty ?
                                const Material() :
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Stok',
                                        style: STextStyles.regular(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        detailProductData!.isStockAlwaysAvailable != null && detailProductData!.isStockAlwaysAvailable! == true ? 'Stok selalu tersedia' :
                                        '${detailProductData!.stock != null && detailProductData!.stock != '' ? detailProductData!.stock! : '0'} Buah',
                                        style: STextStyles.medium().copyWith(
                                          color: TextColorStyles.textPrimary(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: detailProductData!.varians != null && detailProductData!.varians!.isNotEmpty ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    'Pilih Varian :',
                                    style: STextStyles.medium().copyWith(
                                      color: TextColorStyles.textPrimary(),
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
                                      itemCount: detailProductData!.varians!.length,
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
                                              color: selectedVarian != null && selectedVarian == itemIndex ? PrimaryColorStyles.primaryMain() : BorderColorStyles.borderStrokes(),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedVarian = itemIndex;

                                                if(detailProductData!.varians![itemIndex].isPromo != null && detailProductData!.varians![itemIndex].isPromo == true) {
                                                  productPrice = int.parse(detailProductData!.varians![itemIndex].promoPrice ?? '0');
                                                } else {
                                                  productPrice = int.parse(detailProductData!.varians![itemIndex].price ?? '0');
                                                }
                                              });

                                              showProductBottomDialog(detailProductData!, itemIndex);
                                            },
                                            customBorder: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                              child: Text(
                                                detailProductData!.varians![itemIndex].name1 ?? '(Varian tidak diketahui)',
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Alamat Pengambilan :',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              detailProductData!.company != null && detailProductData!.company!.name != null ? detailProductData!.company!.name! : '(Nama perusahaan tidak terdaftar)',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                detailProductData!.company != null && detailProductData!.company!.phone != null ? detailProductData!.company!.phone! : '(Nomor telepon tidak terdaftar) Number',
                                style: STextStyles.regular().copyWith(
                                  color: NeutralColorStyles.neutral08(),
                                ),
                              ),
                            ),
                            Text(
                              detailProductData!.address != null && detailProductData!.address!.address != null ? detailProductData!.address!.address! : '(Alamat tidak diketahui)',
                              style: STextStyles.regular().copyWith(
                                color: NeutralColorStyles.neutral06(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Deskripsi :',
                              style: MTextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              detailProductData!.description ?? '',
                              maxLines: expandDesc ? null : 3,
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                              overflow: TextOverflow.fade,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      expandDesc = !expandDesc;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(
                                      expandDesc ? 'Lihat lebih sedikit' : 'Lihat lebih banyak',
                                      style: STextStyles.medium().copyWith(
                                        color: PrimaryColorStyles.primaryMain(),
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
                    const SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Tidak dapat memuat data produk',
                        style: MTextStyles.medium(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {
                      loadData();
                    },
                    child: ListView(),
                  ),
                ],
              ),
            ),
            detailProductData != null ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () => showProductBottomDialog(detailProductData!, selectedVarian ?? 0),
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
            ) :
            const Material(),
          ],
        ),
      ),
      floatingActionButton: const SizedBox(
        height: 85.0,
        width: 85.0,
      ),
    );
  }
}