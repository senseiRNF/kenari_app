import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/trolley_page.dart';
import 'package:kenari_app/services/local/models/local_product_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ProductPage extends StatefulWidget {
  final LocalProductData productData;

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

  String description = 'Cabai atau cabe merah atau lombok (bahasa Jawa) adalah buah dan tumbuhan anggota genus Capsicum. Buahnya dapat digolongkan sebagai sayuran maupun bumbu, tergantung bagaimana digunakan. Sebagai bumbu, buah cabai yang pedas sangat populer di Asia Tenggara sebagai penguat rasa makanan. Bagi seni masakan Padang, cabai bahkan dianggap sebagai "bahan makanan pokok" kesepuluh (alih-alih sembilan). Sangat sulit bagi masakan Padang dibuat tanpa cabai.';

  bool expandDesc = false;

  @override
  void initState() {
    super.initState();

    if(widget.productData.normalPrice.length == 1) {
      price = 'Rp ${NumberFormat('#,###', 'en_id').format(widget.productData.normalPrice[0]).replaceAll(',', '.')}';
    } else {
      int lowest = widget.productData.normalPrice.reduce(min);
      int highest = widget.productData.normalPrice.reduce(max);

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
                          target: TrolleyPage(
                            productList: [
                              LocalProductData(
                                type: 'Sembako',
                                name: 'Cabai Merah',
                                variant: ['1/4 Kg', '1/2 Kg', '1 Kg'],
                                normalPrice: [25000, 45000, 65000],
                                discountPrice: [0, 0, 0],
                                stock: [50, 50, 50],
                                imagePath: ['assets/images/example_images/cabai-rawit-merah.png'],
                                newFlag: true,
                                popularFlag: false,
                                discountFlag: false,
                              ),
                              LocalProductData(
                                type: 'Outfit',
                                name: 'Kaos Terkini',
                                normalPrice: [400000],
                                discountPrice: [200000],
                                stock: [50],
                                imagePath: ['assets/images/example_images/kaos-terkini.png'],
                                newFlag: false,
                                popularFlag: true,
                                discountFlag: true,
                              ),
                              LocalProductData(
                                type: 'Outfit',
                                name: 'Blue Jeans',
                                normalPrice: [400000],
                                discountPrice: [200000],
                                stock: [50],
                                imagePath: ['assets/images/example_images/blue-jeans.png'],
                                newFlag: false,
                                popularFlag: true,
                                discountFlag: true,
                              ),
                              LocalProductData(
                                type: 'Elektronik',
                                name: 'Vape Electric',
                                normalPrice: [400000],
                                discountPrice: [0],
                                stock: [50],
                                imagePath: ['assets/images/example_images/vape-electric.png'],
                                newFlag: false,
                                popularFlag: true,
                                discountFlag: false,
                              ),
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
                          items: widget.productData.imagePath.map((product) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    product ?? '',
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
                                          '$imageSelected / ${widget.productData.imagePath.length}',
                                          style: MTextStyles.medium().copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            widget.productData.name,
                            style: LTextStyles.medium(),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            price,
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
                                      widget.productData.type,
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
                                      '${widget.productData.stock[0]} Buah',
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
                          child: widget.productData.variant != null ?
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
                                    itemCount: widget.productData.variant!.length,
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
                                              widget.productData.variant![itemIndex],
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
                            style: STextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'PT. Surya Fajar Capital. tbk',
                            style: STextStyles.medium().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              '081234567890',
                              style: STextStyles.regular().copyWith(
                                color: NeutralColorStyles.neutral08(),
                              ),
                            ),
                          ),
                          Text(
                            'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
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
                            description,
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
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
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

  Future<void> showProductBottomDialog(LocalProductData product) async {
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
        int stock = product.stock[index];

        String price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.normalPrice[index]).replaceAll(',', '.')}';
        String imagePath = product.imagePath[index] ?? '';
        String? variant;

        if(product.variant != null) {
          variant = product.variant![index];
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
                    product.variant != null ? 'Varian Produk' : 'Tambah Troli',
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
                              product.name,
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
                                    product.type == 'Sembako' ? 'Selalu ada' : stock.toString(),
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
                product.variant != null ?
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
                          itemCount: product.variant!.length,
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
                                    variant = product.variant![itemIndex];

                                    if(product.discountPrice[index] != 0) {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.discountPrice[index]).replaceAll(',', '.')}';
                                    } else {
                                      price = 'Rp ${NumberFormat('#,###', 'en_id').format(product.normalPrice[index]).replaceAll(',', '.')}';
                                    }
                                  });
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    product.variant![itemIndex],
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
                            color: product.type != 'Sembako' ? qty == stock ? NeutralColorStyles.neutral03() : NeutralColorStyles.neutral04() : NeutralColorStyles.neutral04(),
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            if(product.type != 'Sembako') {
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
                            color: product.type != 'Sembako' ? qty == stock ? NeutralColorStyles.neutral04() : IconColorStyles.iconColor() : IconColorStyles.iconColor(),
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
                    style: XSTextStyles.medium().copyWith(
                      color: SuccessColorStyles.successMain(),
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