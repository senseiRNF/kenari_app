import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/check_company_model.dart';

class APICompanyServices {
  BuildContext context;
  String companyCode;

  APICompanyServices({
    required this.context,
    required this.companyCode,
  });

  Future<CheckCompanyModel?> call() async {
    CheckCompanyModel? result;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.get(
          '/company/check-company/$companyCode',
        ).then((postResult) {
          BackFromThisPage(context: context).go();

          result = CheckCompanyModel.fromJson(postResult.data);
        });
      } on DioError catch(dioErr) {
        BackFromThisPage(context: context).go();

        if(dioErr.response != null) {
          if(dioErr.response!.statusCode != 404) {
            ErrorHandler(context: context, dioErr: dioErr).handle();
          }
        } else {
          ErrorHandler(context: context, dioErr: dioErr).handle();
        }
      }
    });

    return result;
  }
}