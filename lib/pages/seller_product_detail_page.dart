import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/models/seller_product_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductDetailPage extends StatefulWidget {
  final SellerProductData sellerProductData;
  
  const SellerProductDetailPage({
    super.key,
    required this.sellerProductData,
  });

  @override
  State<SellerProductDetailPage> createState() => _SellerProductDetailPageState();
}

class _SellerProductDetailPageState extends State<SellerProductDetailPage> {
  SellerProductData productData = SellerProductData();

  List priceList = [];

  int minPrice = 0;
  int maxPrice = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      priceList.add(productData.price ?? '0');

      priceList.sort();
      minPrice = int.parse(priceList[0] ?? '0');
      maxPrice = int.parse(priceList[priceList.length - 1] ?? '0');
    });
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
                          child: Text(
                            'Atur Produk',
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
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Gallery Produk',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                              crossAxisCount: 4,
                            ),
                            itemCount: 3,
                            itemBuilder: (BuildContext imgContext, int index) {
                              return CachedNetworkImage(
                                imageUrl: productData.images != null && productData.images!.isNotEmpty ? productData.images![0].url ?? '' : '',
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
                                        'Unable to load image',
                                        style: XSTextStyles.medium(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
                            'Nama Produk',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData.name ?? '',
                            style: MTextStyles.regular().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            'Deskripsi Produk',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData.description ?? '',
                            style: MTextStyles.regular().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            'Harga Produk',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Rp ${NumberFormat('#,###', 'en_id').format(minPrice).replaceAll(',', '.')} - Rp ${NumberFormat('#,###', 'en_id').format(maxPrice).replaceAll(',', '.')}',
                            style: MTextStyles.regular().copyWith(
                              color: TextColorStyles.textPrimary(),
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            'Stok & Varian',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productData.varians != null ? productData.varians!.length : 0,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return const SizedBox(
                                height: 5.0,
                              );
                            },
                            itemBuilder: (BuildContext subvariantContext, int subvariantIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${productData.varians != null && productData.varians!.isNotEmpty ? productData.varians![0].name1 ?? '' : ''} ${productData.varians != null && productData.varians!.isNotEmpty ? productData.varians![0].name2 ?? '' : ''}",
                                    style: MTextStyles.regular(),
                                  ),
                                  Text(
                                    productData.varians![subvariantIndex].isStockAlwaysAvailable != null && productData.varians![subvariantIndex].isStockAlwaysAvailable == true ? 'Stok Selalu Ada' : productData.varians![subvariantIndex].stock ?? '0',
                                    style: MTextStyles.medium(),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            'Alamat Pengambilan',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData.company != null ? productData.company!.name ?? '' : '',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData.company != null ? productData.company!.phone ?? '' : '',
                            style: MTextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData.company != null ? productData.company!.addresses != null && productData.company!.addresses!.isNotEmpty ? productData.company!.addresses![0] : '' : '',
                            style: MTextStyles.regular(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BackFromThisPage(
                          context: context,
                          callbackData: {
                            'status': true,
                            'data': productData,
                          },
                        ).go();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Ubah detail produk',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        OptionDialog(
                          context: context,
                          title: 'Batalkan Titip Jual',
                          message: 'Produk ini akan dihapus secara permanen dan Anda tidak dapat mengaksesnya kembali. Lanjutkan?',
                          yesFunction: () {
                            BackFromThisPage(
                              context: context,
                              callbackData: {
                                'status': false,
                                'data': '',
                              },
                            ).go();
                          },
                          noFunction: () {

                          },
                        ).show();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primarySurface(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Batalkan Penitipan',
                          style: LTextStyles.medium().copyWith(
                            color: PrimaryColorStyles.primaryMain(),
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
      ),
    );
  }
}