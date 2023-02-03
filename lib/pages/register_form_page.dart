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

  bool showErrorNameHint = false;
  bool showErrorPhoneHint = false;
  bool showErrorEmailHint = false;
  bool showErrorPasswordHint = false;
  bool showErrorPasswordConfHint = false;

  void checkForm() {
    if(nameController.text == '') {
      setState(() {
        showErrorNameHint = true;
      });
    } else {
      if(phoneController.text == '' || phoneController.text == '082123802060' || phoneController.text == '+6282123802060') {
        setState(() {
          showErrorPhoneHint = true;
        });
      } else {
        if(emailController.text == '' || emailController.text == 'novian.shatter@gmail.com') {
          setState(() {
            showErrorEmailHint = true;
          });
        } else {
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
              showUserAgreementBottomDialog();
            }
          }
        }
      }
    }
  }

  void showUserAgreementBottomDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext modalBottomSheet) {
        bool isAgreed = false;

        return StatefulBuilder(builder: (BuildContext bottomContext, stateSetter) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 5.0,
                    width: 60.0,
                    color: NeutralColorStyles.neutral04(),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Syarat dan Ketentuan Umum Kenari',
                          style: LTextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Kebijakan Privasi',
                          style: MTextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: Text(
                        'Saya menyetujui Kebijakan Privasi & Konfirmasi Penggunaan Data dari Kenari.',
                        style: STextStyles.medium(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isAgreed,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (onChanged) {
                              stateSetter(() {
                                isAgreed = !isAgreed;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Saya telah membaca dan setuju dengan semua ketentuan diatas.',
                              style: STextStyles.medium().copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(isAgreed) {
                            BackFromThisPage(context: context, callbackData: true).go();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAgreed ? PrimaryColorStyles.primaryMain() : NeutralColorStyles.neutral04(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: Text(
                            'Setuju',
                            style: LTextStyles.medium().copyWith(
                              color: isAgreed ? LTextStyles.regular().color : Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

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
                                  errorText: showErrorNameHint ? 'Harap masukkan nama terlebih dahulu' : null,
                                ),
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});

                                  if(showErrorNameHint == true) {
                                    setState(() {
                                      showErrorNameHint = false;
                                    });
                                  }
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
                                  errorText: showErrorPhoneHint ? phoneController.text != '' ? 'Nomor telah tedaftar' : 'Harap masukkan nomor terlebih dahulu' : null,
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});

                                  if(showErrorPhoneHint == true) {
                                    setState(() {
                                      showErrorPhoneHint = false;
                                    });
                                  }
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
                                  errorText: showErrorEmailHint ? emailController.text != '' ? 'Email telah terdaftar' : 'Harap masukkan email terlebih dahulu' : null,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) {
                                  setState(() {});

                                  if(showErrorEmailHint == true) {
                                    setState(() {
                                      showErrorEmailHint = false;
                                    });
                                  }
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
                                obscureText: obscurePassword,
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
                                  errorText: showErrorPasswordHint ? passwordController.text != '' ? 'Password minimal 8 karakter, terdiri dari huruf kapital, huruf kecil, simbol dan angka' : 'Harap masukkan password terlebih dahulu' : null,
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
                                style: STextStyles.medium().copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextField(
                                controller: confirmPasswordController,
                                obscureText: obscureConfPassword,
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
                                onSubmitted: (_) {
                                  checkForm();
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
                  checkForm();
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