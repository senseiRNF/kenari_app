import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class FeePaymentResultPage extends StatefulWidget {
  final String transactionName;
  final String? transactionNumber;
  final String? feeAmount;
  final DateTime date;

  const FeePaymentResultPage({
    super.key,
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

  List<bool> randomSuccess = [
    true,
    false,
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      isSuccess = (randomSuccess.toList()..shuffle()).first;
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
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Terima Kasih,',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pembayaranmu untuk ',
                              style: MTextStyles.regular(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.transactionName,
                              style: MTextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              ' telah',
                              style: MTextStyles.regular(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Text(
                          'selesai.',
                          style: MTextStyles.regular(),
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
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Mohon maaf pembayaran anda mengalami kendala, Silahkan lakukan pembayaran ulang.',
                          style: MTextStyles.regular(),
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
                      style: MTextStyles.regular(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.feeAmount ?? 'Rp 0',
                      style: MTextStyles.regular(),
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
                            style: STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.transactionNumber ?? '',
                            style: STextStyles.medium().copyWith(
                              fontWeight: FontWeight.bold,
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
                            style: STextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd MMMM yyyy').format(widget.date),
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
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
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
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
                            style: LTextStyles.medium().copyWith(
                              color: LTextStyles.regular().color,
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
      ),
    );
  }
}