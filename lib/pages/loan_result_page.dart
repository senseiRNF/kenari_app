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
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Selamat, Pengajuan Pendanaan anda telah Berhasil!',
                          style: Theme.of(context).textTheme.bodyMedium!,
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
                            'Lihat Status Pendanaan',
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