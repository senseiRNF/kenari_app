import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerProductDetailPage extends StatefulWidget {
  const SellerProductDetailPage({super.key});

  @override
  State<SellerProductDetailPage> createState() => _SellerProductDetailPageState();
}

class _SellerProductDetailPageState extends State<SellerProductDetailPage> {
  Map productData = {
    'title': 'Cabai Merah',
    'image': 'assets/images/example_images/cabai-rawit-merah.png',
    'description': 'Cabai atau cabe merah atau lombok (bahasa Jawa) adalah buah dan tumbuhan anggota genus Capsicum. Buahnya dapat digolongkan sebagai sayuran maupun bumbu, tergantung bagaimana digunakan. Sebagai bumbu, buah cabai yang pedas sangat populer di Asia Tenggara sebagai penguat rasa makanan. Bagi seni masakan Padang, cabai bahkan dianggap sebagai "bahan makanan pokok" kesepuluh (alih-alih sembilan). Sangat sulit bagi masakan Padang dibuat tanpa cabai.',
    'price': [25000, 65000],
    'variant_stock': {
      'variant': 'Berat',
      'subvariant': [
        {
          'name': '1/4 Kg',
          'stock': 1,
          'is_always_available': true,
        },
        {
          'name': '1/2 Kg',
          'stock': 13,
          'is_always_available': false,
        },
        {
          'name': '1 Kg',
          'stock': 1,
          'is_always_available': true,
        },
      ],
    },
    'company': {
      'name': 'PT. Surya Fajar Capital. tbk',
      'phone': '0123456789',
      'address': 'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
    },
  };

  List priceList = [];

  int minPrice = 0;
  int maxPrice = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      priceList = productData['price'];

      priceList.sort();
      minPrice = priceList[0];
      maxPrice = priceList[priceList.length - 1];
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
                              return Container(
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: PrimaryColorStyles.primarySurface(),
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      productData['image'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {

                                    },
                                    onLongPress: () {

                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
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
                            productData['title'],
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
                            productData['description'],
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
                          Text(
                            productData['variant_stock']['variant'],
                            style: LTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productData['variant_stock']['subvariant'].length,
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
                                    productData['variant_stock']['subvariant'][subvariantIndex]['name'],
                                    style: MTextStyles.regular(),
                                  ),
                                  Text(
                                    productData['variant_stock']['subvariant'][subvariantIndex]['is_always_available'] == true ? 'Stok Selalu Ada' : "${productData['variant_stock']['subvariant'][subvariantIndex]['stock']}",
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
                            productData['company']['name'],
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData['company']['phone'],
                            style: MTextStyles.regular(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            productData['company']['address'],
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

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColorStyles.primaryMain(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Ubah detail produk',
                          style: LTextStyles.medium(),
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
                            BackFromThisPage(context: context, callbackData: false).go();
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