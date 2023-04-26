import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfPassword = true;

  bool showErrorPasswordHint = false;
  bool showErrorPasswordConfHint = false;

  void checkForm() {
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if(passwordController.text == '' || !regExp.hasMatch(passwordController.text) == true || passwordController.text.length < 7) {
      setState(() {
        showErrorPasswordHint = true;
      });
    } else {
      if(confirmPasswordController.text == '' || confirmPasswordController.text != passwordController.text) {
        setState(() {
          showErrorPasswordConfHint = true;
        });
      } else {
        OkDialog(
          context: context,
          title: 'Password Berhasil Diubah',
          message: 'Silahkan kembali ke menu Login untuk masuk ke Aplikasi Kenari',
          okText: 'Masuk',
          okFunction: () {
            BackFromThisPage(context: context).go();
          },
        ).show();
      }
    }
  }

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
                            'Reset Password',
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Password baru anda harus berbeda dari password yang telah digunakan sebelumnya.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: TextColorStyles.textSecondary(),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Password Baru',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontBodyWeight.medium(),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
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
                        errorText: showErrorPasswordHint ? passwordController.text != '' ? 'Password minimal 8 karakter, terdiri dari huruf kapital, huruf kecil, simbol dan angka' : 'Password minimal 8 karakter, terdiri dari huruf kapital, huruf kecil, simbol dan angka' : null,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        setState(() {});

                        if(showErrorPasswordHint == true) {
                          setState(() {
                            showErrorPasswordHint = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Konfirmasi Password',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontBodyWeight.medium(),
                      ),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfPassword,
                      decoration: InputDecoration(
                        hintText: 'Ketik ulang password',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: TextColorStyles.textDisabled(),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureConfPassword = !obscureConfPassword;
                            });
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(
                              obscureConfPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        errorText: showErrorPasswordConfHint ? confirmPasswordController.text != '' ? 'Password harus sama' : 'Harap masukkan kembali password terlebih dahulu' : null,
                      ),
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        setState(() {});

                        if(showErrorPasswordConfHint == true) {
                          setState(() {
                            showErrorPasswordConfHint = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {
                  checkForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: passwordController.text != '' && confirmPasswordController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: passwordController.text != '' && confirmPasswordController.text != '' ? Theme.of(context).textTheme.bodyLarge!.color : Colors.black54,
                      fontWeight: FontBodyWeight.medium(),
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