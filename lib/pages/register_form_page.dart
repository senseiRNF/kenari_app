import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class RegisterFormPage extends StatefulWidget {
  final String companyCode;

  const RegisterFormPage({
    super.key,
    required this.companyCode,
  });

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      'Daftar Akun',
                      style: HeadingTextStyles.headingS(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/banner_register_form.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 150.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: ListView(
                            children: [
                              Text(
                                'Silahkan lengkapi informasi dibawah ini untuk melanjutkan pendaftaran',
                                style: MTextStyles.regular(),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Nama Lengkap',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Isi Nama lengkap disini',
                                  hintStyle: MTextStyles.regular(),
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Text(
                                'Nomor Handphone',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: 'Isi nomor Handphone aktif',
                                  hintStyle: MTextStyles.regular(),
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 25.0,
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
                                  hintText: 'Isi Email aktif mu disini',
                                  hintStyle: MTextStyles.regular(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Text(
                                'Password',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Buat Password mu disini',
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
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              Text(
                                'Konfirmasi Password',
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                  hintText: 'Ulangi Password',
                                  hintStyle: MTextStyles.regular(),
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
                                ),
                                textInputAction: TextInputAction.done,
                                onChanged: (_) {
                                  setState(() {});
                                },
                                onSubmitted: (_) {

                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: nameController.text != '' && phoneController.text != '' && emailController.text != '' && passwordController.text != '' && confirmPasswordController.text != '' ?
                  PrimaryColorStyles.primaryMain() :
                  NeutralColorStyles.neutral04(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Text(
                    'Lanjutkan',
                    style: LTextStyles.medium().copyWith(
                      color: nameController.text != '' && phoneController.text != '' && emailController.text != '' && passwordController.text != '' && confirmPasswordController.text != '' ?
                      LTextStyles.regular().color :
                      Colors.black54,
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