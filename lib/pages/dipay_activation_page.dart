import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class DipayActivationPage extends StatelessWidget {
  const DipayActivationPage({super.key});

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
                            'Aktivasi Dipay',
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/dipay_logo_square.png',
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Aktivasi Dipay Sekarang',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Aktifkan Dipay di akun Kenari Anda untuk kemudahan pembayaran tanpa tunai',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        const SizedBox(
                          height: 65.0,
                        ),
                        Text(
                          'Untuk menghubungkan akun Dipay dengan Kenari, pastikan bahwa:',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                'Anda telah memiliki aplikasi dan akun Dipay',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 5.0,
                              height: 5.0,
                              margin: const EdgeInsets.only(top: 8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                'Nomor HP Akun Dipay Anda sama dengan Nomor HP Akun Kenari',
                                style: Theme.of(context).textTheme.bodyMedium!,
                              ),
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
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColorStyles.primaryMain(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Lanjutkan',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontBodyWeight.medium(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}