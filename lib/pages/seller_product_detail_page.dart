import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/seller_product_form_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/seller_product_detail_model.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductDetailPage extends StatefulWidget {
  final String productId;
  
  const SellerProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  State<SellerProductDetailPage> createState() => _SellerProductDetailPageState();
}

class _SellerProductDetailPageState extends State<SellerProductDetailPage> {
  SellerProductDetailData? sellerProductDetailData;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    SellerProductDetailData? tempSellerProductDetailData;

    await APISellerProductServices(context: context).callById(widget.productId).then((callResult) {
      if(callResult != null && callResult.sellerProductDetailData != null) {
        tempSellerProductDetailData = callResult.sellerProductDetailData;
      }

      setState(() {
        sellerProductDetailData = tempSellerProductDetailData;
      });
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
              child: sellerProductDetailData != null ?
              RefreshIndicator(
                onRefresh: () async => loadData(),
                child: ListView(
                  children: [
                    sellerProductDetailData!.images != null ?
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
                              itemCount: sellerProductDetailData!.images!.length,
                              itemBuilder: (BuildContext imgContext, int index) {
                                return CachedNetworkImage(
                                  imageUrl: "$baseURL/${sellerProductDetailData!.images![index].url ?? ''}",
                                  fit: BoxFit.contain,
                                  width: 110.0,
                                  height: 100.0,
                                  imageBuilder: (context, imgProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imgProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
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
                    ) :
                    const Material(),
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
                              sellerProductDetailData!.name ?? '',
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
                              sellerProductDetailData!.description ?? '',
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
                              'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(sellerProductDetailData!.price ?? '0')).replaceAll(',', '.')}',
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
                            sellerProductDetailData!.varians != null ?
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: sellerProductDetailData!.varians != null ? sellerProductDetailData!.varians!.length : 0,
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
                                      "${sellerProductDetailData!.varians != null && sellerProductDetailData!.varians!.isNotEmpty ? sellerProductDetailData!.varians![subvariantIndex].name1 ?? '' : ''} ${sellerProductDetailData!.varians != null && sellerProductDetailData!.varians!.isNotEmpty ? sellerProductDetailData!.varians![subvariantIndex].name2 ?? '' : ''}",
                                      style: MTextStyles.regular(),
                                    ),
                                    Text(
                                      sellerProductDetailData!.varians![subvariantIndex].isStockAlwaysAvailable != null && sellerProductDetailData!.varians![subvariantIndex].isStockAlwaysAvailable == true ? 'Stok Selalu Ada' : sellerProductDetailData!.varians![subvariantIndex].stock ?? '0',
                                      style: MTextStyles.medium(),
                                    ),
                                  ],
                                );
                              },
                            ) :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  " - ",
                                  style: MTextStyles.regular(),
                                ),
                                Text(
                                  sellerProductDetailData!.isStockAlwaysAvailable == true ? 'Stok Selalu Ada' : sellerProductDetailData!.stock ?? '0',
                                  style: MTextStyles.medium(),
                                ),
                              ],
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
                            sellerProductDetailData!.company != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  sellerProductDetailData!.company!.name ?? '',
                                  style: MTextStyles.medium(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  sellerProductDetailData!.company!.phone != null && sellerProductDetailData!.company!.phone != '' ? sellerProductDetailData!.company!.phone! : '(Nomor telepon tidak terdaftar)',
                                  style: MTextStyles.regular(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  sellerProductDetailData!.address != null ? sellerProductDetailData!.address!.address ?? '' : '',
                                  style: MTextStyles.regular(),
                                ),
                              ],
                            ) :
                            const Material(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: Image.asset(
                          'assets/images/icon_seller_product_empty.png',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Data produk tidak tersedia',
                              style: HeadingTextStyles.headingS(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Silahkan coba muat ulang halaman kembali',
                              style: MTextStyles.medium(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async => loadData(),
                    child: ListView(
                      children: const [],
                    ),
                  ),
                ],
              ),
            ),
            sellerProductDetailData != null ?
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => MoveToPage(
                        context: context,
                        target: SellerProductFormPage(
                          productId: sellerProductDetailData!.sId,
                        ),
                      ).go(),
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
                          yesFunction: () async {
                            await APISellerProductServices(context: context).dioCancel(sellerProductDetailData!.sId).then((cancelResult) {
                              if(cancelResult == true) {
                                BackFromThisPage(
                                  context: context,
                                  callbackData: true,
                                ).go();
                              }
                            });
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
            ) :
            const Material(),
          ],
        ),
      ),
    );
  }
}