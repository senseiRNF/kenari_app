import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';

class APIRegisterServices {
  BuildContext context;
  int? companyId;
  String name;
  String? phone;
  String email;
  String password;

  APIRegisterServices({
    this.companyId,
    required this.context,
    required this.name,
    this.phone,
    required this.email,
    required this.password,
  });

  Future<bool> call() async {
    bool result = false;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.post(
          '/auth/register',
          data: {
            'company_id': companyId,
            'name': name,
            'phone': phone,
            'email': email,
            'password': password,
          },
        ).then((postResult) {
          BackFromThisPage(context: context).go();

          result = true;
        });
      } on DioError catch(dioErr) {
        BackFromThisPage(context: context).go();

        ErrorHandler(context: context, dioErr: dioErr).handle();
      }
    });

    return result;
  }
}