import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APINotificationServices {
  BuildContext context;

  APINotificationServices({
    required this.context,
  });

  Future call() async {
    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/notification',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'member_id': memberId,
              },
            ).then((getResult) {
              // result = ProductModel.fromJson(getResult.data);

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioExc) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });
  }
}