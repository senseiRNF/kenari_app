import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/local/models/local_notification_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class NotificationTransactionDetailPage extends StatefulWidget {
  final LocalNotificationData notificationData;

  const NotificationTransactionDetailPage({
    super.key,
    required this.notificationData,
  });

  @override
  State<NotificationTransactionDetailPage> createState() => _NotificationTransactionDetailPageState();
}

class _NotificationTransactionDetailPageState extends State<NotificationTransactionDetailPage> {
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
                      'Detail Transaksi',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: NeutralColorStyles.neutral05(),
            ),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Rincian Transaksi',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Text(
                          widget.notificationData.title,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Transaksi Sukses',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.green,
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.notificationData.title.contains('Iuran Wajib') ? 'Autodebet' : widget.notificationData.title.contains('Penjualan') || widget.notificationData.title.contains('Pinjaman') && widget.notificationData.total != null && widget.notificationData.total! > 0 ? 'Metode Pencairan' : 'Metode Pembayaran',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/dipay_logo_only.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '08123456789',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No. Referensi',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Text(
                          'PAY000000242',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu dan Tanggal',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Text(
                          DateFormat('dd MMMM yyyy,\nHH:mm').format(widget.notificationData.date),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(
                      height: 1.0,
                      color: BorderColorStyles.borderDivider(),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jumlah',
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Text(
                          "Rp ${NumberFormat('#,###', 'en_id').format(widget.notificationData.total!.abs()).replaceAll(',', '.')}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                          textAlign: TextAlign.end,
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
  }
}