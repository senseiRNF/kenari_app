import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoanResultPage extends StatefulWidget {
  const LoanResultPage({super.key});

  @override
  State<LoanResultPage> createState() => _LoanResultPageState();
}

class _LoanResultPageState extends State<LoanResultPage> {

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
                          'Peminjaman Berhasil!',
                          style: HeadingTextStyles.headingS(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Selamat, Pengajuan pinjaman anda telah Berhasil!',
                          style: MTextStyles.regular(),
                          textAlign: TextAlign.center,
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
                        onPressed: () => BackFromThisPage(
                          context: context,
                          callbackData: {
                            'target': 'home',
                          },
                        ).go(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primaryMain(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Kembali ke Beranda',
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
                            'target': 'transaction',
                            'index': 1,
                          },
                        ).go(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColorStyles.primarySurface(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Lihat Status Pinjaman',
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