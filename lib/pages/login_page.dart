import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/forget_password_page.dart';
import 'package:kenari_app/pages/home_page.dart';
import 'package:kenari_app/pages/register_company_code_page.dart';
import 'package:kenari_app/services/api/authorization_services/api_login_services.dart';
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

  late String errorHintMessage;

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
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Solusi digitalisasi perusahaan Indonesia',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: TextColorStyles.textSecondary(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontBodyWeight.medium(),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Email',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: TextColorStyles.textDisabled(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) {
                      if(showErrorHint = true) {
                        setState(() {
                          showErrorHint = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: showErrorHint ? DangerColorStyles.dangerMain() : Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontBodyWeight.medium(),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: TextColorStyles.textDisabled(),
                      ),
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
                      errorText: showErrorHint ? errorHintMessage : null,
                    ),
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      if(showErrorHint = true) {
                        setState(() {
                          showErrorHint = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          MoveToPage(context: context, target: const ForgetPasswordPage()).go();
                        },
                        child: Text(
                          'Lupa password?',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: PrimaryColorStyles.primaryMain(),
                            fontWeight: FontBodyWeight.medium(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(emailController.text != '' && passwordController.text != '') {
                        if(showErrorHint = true) {
                          setState(() {
                            showErrorHint = false;
                          });
                        }

                        APILoginServices(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                          rememberMe: false,
                        ).login().then((callResult) {
                          if(callResult.apiResult == true) {
                            ReplaceToPage(context: context, target: const HomePage()).go();
                          } else {
                            if(callResult.dioError != null && callResult.dioError!.response != null && callResult.dioError!.response!.statusCode == 412) {
                              if(callResult.dioError!.response!.data['data']['errors']['email'] != null || callResult.dioError!.response!.data['data']['errors']['password'] != null) {
                                setState(() {
                                  errorHintMessage = 'Email atau password salah';
                                  showErrorHint = true;
                                });
                              }
                            }
                          }
                        });
                      } else {
                        setState(() {
                          errorHintMessage = 'Email atau password tidak boleh kosong';
                          showErrorHint = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: emailController.text != '' && passwordController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      child: Text(
                        'Masuk',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: emailController.text != '' && passwordController.text != '' ? Theme.of(context).textTheme.bodyLarge!.color : Colors.black54,
                          fontWeight: FontBodyWeight.medium(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'Belum memiliki akun?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: TextColorStyles.textDisabled(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      MoveToPage(context: context, target: const RegisterCompanyCodePage()).go();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColorStyles.primarySurface(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      child: Text(
                        'Daftar',
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
          ],
        ),
      ),
    );
  }
}