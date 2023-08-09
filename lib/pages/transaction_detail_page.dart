import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/transaction_order_detail_model.dart';
import 'package:kenari_app/services/api/transaction_services/api_transaction_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TransactionDetailPage extends StatefulWidget {
  final String? transactionId;

  const TransactionDetailPage({
    super.key,
    required this.transactionId,
  });

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  TransactionOrderDetailData? orderDetailData;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await APITransactionServices(context: context).callById(widget.transactionId).then((callResult) {
      if(callResult != null) {
        setState(() {
          orderDetailData = callResult.transactionOrderDetailData;
        });
      }
    });
  }

  Widget activeTopWidget() {
    if(orderDetailData != null && orderDetailData!.status != null) {
      if(orderDetailData!.status!.contains('waiting')) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Menunggu Konfirmasi Penjual',
                  style: STextStyles.medium().copyWith(
                    color: WarningColorStyles.warningMain(),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: WarningColorStyles.warningSurface(),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: WarningColorStyles.warningMain(),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          'Apabila Dalam  2 Hari Penjual tidak mengonfirmasi pesananmu, maka pesanan otomatis dibatalkan & uang kembali ke saldomu.',
                          style: XSTextStyles.medium().copyWith(
                            color: WarningColorStyles.warningMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if(orderDetailData!.status!.contains('on proccess')) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pesanan Disiapkan',
                  style: STextStyles.medium().copyWith(
                    color: InfoColorStyles.infoMain(),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if(orderDetailData!.status!.contains('ready to pickup')) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Siap diambil',
                  style: STextStyles.medium().copyWith(
                    color: InfoColorStyles.infoMain(),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
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
                      Expanded(
                        child: Text(
                          'Pesanan Siap di Ambil, segera ambil pesananmu.\n\nApabila Dalam 2 Hari anda tidak mengonfirmasi telah mengambil produk, maka pesanan otomatis Selesai.',
                          style: XSTextStyles.medium().copyWith(
                            color: InfoColorStyles.infoMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if(orderDetailData!.status!.contains('done')) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selesai',
                  style: STextStyles.medium().copyWith(
                    color: SuccessColorStyles.successMain(),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if(orderDetailData!.status!.contains('canceled')) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Pesanan Dibatalkan',
                  style: STextStyles.medium().copyWith(
                    color: DangerColorStyles.dangerMain(),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
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
                      Expanded(
                        child: Text(
                          orderDetailData!.status!.contains('seller') ? 'Penjual membatalkan pesanan.' : 'Anda membatalkan pesanan.',
                          style: XSTextStyles.medium().copyWith(
                            color: DangerColorStyles.dangerMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const Material();
      }
    } else {
      return const Material();
    }
  }

  Widget activeBottomWidget() {
    if(orderDetailData != null && orderDetailData!.status != null) {
      if(orderDetailData!.status == 'Konfirmasi Pesanan') {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  OptionDialog(
                    context: context,
                    title: 'Terima Pesanan?',
                    message: 'Setelah pesanan diterima, silahkan siapkan produk yang di pesan.',
                    yesText: 'Konfirmasi',
                    yesFunction: () {
                      SuccessDialog(
                        context: context,
                        message: 'Pesanan Berhasil di Terima',
                      ).show();
                    },
                    noText: 'Batal',
                  ).show();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColorStyles.primaryMain(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Terima Pesanan',
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
                    title: 'Batalkan Pesanan?',
                    message: 'Anda yakin untuk menolak Pesanan ini?',
                    yesText: 'Konfirmasi',
                    yesFunction: () {
                      SuccessDialog(
                        context: context,
                        message: 'Pesanan Berhasil di Batalkan',
                      ).show();
                    },
                    noText: 'Batal',
                  ).show();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColorStyles.primarySurface(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Batalkan Pesanan',
                    style: LTextStyles.medium().copyWith(
                      color: PrimaryColorStyles.primaryMain(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if(orderDetailData!.status == 'Segera Siapkan Pesanan') {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  OptionDialog(
                    context: context,
                    title: 'Siap diambil Pembeli',
                    message: 'Konfirmasi bahwa produk ini telah selesai disiapkan, dan produk siap di ambil oleh pembeli.',
                    yesText: 'Konfirmasi',
                    yesFunction: () {
                      SuccessDialog(
                        context: context,
                        message: 'Pesanan Siap diambil Pembeli',
                      ).show();
                    },
                    noText: 'Batal',
                  ).show();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColorStyles.primaryMain(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Pesanan Siap',
                    style: LTextStyles.medium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return const Material();
      }
    } else {
      return const Material();
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
                            'Detail Pesanan',
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
                  activeTopWidget(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  orderDetailData != null ?
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Nomor Pesanan',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                orderDetailData!.transactionNo ?? '(Tidak diketahui)',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Waktu Pemesanan',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                orderDetailData!.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderDetailData!.transactionDate!)) : '(Tidak diketahui) Date',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Waktu Pembayaran',
                                style: STextStyles.regular(),
                              ),
                              Text(
                                orderDetailData!.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderDetailData!.transactionDate!)) : '(Tidak diketahui) Date',
                                style: STextStyles.medium(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) : 
                  const Material(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  orderDetailData != null ?
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Alamat Pengambilan',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            orderDetailData!.address != null ? orderDetailData!.address!.address ?? '(Nama perusahaan tidak terdaftar)' : '(Nama perusahaan tidak terdaftar)',
                            style: STextStyles.medium(),
                          ),
                        ],
                      ),
                    ),
                  ) :
                  const Material(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  orderDetailData != null ?
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Detail Produk',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          orderDetailData!.orderDetails != null ?
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderDetailData!.orderDetails!.length,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemBuilder: (BuildContext orderDetailContext, int orderDetailIndex) {
                              return orderDetailData!.orderDetails![orderDetailIndex].product != null ?
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$baseURL/${orderDetailData!.orderDetails![orderDetailIndex].product!.images != null && orderDetailData!.orderDetails![orderDetailIndex].product!.images!.isNotEmpty ? orderDetailData!.orderDetails![orderDetailIndex].product!.images![0].url ?? '' : ''}",
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
                                    width: 15.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          orderDetailData!.orderDetails![orderDetailIndex].product!.name ?? '(Produk tidak diketahui)',
                                          style: MTextStyles.regular(),
                                        ),
                                        orderDetailData!.orderDetails![orderDetailIndex].varianName != null ?
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              orderDetailData!.orderDetails![orderDetailIndex].varianName!,
                                              style: XSTextStyles.regular(),
                                            ),
                                          ],
                                        ) :
                                        const Material(),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(orderDetailData!.orderDetails![orderDetailIndex].price ?? '0')).replaceAll(',', '.')}',
                                              style: MTextStyles.medium(),
                                            ),
                                            Text(
                                              'x${orderDetailData!.orderDetails![orderDetailIndex].qty ?? '0'}',
                                              style: MTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :
                              const Material();
                            },
                          ) :
                          const Material(),
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
                            'Metode Pembayaran',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: Image.asset(
                                  'assets/images/dipay_logo_only.png',
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Dipay',
                                  style: MTextStyles.medium(),
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
                  orderDetailData != null ?
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Rincian Pembayaran',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Harga (${orderDetailData!.orderDetails != null ? orderDetailData!.orderDetails!.length : '0'} Barang)",
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(orderDetailData!.totalAmount ?? '0')).replaceAll(',', '.')}',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Divider(
                              height: 1.0,
                              thickness: 1.0,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Total Penjualan",
                          //       style: STextStyles.regular(),
                          //     ),
                          //     Text(
                          //       'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
                          //       '',
                          //       style: STextStyles.medium().copyWith(
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ) :
                  const Material(),
                ],
              ),
            ),
            activeBottomWidget(),
          ],
        ),
      ),
    );
  }
}