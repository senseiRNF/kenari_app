import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/category_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APICategoryServices {
  BuildContext context;

  APICategoryServices({
    required this.context,
  });

  Future<CategoryModel?> call() async {
    CategoryModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/product-category',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            result = CategoryModel.fromJson(getResult.data);

            BackFromThisPage(context: context).go();
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