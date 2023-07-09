import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/transaction_order_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_trolley_product.dart';

class APITransactionServices {
  BuildContext context;

  APITransactionServices({required this.context});

  Future<TransactionOrderModel?> callAll() async {
    TransactionOrderModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/transaction/order',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'member_id': memberId,
              },
            ).then((getResult) {
              result = TransactionOrderModel.fromJson(getResult.data);

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioExc) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });

    return result;
  }

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
            MapEntry('address_id', data[0].trolleyData.product != null && data[0].trolleyData.product!.address != null ? data[0].trolleyData.product!.address!.sId ?? '' : ''),
          });

          if(data.isNotEmpty) {
            for(int i = 0; i < data.length; i++) {
              formData.fields.add(
                MapEntry('cart_id[$i]', data[i].trolleyData.sId ?? ''),
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
              data: formData,
            ).then((postResult) {
              if(postResult.statusCode == 200 || postResult.statusCode == 201) {
                result = true;
              }

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(_) {
            BackFromThisPage(context: context).go();
          }
        });
      });
    });

    return result;
  }
}