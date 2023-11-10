import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/jsons/api_response_result.dart';

class APIRegisterServices {
  BuildContext context;
  String? companyId;
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

  Future<APIResponseResult> register() async {
    APIResponseResult result = APIResponseResult(apiResult: false);

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.post(
          '/auth/register-member',
          data: {
            'company_id': companyId,
            'name': name,
            'email': email,
            'password': password,
            'phone_number': phone,
          },
        ).then((postResult) {
          BackFromThisPage(context: context).go();

          result = APIResponseResult(apiResult: true);
        });
      } on DioException catch(dioExc) {
        BackFromThisPage(context: context).go();

        if(dioExc.response == null || dioExc.response!.statusCode != 412) {
          ErrorHandler(context: context, dioExc: dioExc).handle();
        }

        result = APIResponseResult(apiResult: false, dioException: dioExc);
      }
    });

    return result;
  }
}