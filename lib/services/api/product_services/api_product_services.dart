import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APIProductServices {
  BuildContext context;

  APIProductServices({
    required this.context,
  });

  Future<ProductModel?> call() async {
    ProductModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/product',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            result = ProductModel.fromJson(getResult.data);

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