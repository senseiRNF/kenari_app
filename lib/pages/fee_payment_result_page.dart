import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class FeePaymentResultPage extends StatefulWidget {
  final bool status;
  final String transactionName;
  final String? transactionNumber;
  final String? feeAmount;
  final DateTime date;

  const FeePaymentResultPage({
    super.key,
    required this.status,
    required this.transactionName,
    required this.transactionNumber,
    required this.feeAmount,
    required this.date,
  });

  @override
  State<FeePaymentResultPage> createState() => _FeePaymentResultPageState();
}

class _FeePaymentResultPageState extends State<FeePaymentResultPage> {
  late bool isSuccess;

  @override
  void initState() {
    super.initState();

    setState(() {
      isSuccess = widget.status;
    });
  }

  Future<bool> onBackPressed() async {
    BackFromThisPage(context: context, callbackData: true).go();

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    isSuccess ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: SuccessColorStyles.successMain(),
                          size: 80.0,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Pembayaran Berhasil',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Terima Kasih,',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pembayaranmu untuk ',
                              style: Theme.of(context).textTheme.bodyMedium!,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.transactionName,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontBodyWeight.medium(),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              ' telah',
                              style: Theme.of(context).textTheme.bodyMedium!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Text(
                          'selesai.',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ) :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            color: DangerColorStyles.dangerMain(),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 80.0,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Pembayaran Gagal',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Mohon maaf pembayaran anda mengalami kendala, Silahkan lakukan pembayaran ulang.',
                          style: Theme.of(context).textTheme.bodyMedium!,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 2.0,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Jumlah Pembayaran',
                      style: Theme.of(context).textTheme.bodyMedium!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.feeAmount ?? 'Rp 0',
                      style: Theme.of(context).textTheme.bodyMedium!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 2.0,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No. Referensi',
                            style: Theme.of(context).textTheme.bodySmall!,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.transactionNumber ?? '',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontBodyWeight.medium(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Waktu dan Tanggal',
                            style: Theme.of(context).textTheme.bodySmall!,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd MMMM yyyy').format(widget.date),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                width: 5.0,
                                height: 5.0,
                                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                DateFormat('HH:mm').format(widget.date),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontBodyWeight.medium(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
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
                          BackFromThisPage(context: context, callbackData: true).go();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primaryMain(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Kembali ke Beranda',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontWeight: FontBodyWeight.medium(),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BackFromThisPage(context: context, callbackData: false).go();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primarySurface(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Lihat Riwayat Transaksi',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: PrimaryColorStyles.primaryMain(),
                              fontWeight: FontBodyWeight.medium(),
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
      ),
    );
  }
}