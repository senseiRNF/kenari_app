import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/seller_order_detail_model.dart';
import 'package:kenari_app/services/api/seller_order_services/api_seller_order_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerOrderDetailPage extends StatefulWidget {
  final String? sellerOrderId;

  const SellerOrderDetailPage({
    super.key,
    required this.sellerOrderId,
  });

  @override
  State<SellerOrderDetailPage> createState() => _SellerOrderDetailPageState();
}

class _SellerOrderDetailPageState extends State<SellerOrderDetailPage> {
  SellerOrderDetailData? orderDetailData;

  @override
  void initState() {
    super.initState();

    loadData();
  }
  
  Future loadData() async {
    await APISellerOrderServices(context: context).callById(widget.sellerOrderId).then((callResult) {
      if(callResult != null) {
        setState(() {
          orderDetailData = callResult.sellerOrderDetailData;
        });
      }
    });
  }
  
  Future confirmOrder() async {
    await APISellerOrderServices(context: context).confirmOrder(widget.sellerOrderId).then((confirmResult) {
      if(confirmResult == true) {
        SuccessDialog(
          context: context,
          message: 'Pesanan Berhasil di Terima',
          okFunction: () {
            BackFromThisPage(context: context).go();
          },
        ).show();
      }
    });
  }

  Future processOrder() async {
    await APISellerOrderServices(context: context).proccessOrder(widget.sellerOrderId).then((confirmResult) {
      if(confirmResult == true) {
        SuccessDialog(
          context: context,
          message: 'Pesanan Siap diambil Pembeli',
          okFunction: () {
            BackFromThisPage(context: context).go();
          },
        ).show();
      }
    });
  }

  Future cancelOrder() async {
    await APISellerOrderServices(context: context).cancelOrderBySeller(widget.sellerOrderId).then((confirmResult) {
      if(confirmResult == true) {
        SuccessDialog(
          context: context,
          message: 'Pesanan Berhasil di Batalkan',
          okFunction: () {
            BackFromThisPage(context: context).go();
          },
        ).show();
      }
    });
  }

  Widget activeTopWidget() {
    if(orderDetailData != null) {
      if(orderDetailData!.status == 'waiting') {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Konfirmasi Pesanan',
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
                          'Konfirmasi pesanan paling lama 2 Hari, atau pesanan akan otomatis dibatalkan oleh sistem.',
                          style: XSTextStyles.medium().copyWith(
                            color: WarningColorStyles.warningMain(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: InfoColorStyles.infoSurface(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Batas Respon',
                        style: STextStyles.regular(),
                      ),
                      Text(
                        '1 Hari',
                        style: STextStyles.medium().copyWith(
                          color: InfoColorStyles.infoMain(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if(orderDetailData!.status == 'on proccess') {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Segera Siapkan Pesanan',
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
                          'Segera siapkan produk paling lama 2 Hari, atau pesanan akan otomatis dibatalkan oleh sistem.',
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
      } else if(orderDetailData!.status == 'ready to pickup') {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Siap diambil Pembeli',
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
                          'Apabila dalam 2 hari pembeli tidak mengonfirmasi telah mengambil pesanan, maka pesanan otomatis Selesai.',
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
      } else if(orderDetailData!.status == 'done') {
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
    } else {
      return const Material();
    }
  }

  Widget activeBottomWidget() {
    if(orderDetailData != null) {
      if(orderDetailData!.status == 'waiting') {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => OptionDialog(
                  context: context,
                  title: 'Terima Pesanan?',
                  message: 'Setelah pesanan diterima, silahkan siapkan produk yang di pesan.',
                  yesText: 'Konfirmasi',
                  yesFunction: () => confirmOrder(),
                  noText: 'Batal',
                ).show(),
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
                onPressed: () => OptionDialog(
                  context: context,
                  title: 'Batalkan Pesanan?',
                  message: 'Anda yakin untuk menolak Pesanan ini?',
                  yesText: 'Konfirmasi',
                  yesFunction: () => cancelOrder(),
                  noText: 'Batal',
                ).show(),
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
      } else if(orderDetailData!.status == 'on proccess') {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => OptionDialog(
                  context: context,
                  title: 'Siap diambil Pembeli',
                  message: 'Konfirmasi bahwa produk ini telah selesai disiapkan, dan produk siap di ambil oleh pembeli.',
                  yesText: 'Konfirmasi',
                  yesFunction: () => processOrder(),
                  noText: 'Batal',
                ).show(),
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
            orderDetailData != null ?
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
                                orderDetailData!.transactionNo ?? '(Nomor tidak diketahui)',
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
                                orderDetailData!.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderDetailData!.transactionDate!)) : '(Tanggal tidak diketahui)',
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
                                orderDetailData!.transactionDate != null ? DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(orderDetailData!.transactionDate!)) : '(Tanggal tidak diketahui)',
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
                            'Company Name',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Company Phone',
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Company Address',
                            style: STextStyles.regular(),
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
                          orderDetailData!.orderDetails != null ?
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderDetailData!.orderDetails!.length,
                            itemBuilder: (BuildContext orderListContext, int orderListIndex) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$baseURL/${orderDetailData!.orderDetails![orderListIndex].product != null && orderDetailData!.orderDetails![orderListIndex].product!.images != null && orderDetailData!.orderDetails![orderListIndex].product!.images!.isNotEmpty ? orderDetailData!.orderDetails![orderListIndex].product!.images![0].url ?? '' : ''}",
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
                                          orderDetailData!.orderDetails![orderListIndex].product != null ? orderDetailData!.orderDetails![orderListIndex].product!.name ?? '(Produk tidak diketahui)' : '(Produk tidak diketahui)',
                                          style: MTextStyles.regular(),
                                        ),
                                        orderDetailData!.orderDetails![orderListIndex].varianName != null ?
                                        Column (
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              orderDetailData!.orderDetails![orderListIndex].varianName ?? '(Varian tidak diketahui)',
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
                                              'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(orderDetailData!.orderDetails![orderListIndex].price ?? '0')).replaceAll(',', '.')}',
                                              style: MTextStyles.medium(),
                                            ),
                                            Text(
                                              'x${orderDetailData!.orderDetails![orderListIndex].qty ?? '0'}',
                                              style: MTextStyles.regular(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
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
                          orderDetailData!.orderDetails != null ?
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderDetailData!.orderDetails!.length,
                            separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Material(),
                              );
                            },
                            itemBuilder: (BuildContext orderDetailContext, int orderIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${orderDetailData!.orderDetails![orderIndex].product != null ? orderDetailData!.orderDetails![orderIndex].product!.name ?? '(Produk tidak diketahui)' : '(Produk tidak diketahui)'}${
                                        orderDetailData!.orderDetails![orderIndex].varianName != null ? ' - ${orderDetailData!.orderDetails![orderIndex].varianName}' : ''} (${
                                        orderDetailData!.orderDetails![orderIndex].qty}x)",
                                    style: MTextStyles.regular(),
                                  ),
                                  Text(
                                    'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(orderDetailData!.orderDetails![orderIndex].total ?? '0')).replaceAll(',', '.')}',
                                    style: STextStyles.medium().copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ) :
                          const Material(),
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
                                'Rp ${NumberFormat('#,###', 'en_id').format(int.parse(orderDetailData!.totalAmount ?? '0')).replaceAll(',', '.')}',
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
            ) :
            Expanded(
              child:
              ListView(),
            ),
            orderDetailData != null ?
            activeBottomWidget() :
            const Material(),
          ],
        ),
      ),
    );
  }
}