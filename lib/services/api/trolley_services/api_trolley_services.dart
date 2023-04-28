import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';

class APITrolleyServices {
  BuildContext context;

  APITrolleyServices({
    required this.context,
  });

  Future<TrolleyModel?> call() async {
    TrolleyModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/transaction/cart',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'member_id': memberId,
              },
            ).then((getResult) {
              result = TrolleyModel.fromJson(getResult.data);

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

  Future<bool> addOrUpdate(LocalTrolleyProduct data) async {
    bool result = false;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/transaction/cart',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              data: data.trolleyData.varian != null ?
              {
                'member_id': memberId,
                'product_id': data.trolleyData.product!.sId,
                'varian_id': data.trolleyData.varian,
                'qty': data.qty,
                'price': data.trolleyData.price,
              } :
              {
                'member_id': memberId,
                'product_id': data.trolleyData.product!.sId,
                'qty': data.qty,
                'price': data.trolleyData.price,
              },
            ).then((getResult) {
              if(getResult.statusCode == 200 || getResult.statusCode == 201) {
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