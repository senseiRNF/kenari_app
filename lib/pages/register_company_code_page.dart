import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/pages/register_form_page.dart';
import 'package:kenari_app/pages/success_register_page.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class RegisterCompanyCodePage extends StatefulWidget {
  const RegisterCompanyCodePage({super.key});

  @override
  State<RegisterCompanyCodePage> createState() => _RegisterCompanyCodePageState();
}

class _RegisterCompanyCodePageState extends State<RegisterCompanyCodePage> {
  TextEditingController companyCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
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
                      'Daftar Akun',
                      style: HeadingTextStyles.headingS(),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: NeutralColorStyles.neutral05(),
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
                      'Silahkan masukkan kode perusahaan Anda untuk mendaftar akun',
                      style: MTextStyles.regular(),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      color: InfoColorStyles.infoSurface(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              color: InfoColorStyles.infoMain(),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Kode perusahaan didapatkan melalui pengelola perusahaan',
                                  style: XSTextStyles.medium().copyWith(
                                    color: InfoColorStyles.infoMain(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      'Kode Perusahaan',
                      style: STextStyles.medium().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: companyCodeController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: KPSFC',
                        hintStyle: MTextStyles.regular(),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        setState(() {});
                      },
                      onSubmitted: (data) {

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
                  if(companyCodeController.text != 'SFC') {
                    OkDialog(
                      context: context,
                      title: 'Kode Perusahaan tidak ditemukan',
                      message: 'dapatkan Kode Perusahaan melalui pengelola perusahaan.',
                    ).show();
                  } else {
                    MoveToPage(context: context, target: RegisterFormPage(companyCode: companyCodeController.text), callback: (callbackResult) {
                      if(callbackResult != null && callbackResult == true) {
                        ReplaceToPage(context: context, target: const SuccessRegisterPage()).go();
                      }
                    }).go();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: companyCodeController.text != '' ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Lanjutkan',
                    style: LTextStyles.medium().copyWith(
                      color: companyCodeController.text != '' ? LTextStyles.regular().color : Colors.black54,
                      fontWeight: FontWeight.w500,
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