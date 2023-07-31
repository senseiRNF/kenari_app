import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class SellerOrderDetailPage extends StatefulWidget {
  final Map orderData;

  const SellerOrderDetailPage({
    super.key,
    required this.orderData,
  });

  @override
  State<SellerOrderDetailPage> createState() => _SellerOrderDetailPageState();
}

class _SellerOrderDetailPageState extends State<SellerOrderDetailPage> {
  Map orderData = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      orderData = widget.orderData;
    });
  }

  Widget activeTopWidget() {
    if(orderData['status'] == 'Konfirmasi Pesanan') {
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
                      '${orderData['respond_limit']} Hari',
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
    } else if(orderData['status'] == 'Segera Siapkan Pesanan') {
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
    } else if(orderData['status'] == 'Siap diambil Pembeli') {
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
    } else if(orderData['status'] == 'Selesai') {
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
    if(orderData['status'] == 'Konfirmasi Pesanan') {
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
                    setState(() {
                      orderData['status'] = 'Segera Siapkan Pesanan';
                    });

                    OkDialog(
                      context: context,
                      message: 'Pesanan Berhasil di Terima',
                      showIcon: true,
                      hideButton: true,
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
                    setState(() {
                      orderData['status'] = 'Pesanan Dibatalkan';
                    });

                    OkDialog(
                      context: context,
                      message: 'Pesanan Berhasil di Batalkan',
                      showIcon: true,
                      hideButton: true,
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
    } else if(orderData['status'] == 'Segera Siapkan Pesanan') {
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
                    setState(() {
                      orderData['status'] = 'Siap diambil Pembeli';
                    });

                    OkDialog(
                      context: context,
                      message: 'Pesanan Siap diambil Pembeli',
                      showIcon: true,
                      hideButton: true,
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
                                orderData['order_no'],
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
                                DateFormat('dd-MM-yyyy HH:mm').format(orderData['order_date']),
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
                                DateFormat('dd-MM-yyyy HH:mm').format(orderData['payment_date']),
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
                            orderData['company']['name'],
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            orderData['company']['phone'],
                            style: STextStyles.medium(),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            orderData['company']['address'],
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      orderData['image'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      orderData['title'],
                                      style: MTextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      orderData['variant'],
                                      style: XSTextStyles.regular(),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price']).replaceAll(',', '.')}',
                                          style: MTextStyles.medium(),
                                        ),
                                        Text(
                                          'x${orderData['qty']}',
                                          style: MTextStyles.regular(),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                "${orderData['title']} ${orderData['variant']} (${orderData['qty']}x)",
                                style: MTextStyles.regular(),
                              ),
                              Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
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
                                'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
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