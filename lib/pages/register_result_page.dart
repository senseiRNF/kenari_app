import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class RegisterResultPage extends StatefulWidget {
  final String email;

  const RegisterResultPage({
    super.key,
    required this.email,
  });

  @override
  State<RegisterResultPage> createState() => _RegisterResultPageState();
}

class _RegisterResultPageState extends State<RegisterResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/banner_success_register.png',
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Terima kasih telah mendaftar!',
                      style: HeadingTextStyles.headingS(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Kami akan memverifikasi akun Anda, Silahkan hubungi pihak kantor Anda jika akun anda belum terverifikasi',
                      style: MTextStyles.regular(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.email,
                          style: MTextStyles.medium(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () => BackFromThisPage(context: context).go(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColorStyles.primaryMain(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Mengerti',
                    style: LTextStyles.medium().copyWith(
                      color: Colors.white,
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