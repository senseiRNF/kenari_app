import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/profile/api_profile_services.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_profile_form_data.dart';
import 'package:kenari_app/styles/color_styles.dart';
import 'package:kenari_app/styles/text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? newProfileImage;

  TextEditingController companyCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? companyId;
  String? memberId;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  Future initLoad() async {
    await LocalSharedPrefs().readKey('name').then((nameResult) async {
      setState(() {
        nameController.text = nameResult ?? '';
      });

      await LocalSharedPrefs().readKey('phone').then((phoneResult) async {
        setState(() {
          phoneController.text = phoneResult ?? '';
        });

        await LocalSharedPrefs().readKey('email').then((emailResult) async {
          setState(() {
            emailController.text = emailResult ?? '';
          });

          await LocalSharedPrefs().readKey('company_code').then((companyCodeResult) async {
            setState(() {
              companyCodeController.text = companyCodeResult ?? '';
            });

            await LocalSharedPrefs().readKey('company_id').then((companyIdResult) async {
              setState(() {
                companyId = companyIdResult;
              });

              await LocalSharedPrefs().readKey('member_id').then((memberIdResult) {
                setState(() {
                  memberId = memberIdResult;
                });
              });
            });
          });
        });
      });
    });
  }

  Future<void> showImageSourceBottomDialog() async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext modalBottomContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Ganti foto profil',
                style: STextStyles.medium().copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {

                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 54.0,
                      height: 54.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.image,
                            color: PrimaryColorStyles.primaryMain(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Pilih dari Galeri',
                        style: STextStyles.medium(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {

                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 54.0,
                      height: 54.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: PrimaryColorStyles.primaryMain(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Ambil Foto',
                        style: STextStyles.medium(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {

                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 54.0,
                      height: 54.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BorderColorStyles.borderStrokes(),
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {

                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.delete,
                            color: PrimaryColorStyles.primaryMain(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Hapus Foto',
                        style: STextStyles.medium(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        );
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
                            'Edit Profile',
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
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40.0,
                            color: IconColorStyles.iconColor(),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            showImageSourceBottomDialog();
                          },
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Ganti Foto Profil',
                              style: MTextStyles.medium().copyWith(
                                color: PrimaryColorStyles.primaryMain(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Kode Perusahaan',
                          style: STextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: companyCodeController,
                          decoration: InputDecoration(
                            hintText: 'Kode Perusahaan',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {

                          },
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Nama',
                          style: STextStyles.medium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Nama User',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {

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
                            hintText: 'Nomor Handphone User',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {

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
                            hintText: 'Email User',
                            hintStyle: MTextStyles.regular(),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    APIProfileServices(context: context).updateProfile(
                      memberId,
                      LocalProfileFormData(
                        companyId: companyId,
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      ),
                    ).then((result) {
                      if(result == true) {
                        OkDialog(
                          context: context,
                          message: 'Sukses memperbaharui data',
                          okText: 'Oke',
                          okFunction: () {
                            BackFromThisPage(context: context, callbackData: true).go();
                          },
                        ).show();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Simpan',
                      style: LTextStyles.medium(),
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