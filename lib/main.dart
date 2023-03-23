import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kenari_app/pages/splash_page.dart';
import 'package:kenari_app/styles/color_styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        primarySwatch: const MaterialColor(
          0xffff5f0a,
          <int, Color> {
            50: Color(0xffe65609),
            100: Color(0xffcc4c08),
            200: Color(0xffb34307),
            300: Color(0xff993906),
            400: Color(0xff803005),
            500: Color(0xff662604),
            600: Color(0xff4c1c03),
            700: Color(0xff331302),
            800: Color(0xff190901),
            900: Color(0xff000000),
          },
        ),
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
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontFamily: 'Raleway',
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
      },
    );
  }
}
