import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/total_fee_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APITotalFeeServices {
  BuildContext context;

  APITotalFeeServices({
    required this.context,
  });

  Future<TotalFeeModel?> call() async {
    TotalFeeModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/iuran/total',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            result = TotalFeeModel.fromJson(getResult.data);

            BackFromThisPage(context: context).go();
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