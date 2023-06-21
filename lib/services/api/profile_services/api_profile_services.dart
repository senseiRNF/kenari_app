import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_profile_form_data.dart';

class APIProfileServices {
  BuildContext context;

  APIProfileServices({
    required this.context,
  });

  Future<bool> updateProfile(String? memberId, LocalProfileFormData data) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'company_id': data.companyId,
      'name': data.name,
      'email': data.email,
      'phone_number': data.phone,
    });

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.patch(
            '/member/$memberId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            data: formData,
          ).then((postResult) {
            LocalSharedPrefs().writeKey('name', data.name);
            LocalSharedPrefs().writeKey('email', data.email);
            LocalSharedPrefs().writeKey('phone', data.phone);

            BackFromThisPage(context: context).go();

            result = true;
          });
        } on DioException catch(dioExc) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioExc: dioExc).handle();
        }
      });
    });

    return result;
  }
}