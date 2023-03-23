import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/check_company_model.dart';
import 'package:kenari_app/services/api/models/company_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APICompanyServices {
  BuildContext context;

  APICompanyServices({
    required this.context,
  });

  Future<CheckCompanyModel?> getCompanyByCode(String companyCode) async {
    CheckCompanyModel? result;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.get(
          '/company/check-company/$companyCode',
        ).then((getResult) {
          BackFromThisPage(context: context).go();

          result = CheckCompanyModel.fromJson(getResult.data);
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

  Future<CompanyModel?> getCompanyById(String? companyId) async {
    CompanyModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/company/$companyId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            BackFromThisPage(context: context).go();

            result = CompanyModel.fromJson(getResult.data);
          });
        } on DioError catch(dioErr) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioErr: dioErr).handle();
        }
      });
    });

    return result;
  }
}