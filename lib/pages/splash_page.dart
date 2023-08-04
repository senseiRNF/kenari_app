import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/home_page.dart';
import 'package:kenari_app/pages/login_page.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2), () => checkAuth(),
    );
  }

  Future checkAuth() async {
    await LocalSharedPrefs().readKey('token').then((tokenResult) {
      if(tokenResult != null) {
        ReplaceToPage(context: context, target: const HomePage()).go();
      } else {
        ReplaceToPage(context: context, target: const LoginPage()).go();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100.0,
              child: Image.asset(
                'assets/images/main_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 20.0,
              child: Image.asset(
                'assets/images/text_main_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}