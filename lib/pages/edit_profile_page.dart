import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/profile_model.dart';
import 'package:kenari_app/services/api/profile_services/api_profile_services.dart';
import 'package:kenari_app/services/api/seller_product_services/api_seller_product_services.dart';
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

  ProfileData? profileData;
  MediaProfileData? profileImage;

  @override
  void initState() {
    super.initState();

    initLoad();
  }

  Future initLoad() async {
    await APIProfileServices(context: context).showProfile().then((profileResult) {
      setState(() {
        profileData = profileResult;

        if(profileResult != null) {
          nameController.text = profileResult.name ?? '';
          phoneController.text = profileResult.phoneNumber ?? '';
          emailController.text = profileResult.email ?? '';

          if(profileResult.company != null) {
            companyCodeController.text = "${profileResult.company!.code ?? ''} - ${profileResult.company!.name ?? ''}";
          }

          if(profileResult.profileImage != null) {
            profileImage = MediaProfileData(
              sId: profileResult.profileImage!.sId,
              url: profileResult.profileImage!.url,
            );
          }
        }
      });
    });
  }

  Future showImageSourceBottomDialog() async {
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
                onTap: () => BackFromThisPage(context: context, callbackData: 'gallery').go(),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.image,
                          color: PrimaryColorStyles.primaryMain(),
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
                onTap: () => BackFromThisPage(context: context, callbackData: 'camera').go(),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: PrimaryColorStyles.primaryMain(),
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
                onTap: () => BackFromThisPage(context: context, callbackData: 'delete').go(),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.delete,
                          color: PrimaryColorStyles.primaryMain(),
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
    ).then((dialogResult) async {
      if(dialogResult != null) {
        if(dialogResult != 'delete') {
          ImageSource source = dialogResult == 'camera' ? ImageSource.camera : ImageSource.gallery;

          await pickingImage(source).then((pickResult) {
            if(pickResult != null) {
              int bytesFile = File(pickResult.path).lengthSync();

              if(bytesFile <= 3200000) {
                setState(() {
                  profileImage = MediaProfileData(
                    xFile: pickResult,
                  );
                });
              } else {
                OkDialog(
                  context: context,
                  message: 'Ukuran file terlalu besar (max: 3MB)',
                  showIcon: false,
                ).show();
              }
            }
          });    
        } else {
          OptionDialog(
            context: context,
            message: 'Hapus foto tersimpan, Anda yakin?',
            yesFunction: () => removeProfileImage(),
          ).show();
        }
      }
    });
  }

  Future<XFile?> pickingImage(ImageSource source) async {
    XFile? result;

    ImagePicker picker = ImagePicker();

    await picker.pickImage(
      source: source,
      imageQuality: source == ImageSource.gallery ? 100 : 50,
    ).then((pickResult) async {
      result = pickResult;
    });

    return result;
  }

  Future updateProfile() async {
    await APIProfileServices(context: context).updateProfile(
      LocalProfileFormData(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        profileImage: profileImage,
      ),
    ).then((result) {
      if(result == true) {
        SuccessDialog(
          context: context,
          message: 'Sukses Memperbaharui Data',
          okFunction: () => BackFromThisPage(context: context).go(),
        ).show();
      }
    });
  }

  Future removeProfileImage() async {
    if(profileImage != null) {
      if(profileImage!.url != null) {
        await APISellerProductServices(context: context).dioRemoveImage(profileImage!.sId).then((removeResult) {
          if(removeResult == true) {
            setState(() {
              profileImage = null;
            });
          }
        });
      } else if(profileImage!.xFile != null) {
        setState(() {
          profileImage = null;
        });
      }
    } else {
      await OkDialog(
        context: context,
        message: 'Tidak dapat menghapus foto, foto tidak tersedia',
        showIcon: false,
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
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        profileImage != null ?
                        profileImage!.xFile != null ?
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                File(profileImage!.xFile!.path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Material(
                            color: Colors.transparent,
                          ),
                        ) :
                        CachedNetworkImage(
                          imageUrl: "$baseURL/${profileImage!.url ?? ''}",
                          width: 80.0,
                          height: 80.0,
                          imageBuilder: (context, imgProvider) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (errContext, url, err) {
                            return Icon(
                              Icons.person,
                              size: 40.0,
                              color: IconColorStyles.iconColor(),
                            );
                          },
                        ) :
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
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
                          onTap: () => showImageSourceBottomDialog(),
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
                  onPressed: () => updateProfile(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Simpan',
                      style: LTextStyles.medium().copyWith(
                        color: Colors.white,
                      ),
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