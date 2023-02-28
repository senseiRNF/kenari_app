import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/models/api_response_result.dart';

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

  Future<APIResponseResult> call() async {
    APIResponseResult result = APIResponseResult(apiResult: false);

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

          result = APIResponseResult(apiResult: true);
        });
      } on DioError catch(dioErr) {
        BackFromThisPage(context: context).go();

        if(dioErr.response == null || dioErr.response!.statusCode != 412) {
          ErrorHandler(context: context, dioErr: dioErr).handle();
        }

        result = APIResponseResult(apiResult: false, dioError: dioErr);
      }
    });

    return result;
  }
}