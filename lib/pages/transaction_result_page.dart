import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class TransactionResultPage extends StatelessWidget {
  final bool isSuccess;

  const TransactionResultPage({
    super.key,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> onBackPressed() async {
      if(isSuccess == true) {
        BackFromThisPage(
          context: context,
          callbackData: {
            'target': 'home',
          },
        ).go();
      } else {
        BackFromThisPage(context: context).go();
      }

      return Future.value(false);
    }

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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Terimakasih! pesanan anda sedang menunggu konfirmasi, tunggu hingga pesanan anda diterima penjual. silahkan lihat status pesanan atau kembali lanjut berbelanja.',
                            style: MTextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Mohon maaf pembayaran anda mengalami kendala, Silahkan lakukan pembayaran ulang.',
                            style: MTextStyles.regular(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
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
                          if(isSuccess == true) {
                            BackFromThisPage(
                              context: context,
                              callbackData: {
                                'target': 'transaction',
                                'index': 2,
                              },
                            ).go();
                          } else {
                            BackFromThisPage(context: context).go();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primaryMain(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            isSuccess == true ? 'Cek Pesanan' : 'Coba Lagi',
                            style: LTextStyles.medium().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => BackFromThisPage(
                          context: context,
                          callbackData: {
                            'target': 'home',
                          },
                        ).go(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primarySurface(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Kembali ke Beranda',
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