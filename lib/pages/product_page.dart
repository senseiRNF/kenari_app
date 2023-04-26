import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductPage extends StatefulWidget {
  final ProductData productData;

  const ProductPage({
    super.key,
    required this.productData,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController searchController = TextEditingController();

  late String price;

  int imageSelected = 1;

  bool expandDesc = false;

  @override
  void initState() {
    super.initState();

    if(widget.productData.varians == null || widget.productData.varians!.isEmpty) {
      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(widget.productData.price != null ? widget.productData.price! : '0')).replaceAll(',', '.')}';
    } else {
      List sortedVariantPrice = widget.productData.varians!;

      sortedVariantPrice.sort((a, b) => a.price.compareTo(b.price));

      int lowest = int.parse(sortedVariantPrice[0].price != null && sortedVariantPrice[0].price != '' ? sortedVariantPrice[0].price : '0');
      int highest = int.parse(sortedVariantPrice[sortedVariantPrice.length - 1].price != null && sortedVariantPrice[sortedVariantPrice.length - 1].price != '' ? sortedVariantPrice[sortedVariantPrice.length - 1].price : '0');

      price = 'Rp ${NumberFormat('#,###', 'en_id').format(lowest).replaceAll(',', '.')} - ${NumberFormat('#,###', 'en_id').format(highest).replaceAll(',', '.')}';
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
                          target: const TrolleyPage(
                            productList: [

                            ],
                          ),
                          callback: (callbackResult) {
                            if(callbackResult != null) {

                            }
                          },
                        ).go();
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
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        widget.productData.images != null ?
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 300,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            onPageChanged: (page, whyChanged) {
                              setState(() {
                                imageSelected = page + 1;
                              });
                            },
                          ),
                          items: widget.productData.images!.map((product) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    product.url ?? '',
                                  ),
                                  fit: BoxFit.fitHeight,
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
                                          '$imageSelected / ${widget.productData.images!.length}',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontBodyWeight.medium(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ) :
                        const Material(),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            widget.productData.name ?? 'Unknown Product',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            price,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: PrimaryColorStyles.primaryMain(),
                              fontWeight: FontBodyWeight.medium(),
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
                                      widget.productData.productCategory != null && widget.productData.productCategory!.name != null ? widget.productData.productCategory!.name! : 'Unknown Product',
                                      style: Theme.of(context).textTheme.labelSmall!,
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
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: TextColorStyles.textPrimary(),
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Min Pemesanan',
                                        style: Theme.of(context).textTheme.bodySmall!,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '1 Buah',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          color: TextColorStyles.textPrimary(),
                                          fontWeight: FontBodyWeight.medium(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Stok',
                                      style: Theme.of(context).textTheme.bodySmall!,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.productData.isStockAlwaysAvailable != null && widget.productData.isStockAlwaysAvailable! == true ? 'Stok selalu tersedia' :
                                      '${widget.productData.stock != null && widget.productData.stock != '' ? widget.productData.stock! : '0'} Buah',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: TextColorStyles.textPrimary(),
                                        fontWeight: FontBodyWeight.medium(),
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
                          child: widget.productData.varians != null && widget.productData.varians!.isNotEmpty ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  'Pilih Varian :',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: TextColorStyles.textPrimary(),
                                    fontWeight: FontBodyWeight.medium(),
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
                                    itemCount: widget.productData.varians!.length,
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
                                            showProductBottomDialog(widget.productData);
                                          },
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                            child: Text(
                                              widget.productData.varians![itemIndex].name1 ?? 'Unknown Variant',
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
                          ) : const
                          Material(),
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
                            style: Theme.of(context).textTheme.bodySmall!..copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'PT. Surya Fajar Capital. tbk',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              '081234567890',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: NeutralColorStyles.neutral08(),
                              ),
                            ),
                          ),
                          Text(
                            'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.productData.description ?? '',
                            maxLines: expandDesc ? null : 3,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: TextColorStyles.textPrimary(),
                              fontWeight: FontBodyWeight.medium(),
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
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: PrimaryColorStyles.primaryMain(),
                                      fontWeight: FontBodyWeight.medium(),
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
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    showProductBottomDialog(widget.productData);
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
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        int stock = product.isStockAlwaysAvailable != null && product.isStockAlwaysAvailable! == true ? 1 : int.parse(product.stock != null && product.stock != '' ? product.stock! : '0');

        String price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.price ?? '0')).replaceAll(',', '.')}';
        String imagePath = product.images != null && product.images![index].url != null ? product.images![index].url! : '';
        String? variant;

        if(product.varians != null) {
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
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontBodyWeight.medium(),
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
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              imagePath,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const SizedBox(
                          width: 80.0,
                          height: 80.0,
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
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontBodyWeight.medium(),
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
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                        fontWeight: FontBodyWeight.medium(),
                                      ),
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
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                                fontWeight: FontBodyWeight.medium(),
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
                                  style: Theme.of(context).textTheme.bodySmall!,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    product.isStockAlwaysAvailable != null && product.isStockAlwaysAvailable! == true ? 'Selalu ada' : stock.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontBodyWeight.medium(),
                                    ),
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontBodyWeight.medium(),
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

                                    if(product.promoPrice != null && product.promoPrice != '') {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(product.promoPrice!)).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.price ?? '0').replaceAll(',', '.')}';
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
                          style: Theme.of(context).textTheme.headlineSmall,
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

                            showToastMessage();
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
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontBodyWeight.medium(),
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

  showToastMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Card(
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
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: SuccessColorStyles.successMain(),
                      fontWeight: FontBodyWeight.medium(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}