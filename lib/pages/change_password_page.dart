import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/profile_services/api_profile_services.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confNewPasswordController = TextEditingController();

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfNewPassword = true;

  bool showOldPassErrorHint = false;
  bool showNewPassErrorHint = false;
  bool showConfNewPassErrorHint = false;

  String errorHintMessage = 'Kata sandi tidak boleh kosong!';

  Future changePassword() async {
    if(oldPasswordController.text == '') {
      setState(() {
        showOldPassErrorHint = true;
      });
    }

    if(newPasswordController.text == '') {
      setState(() {
        showNewPassErrorHint = true;
      });
    }

    if(confNewPasswordController.text == '') {
      setState(() {
        showConfNewPassErrorHint = true;
      });
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
                          onTap: () => BackFromThisPage(context: context).go(),
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
                            'Ubah Kata Sandi',
                            style: HeadingTextStyles.headingS(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Kata sandi lama',
                          style: STextStyles.medium(),
                        ),
                        TextField(
                          controller: oldPasswordController,
                          obscureText: obscureOldPassword,
                          decoration: InputDecoration(
                            hintText: 'Masukkan kata sandi lama',
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                obscureOldPassword = !obscureOldPassword;
                              }),
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  obscureOldPassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            errorText: showOldPassErrorHint ? errorHintMessage : null,
                            errorMaxLines: 3,
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (_) {
                            if(showOldPassErrorHint = true) {
                              setState(() {
                                showOldPassErrorHint = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Kata sandi baru',
                          style: STextStyles.medium(),
                        ),
                        TextField(
                          controller: newPasswordController,
                          obscureText: obscureNewPassword,
                          decoration: InputDecoration(
                            hintText: 'Masukkan kata sandi baru',
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                obscureNewPassword = !obscureNewPassword;
                              }),
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            errorText: showNewPassErrorHint ? errorHintMessage : null,
                            errorMaxLines: 3,
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (_) {
                            if(showNewPassErrorHint = true) {
                              setState(() {
                                showNewPassErrorHint = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Konfirmasi kata sandi baru',
                          style: STextStyles.medium(),
                        ),
                        TextField(
                          controller: confNewPasswordController,
                          obscureText: obscureConfNewPassword,
                          decoration: InputDecoration(
                            hintText: 'Masukkan kembali kata sandi baru',
                            suffixIcon: InkWell(
                              onTap: () => setState(() {
                                obscureConfNewPassword = !obscureConfNewPassword;
                              }),
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  obscureConfNewPassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            errorText: showConfNewPassErrorHint ? errorHintMessage : null,
                            errorMaxLines: 3,
                          ),
                          textInputAction: TextInputAction.done,
                          onChanged: (_) {
                            if(showConfNewPassErrorHint = true) {
                              setState(() {
                                showConfNewPassErrorHint = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () async => await APIProfileServices(context: context).updatePassword(
                  oldPasswordController.text,
                  newPasswordController.text,
                  confNewPasswordController.text,
                ).then((updateResult) {
                  if(updateResult == true) {
                    SuccessDialog(
                      context: context,
                      message: 'Sukses memperbaharui kata sandi',
                      okFunction: () => BackFromThisPage(context: context).go(),
                    ).show();
                  }
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: oldPasswordController.text != '' && newPasswordController.text != '' && confNewPasswordController.text != '' ?
                  PrimaryColorStyles.primaryMain() :
                  NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Simpan Perubahan',
                    style: LTextStyles.medium().copyWith(
                      color: oldPasswordController.text != '' && newPasswordController.text != '' && confNewPasswordController.text != '' ? Colors.white : Colors.black54,
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