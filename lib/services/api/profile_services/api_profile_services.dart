import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/profile_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_profile_form_data.dart';

class APIProfileServices {
  BuildContext context;

  APIProfileServices({
    required this.context,
  });

  Future<ProfileData?> showProfile() async {
    ProfileData? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/member/$memberId',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            ).then((getResult) {
              ProfileModel profileModel = ProfileModel.fromJson(getResult.data);

              if(profileModel.profileData != null) {
                result = profileModel.profileData!;

                LocalSharedPrefs().writeKey('name', profileModel.profileData!.name);
                LocalSharedPrefs().writeKey('email', profileModel.profileData!.email);
                LocalSharedPrefs().writeKey('phone', profileModel.profileData!.phoneNumber);

                if(profileModel.profileData!.company != null) {
                  LocalSharedPrefs().writeKey('company_id', profileModel.profileData!.company!.sId);
                  LocalSharedPrefs().writeKey('company_name', profileModel.profileData!.company!.name);
                  LocalSharedPrefs().writeKey('company_code', profileModel.profileData!.company!.code);
                }
              }

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioExc) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> updateProfile(LocalProfileFormData data) async {
    bool result = false;

    FormData formData = FormData();

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('company_id').then((companyId) async {
        await LocalSharedPrefs().readKey('member_id').then((memberId) async {
          formData.fields.addAll({
            MapEntry('company_id', companyId ?? ''),
            MapEntry('name', data.name ?? ''),
            MapEntry('email', data.email ?? ''),
            MapEntry('phone_number', data.phone ?? ''),
          });

          if(data.profileImage != null && data.profileImage!.xFile != null) {
            formData.files.add(
              MapEntry(
                'files',
                await MultipartFile.fromFile(
                  data.profileImage!.xFile!.path,
                  filename: data.profileImage!.xFile!.name,
                  contentType: MediaType('image', 'png'),
                ),
              ),
            );
          }

          await APIOptions.init().then((dio) async {
            LoadingDialog(context: context).show();

            try {
              await dio.patch(
                '/member/$memberId',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                    'Content-Type': 'multipart/form-data',
                  },
                ),
                data: formData,
              ).then((patchResult) {
                if(patchResult.statusCode == 200 || patchResult.statusCode == 201) {
                  result = true;
                }

                BackFromThisPage(context: context).go();
              });
            } on DioException catch(dioExc) {
              BackFromThisPage(context: context).go();

              ErrorHandler(context: context, dioExc: dioExc).handle();
            }
          });
        });
      });
    });

    return result;
  }

  Future<bool> updatePassword(String oldPass, String newPass, String confPass) async {
    bool result = false;

    FormData formData = FormData();

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        formData.fields.addAll({
          MapEntry('old_password', oldPass),
          MapEntry('password', newPass),
          MapEntry('password_confirmation', confPass),
        });

        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.patch(
              '/member/update-password/$memberId',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'multipart/form-data',
                },
              ),
              data: formData,
            ).then((patchResult) {
              if(patchResult.statusCode == 200 || patchResult.statusCode == 201) {
                result = true;
              }

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioExc) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });

    return result;
  }
}