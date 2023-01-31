import 'package:flutter/material.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool showErrorHint = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Kenari',
                    style: HeadingTextStyles.headingS().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Solusi digitalisasi perusahaan Indonesia',
                    style: MTextStyles.regular(),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Email',
                    style: STextStyles.medium().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
                      hintStyle: MTextStyles.regular(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Password',
                    style: STextStyles.medium().copyWith(
                      color: showErrorHint ? DangerColorStyles.dangerMain() : STextStyles.medium().color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password',
                      hintStyle: MTextStyles.regular(),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      errorText: showErrorHint ? 'Email atau password salah' : null,
                    ),
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa password?',
                          style: MTextStyles.medium(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(passwordController.text != 'password') {
                        setState(() {
                          showErrorHint = true;
                        });
                      } else {
                        if(showErrorHint = true) {
                          setState(() {
                            showErrorHint = false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: emailController.text != '' && passwordController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      child: Text(
                        'Masuk',
                        style: LTextStyles.regular().copyWith(
                          color: emailController.text != '' && passwordController.text != '' ? LTextStyles.regular().color : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55.0,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Belum memiliki akun?',
                      style: STextStyles.medium().copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColorStyles.primarySurface(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      child: Text(
                        'Daftar',
                        style: LTextStyles.regular().copyWith(
                          color: PrimaryColorStyles.primaryMain(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}