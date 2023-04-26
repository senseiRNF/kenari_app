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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: WarningColorStyles.warningMain(),
                  fontWeight: FontBodyWeight.medium(),
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
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: WarningColorStyles.warningMain(),
                          fontWeight: FontBodyWeight.medium(),
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
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    Text(
                      '${orderData['respond_limit']} Hari',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: InfoColorStyles.infoMain(),
                        fontWeight: FontBodyWeight.medium(),
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: WarningColorStyles.warningMain(),
                  fontWeight: FontBodyWeight.medium(),
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
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: WarningColorStyles.warningMain(),
                          fontWeight: FontBodyWeight.medium(),
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: InfoColorStyles.infoMain(),
                  fontWeight: FontBodyWeight.medium(),
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
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: InfoColorStyles.infoMain(),
                          fontWeight: FontBodyWeight.medium(),
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: SuccessColorStyles.successMain(),
                  fontWeight: FontBodyWeight.medium(),
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: DangerColorStyles.dangerMain(),
                  fontWeight: FontBodyWeight.medium(),
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
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: DangerColorStyles.dangerMain(),
                          fontWeight: FontBodyWeight.medium(),
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontBodyWeight.medium(),
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: PrimaryColorStyles.primaryMain(),
                    fontWeight: FontBodyWeight.medium(),
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontBodyWeight.medium(),
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
                            style: Theme.of(context).textTheme.headlineSmall,
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
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              Text(
                                orderData['order_no'],
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
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
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy HH:mm').format(orderData['order_date']),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
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
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy HH:mm').format(orderData['payment_date']),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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
                            'Alamat Pengambilan',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            orderData['company']['name'],
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            orderData['company']['phone'],
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            orderData['company']['address'],
                            style: Theme.of(context).textTheme.bodySmall!,
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
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
                                      style: Theme.of(context).textTheme.bodyMedium!,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      orderData['variant'],
                                      style: Theme.of(context).textTheme.labelSmall!,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price']).replaceAll(',', '.')}',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontBodyWeight.medium(),
                                          ),
                                        ),
                                        Text(
                                          'x${orderData['qty']}',
                                          style: Theme.of(context).textTheme.bodyMedium!,
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
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
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontBodyWeight.medium(),
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
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Rincian Pembayaran',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${orderData['title']} ${orderData['variant']} (${orderData['qty']}x)",
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                              Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              Text(
                                'Rp ${NumberFormat('#,###', 'en_id').format(orderData['price'] * orderData['qty']).replaceAll(',', '.')}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
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