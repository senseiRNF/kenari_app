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
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
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

  int imageSelected = 1;

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

  Future<void> showProductBottomDialog(DetailProductData product, int selectedIndex) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
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
                      CachedNetworkImage(
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
                                  'Unable to load image',
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
                            loadTrolley();

                            if(callbackResult != null) {
                              if(callbackResult == true) {
                                BackFromThisPage(context: context).go();
                              } else {
                                BackFromThisPage(context: context, callbackData: callbackResult).go();
                              }
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
                              width: 10.0,
                              height: 10.0,
                              margin: const EdgeInsets.only(left: 15.0),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
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
                                      fit: BoxFit.contain,
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
                                        'Unable to load image',
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
                              detailProductData!.name ?? 'Unknown Product',
                              style: LTextStyles.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(detailProductData!.isPromo != null && detailProductData!.isPromo == true ? detailProductData!.promoPrice ?? '0' : detailProductData!.price ?? '0'))}',
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
                                        detailProductData!.productCategory != null && detailProductData!.productCategory!.name != null ? detailProductData!.productCategory!.name! : 'Unknown Product',
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
                                              color: BorderColorStyles.borderStrokes(),
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showProductBottomDialog(detailProductData!, itemIndex);
                                            },
                                            customBorder: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                              child: Text(
                                                detailProductData!.varians![itemIndex].name1 ?? 'Unknown Variant',
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
                              detailProductData!.company != null && detailProductData!.company!.name != null ? detailProductData!.company!.name! : 'Unknown Company',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                detailProductData!.company != null && detailProductData!.company!.phone != null ? detailProductData!.company!.phone! : 'Unknown Phone Number',
                                style: STextStyles.regular().copyWith(
                                  color: NeutralColorStyles.neutral08(),
                                ),
                              ),
                            ),
                            Text(
                              detailProductData!.address != null && detailProductData!.address!.address != null ? detailProductData!.address!.address! : 'Unknown Address',
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
                  onPressed: () {
                    showProductBottomDialog(detailProductData!, 0);
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