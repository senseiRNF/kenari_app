import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

import 'package:kenari_app/services/firebase/firebase_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((_) async {
    await FirebaseAPI().initNotifications();
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const KenariApp());
  });
}

class KenariApp extends StatelessWidget {
  const KenariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kenari App',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: PrimaryColorStyles.primaryMain(),
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: PrimaryColorStyles.primaryMain(),
          error: DangerColorStyles.dangerMain(),
          onError: Colors.white,
          background: BackgroundColorStyles.pageBackground(),
          onBackground: Colors.black54,
          surface: PrimaryColorStyles.primarySurface(),
          onSurface: Colors.black54,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: MTextStyles.regular().copyWith(
            color: TextColorStyles.textDisabled(),
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}