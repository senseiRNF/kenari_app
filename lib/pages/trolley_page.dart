import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/models/local_product_data.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key});

  @override
  State<TrolleyPage> createState() => _TrolleyPageState();
}

class _TrolleyPageState extends State<TrolleyPage> {
  List<LocalTrolleyProduct> productList = [
    LocalTrolleyProduct(
      isSelected: false,
      productData: LocalProductData(
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
      qty: 1,
    ),
    LocalTrolleyProduct(
      isSelected: false,
      productData: LocalProductData(
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
      qty: 1,
    ),
    LocalTrolleyProduct(
      isSelected: false,
      productData: LocalProductData(
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
      qty: 1,
    ),
    LocalTrolleyProduct(
      isSelected: false,
      productData: LocalProductData(
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
      qty: 1,
    ),
  ];

  bool isSelectedAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
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
                      'Troli',
                      style: HeadingTextStyles.headingS(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: productList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            onChanged: (newValue) {
                              if(newValue != null) {
                                setState(() {
                                  isSelectedAll = newValue;

                                  for(int i = 0; i < productList.length; i++) {
                                    productList[i].isSelected = newValue;
                                  }
                                });
                              }
                            },
                            value: isSelectedAll,
                            title: Text(
                              'Pilih Semua Barang',
                              style: STextStyles.regular(),
                            ),
                            dense: true,
                            activeColor: Theme.of(context).primaryColor,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: InkWell(
                            onTap: () {

                            },
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.delete,
                                color: IconColorStyles.iconColor(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (BuildContext listTrolleyContext, int index) {
                        final trolleyItem = productList[index].productData.name;

                        return Dismissible(
                          key: Key(trolleyItem),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              productList.removeAt(index);
                            });
                          },
                          confirmDismiss: (confirm) async {
                            bool result = false;

                            await OptionDialog(
                              context: context,
                              title: 'Hapus Produk?',
                              message: 'Produk yang di pilih akan di hapus dari daftar Troli. Lanjutkan?',
                              yesFunction: () async {
                                result = true;

                                setState(() {
                                  productList.removeAt(index);
                                });
                              },
                              noFunction: () {

                              },
                            ).show();

                            return result;
                          },
                          background: Container(
                            color: PrimaryColorStyles.primaryMain(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: productList[index].isSelected,
                                  onChanged: (selectProduct) {
                                    if(selectProduct != null) {
                                      setState(() {
                                        productList[index].isSelected = selectProduct;
                                      });

                                      for(int i = 0; i < productList.length; i++) {
                                        if(productList[i].isSelected == false) {
                                          setState(() {
                                            isSelectedAll = false;
                                          });

                                          break;
                                        }
                                      }
                                    }
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        productList[index].productData.imagePath[0] ?? '',
                                        fit: BoxFit.cover,
                                        width: 65.0,
                                        height: 65.0,
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              productList[index].productData.name,
                                              style: STextStyles.medium(),
                                            ),
                                            productList[index].productData.variant != null ?
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                Text(
                                                  productList[index].productData.variant![0],
                                                  style: XSTextStyles.regular(),
                                                ),
                                              ],
                                            ) :
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Rp ${NumberFormat('#,###', 'en_id').format(productList[index].productData.normalPrice[0]).replaceAll(',', '.')}',
                                                    style: STextStyles.regular().copyWith(
                                                      color: PrimaryColorStyles.primaryMain(),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: productList[index].qty == 1 ? NeutralColorStyles.neutral03() : BorderColorStyles.borderDivider(),
                                                    ),
                                                    borderRadius: BorderRadius.circular(5.0),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if(productList[index].qty > 1) {
                                                        setState(() {
                                                          productList[index].qty = productList[index].qty - 1;
                                                        });
                                                      }
                                                    },
                                                    customBorder: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: productList[index].qty == 1 ? NeutralColorStyles.neutral03() : IconColorStyles.iconColor(),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: SizedBox(
                                                    width: 20.0,
                                                    child: Text(
                                                      '${productList[index].qty}',
                                                      style: MTextStyles.regular(),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: BorderColorStyles.borderDivider(),
                                                    ),
                                                    borderRadius: BorderRadius.circular(5.0),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        productList[index].qty = productList[index].qty + 1;
                                                      });
                                                    },
                                                    customBorder: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: IconColorStyles.iconColor(),
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ) :
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Image.asset(
                          'assets/images/icon_trolley_empty.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Belum Ada Produk di Troli',
                        style: HeadingTextStyles.headingS(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          'Yuk eksplor semua produk yang ada di\nKenari, tambah ke Troli & Checkout\nProdukmu!',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  RefreshIndicator(
                    onRefresh: () async {

                    },
                    child: ListView(),
                  ),
                ],
              ),
            ),
            productList.isNotEmpty ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total Harga',
                          style: MTextStyles.regular(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Rp.1.225.000,-',
                          style: TextStyle(
                            color: PrimaryColorStyles.primaryMain(),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      child: Text(
                        'Checkout',
                        style: LTextStyles.medium().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Belanja Sekarang',
                    style: LTextStyles.medium().copyWith(
                      color: Colors.white,
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
}