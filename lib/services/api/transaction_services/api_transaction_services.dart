import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';

class APITransactionServices {
  BuildContext context;

  APITransactionServices({required this.context});

  Future<bool> update(List<LocalTrolleyProduct> data) async {
    bool result = false;

    FormData formData = FormData();

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          formData.fields.addAll({
            MapEntry('member_id', memberId ?? ''),
            const MapEntry('payment_method', 'Dpay'),

          });

          if(data.isNotEmpty) {
            for(int i = 0; i < data.length; i++) {
              formData.fields.add(
                MapEntry('cart_id', data[i].trolleyData.sId ?? ''),
              );
            }
          }

          try {
            await dio.post(
              '/transaction/order',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              data: {},
            ).then((postResult) {
              if(postResult.statusCode == 200 || postResult.statusCode == 201) {
                result = true;
              }

              BackFromThisPage(context: context).go();
            });
          } on DioError catch(dioErr) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioErr: dioErr).handle();
          }
        });
      });
    });

    return result;
  }
}