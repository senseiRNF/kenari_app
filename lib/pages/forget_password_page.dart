import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/reset_password_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailController = TextEditingController();

  bool showErrorHint = false;

  void checkEmail() {
    if(emailController.text != 'razy.firdana@intidata.net') {
      setState(() {
        showErrorHint = true;
      });
    } else {
      if(showErrorHint = true) {
        setState(() {
          showErrorHint = false;
        });
      }

      OkDialog(
        context: context,
        title: 'Email berhasil terkirim!',
        message: 'Silahkan cek email Anda untuk mengatur ulang kata sandi',
        okFunction: () {
          ReplaceToPage(context: context, target: const ResetPasswordPage()).go();
        },
      ).show();
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
                            'Lupa Password',
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
                      'Silahkan masukkan alamat email terdaftar untuk menerima email pengaturan ulang kata sandi',
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: showErrorHint ? DangerColorStyles.dangerMain() : Theme.of(context).textTheme.bodySmall!.color,
                        fontWeight: FontBodyWeight.medium(),
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan alamat email',
                        hintStyle: Theme.of(context).textTheme.bodyMedium!,
                        errorText: showErrorHint ? 'Email tidak terdaftar' : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        setState(() {});

                        if(showErrorHint == true) {
                          setState(() {
                            showErrorHint = false;
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
                  checkEmail();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: emailController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Lanjutkan',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: emailController.text != '' ? Theme.of(context).textTheme.bodyLarge!.color : Colors.black54,
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