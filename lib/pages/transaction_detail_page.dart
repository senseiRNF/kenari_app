import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/models/transaction_order_model.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TransactionDetailPage extends StatefulWidget {
  final TransactionOrderData data;

  const TransactionDetailPage({
    super.key,
    required this.data,
  });

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  late TransactionOrderData orderData;

  @override
  void initState() {
    super.initState();

    setState(() {
      orderData = widget.data;
    });
  }

  Widget activeTopWidget() {
    if(orderData.status != null && orderData.status == 'waiting') {
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
    } else if(orderData.status != null && orderData.status == 'Segera Siapkan Pesanan') {
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
    } else if(orderData.status != null && orderData.status == 'ready') {
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
    } else if(orderData.status != null && orderData.status == 'complete') {
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
    } else {
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
                        'Anda membatalkan pesanan.',
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
    }
  }

  Widget activeBottomWidget() {
    if(orderData.status != null && orderData.status == 'Konfirmasi Pesanan') {
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
                    OkDialog(
                      context: context,
                      message: 'Pesanan Berhasil di Terima',
                      showIcon: true,
                      hideButton: true,
                    ).show();
                  },
                  noText: 'Batal',
                  noFunction: () {},
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
                    OkDialog(
                      context: context,
                      message: 'Pesanan Berhasil di Batalkan',
                      showIcon: true,
                      hideButton: true,
                    ).show();
                  },
                  noText: 'Batal',
                  noFunction: () {},
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
    } else if(orderData.status != null && orderData.status == 'Segera Siapkan Pesanan') {
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
                    OkDialog(
                      context: context,
                      message: 'Pesanan Siap diambil Pembeli',
                      showIcon: true,
                      hideButton: true,
                    ).show();
                  },
                  noText: 'Batal',
                  noFunction: () {},
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
                                orderData.transactionNo ?? 'Unknown',
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
                                orderData.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderData.transactionDate!)) : 'Unknown Date',
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
                                orderData.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderData.transactionDate!)) : 'Unknown Date',
                                style: STextStyles.medium(),
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
                            orderData.address != null ? orderData.address!.address ?? 'Unknown Company' : 'Unknown Company',
                            style: STextStyles.medium(),
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
                            'Detail Produk',
                            style: MTextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          orderData.orderDetails != null ?
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderData.orderDetails!.length,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemBuilder: (BuildContext orderDetailContext, int orderDetailIndex) {
                              // return Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       width: 65.0,
                              //       height: 65.0,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(5.0),
                              //         image: DecorationImage(
                              //           image: AssetImage(
                              //             orderData['image'],
                              //           ),
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Expanded(
                              //       child: Column(
                              //         crossAxisAlignment: CrossAxisAlignment.stretch,
                              //         children: [
                              //           Text(
                              //             orderData['title'],
                              //             style: MTextStyles.regular(),
                              //           ),
                              //           const SizedBox(
                              //             height: 5.0,
                              //           ),
                              //           Text(
                              //             orderData['variant'],
                              //             style: XSTextStyles.regular(),
                              //           ),
                              //           const SizedBox(
                              //             height: 10.0,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Text(
                              //                 'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price']).replaceAll(',', '.')}',
                              //                 style: MTextStyles.medium(),
                              //               ),
                              //               Text(
                              //                 'x${orderData['qty']}',
                              //                 style: MTextStyles.regular(),
                              //               ),
                              //             ],
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // );

                              return const Material();
                            },
                          ) :
                          const Material(),
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
                                // "${orderData['title']} ${orderData['variant']} (${orderData['qty']}x)",
                                '',
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                // 'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
                                '',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Penjualan",
                                style: STextStyles.regular(),
                              ),
                              Text(
                                // 'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
                                '',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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