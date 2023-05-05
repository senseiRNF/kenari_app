import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/transaction_result_page.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/transaction_services/api_transaction_services.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class CheckoutPage extends StatefulWidget {
  final List<LocalTrolleyProduct> selectedProductList;

  const CheckoutPage({
    super.key,
    required this.selectedProductList,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<LocalTrolleyProduct> trolleyData = [];
  List<TextEditingController> optionalRequestControllerList = [];

  int total = 0;

  bool isDipayActivated = false;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    List<LocalTrolleyProduct> tempLocalTrolleyData = [];
    List<TextEditingController> tempOptionalRequestControllerList = [];
    int tempTotal = 0;

    for(int i = 0; i < widget.selectedProductList.length; i++) {
      if(widget.selectedProductList[i].isSelected == true) {
        tempLocalTrolleyData.add(
          LocalTrolleyProduct(
            isSelected: true,
            trolleyData: widget.selectedProductList[i].trolleyData,
            qty: widget.selectedProductList[i].qty,
          ),
        );
      }

      tempOptionalRequestControllerList.add(TextEditingController());

      tempTotal = tempTotal + (int.parse(widget.selectedProductList[i].trolleyData.price ?? '0') * widget.selectedProductList[i].qty);
    }

    setState(() {
      optionalRequestControllerList = tempOptionalRequestControllerList;
      trolleyData = tempLocalTrolleyData;
      total = tempTotal;
    });
  }

  int countTotal() {
    int result = 0;

    if(trolleyData.isNotEmpty) {
      for(int i = 0; i < trolleyData.length; i++) {
        result = result + (int.parse(trolleyData[i].trolleyData.price ?? '0') * trolleyData[i].qty);
      }
    }

    return result;
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
                            'Checkout',
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
              child: trolleyData.isNotEmpty ?
              RefreshIndicator(
                onRefresh: () async {
                  loadData();
                },
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
                              'Alamat Pengambilan',
                              style: MTextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'PT. Surya Fajar Capital.tbk (08123456789)',
                              style: STextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Satrio Tower Building Lt. 14 Unit 6, Jalan Prof. Dr. Satrio Blok C4/5, Kuningan, DKI Jakarta 12950, Indonesia',
                              style: STextStyles.regular().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Detail Belanja',
                              style: MTextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: BorderColorStyles.borderDivider(),
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: trolleyData.length,
                              itemBuilder: (BuildContext listContext, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: "$baseURL/${trolleyData[index].trolleyData.product != null && trolleyData[index].trolleyData.product!.images != null && trolleyData[index].trolleyData.product!.images![0].url != null ? trolleyData[index].trolleyData.product!.images![0].url! : ''}",
                                            imageBuilder: (context, imgProvider) {
                                              return Container(
                                                width: 65.0,
                                                height: 65.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  image: DecorationImage(
                                                    image: imgProvider,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return SizedBox(
                                                width: 65.0,
                                                height: 65.0,
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
                                            width: 15.0,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  trolleyData[index].trolleyData.product != null && trolleyData[index].trolleyData.product!.name != null ? trolleyData[index].trolleyData.product!.name! : 'Unknown Product',
                                                  style: MTextStyles.medium(),
                                                ),
                                                trolleyData[index].trolleyData.varian != null ?
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      trolleyData[index].trolleyData.varian!.name1 ?? 'Unknown Variant',
                                                      style: STextStyles.regular(),
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                  ],
                                                ) :
                                                const SizedBox(
                                                  height: 25.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(trolleyData[index].trolleyData.price ?? '0')).replaceAll(',', '.')}',
                                                      style: MTextStyles.medium().copyWith(
                                                        color: PrimaryColorStyles.primaryMain(),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${trolleyData[index].qty}x',
                                                      style: MTextStyles.regular(),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: NeutralColorStyles.neutral02(),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: TextField(
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: 'Tambah catatan disini (optional)',
                                              hintStyle: STextStyles.regular(),
                                            ),
                                            controller: optionalRequestControllerList[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: MTextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: BorderColorStyles.borderDivider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30.0,
                                    child: Image.asset(
                                      'assets/images/saldo_dipay_logo.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  isDipayActivated ?
                                  Text(
                                    'Rp ${NumberFormat('#,###', 'en_id').format(5000000).replaceAll(',', '.')}',
                                  ) :
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isDipayActivated = !isDipayActivated;
                                      });
                                    },
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'Aktivasi',
                                        style: MTextStyles.medium().copyWith(
                                          color: PrimaryColorStyles.primaryMain(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: isDipayActivated ?
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: InfoColorStyles.infoSurface(),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: InfoColorStyles.infoMain(),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Pastikan Saldo Dipay anda mencukupi.',
                                      style: XSTextStyles.medium().copyWith(
                                        color: InfoColorStyles.infoMain(),
                                      ),
                                    ),
                                  ],
                                ),
                              ) :
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: DangerColorStyles.dangerSurface(),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      color: DangerColorStyles.dangerMain(),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'Lakukan aktivasi pada akun Dipay anda.',
                                      style: XSTextStyles.medium().copyWith(
                                        color: DangerColorStyles.dangerMain(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Ringkasan Belanja',
                              style: MTextStyles.medium().copyWith(
                                color: TextColorStyles.textPrimary(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: BorderColorStyles.borderDivider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Harga (${trolleyData.length} Produk)',
                                  style: MTextStyles.regular(),
                                ),
                                Text(
                                  'Rp ${NumberFormat('#,###', 'en_id').format(countTotal()).replaceAll(',', '.')},-',
                                  style: MTextStyles.medium().copyWith(
                                    color: TextColorStyles.textPrimary(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
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
            Container(
              color: Colors.white,
              child: Padding(
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
                            'Rp ${NumberFormat('#,###', 'en_id').format(countTotal()).replaceAll(',', '.')},-',
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
                      onPressed: () async {
                        if(trolleyData.isNotEmpty) {
                          if(isDipayActivated == true) {
                            await APITransactionServices(context: context).update(trolleyData).then((updateResult) {
                              MoveToPage(
                                context: context,
                                target: TransactionResultPage(isSuccess: updateResult),
                                callback: (callbackResult) {
                                  if(callbackResult != null) {
                                    BackFromThisPage(context: context, callbackData: callbackResult).go();
                                  }
                                },
                              ).go();
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Text(
                          'Bayar',
                          style: LTextStyles.medium().copyWith(
                            color: Colors.white,
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