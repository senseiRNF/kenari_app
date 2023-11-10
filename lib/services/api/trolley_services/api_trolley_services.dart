import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/trolley_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/jsons/local_trolley_product.dart';

class APITrolleyServices {
  BuildContext context;
  bool? hideLoadingOnUpdate;

  APITrolleyServices({
    required this.context,
    this.hideLoadingOnUpdate,
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
          } on DioException catch(dioExc) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> update(LocalTrolleyProduct data) async {
    bool result = false;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          if(hideLoadingOnUpdate == null || hideLoadingOnUpdate == false) {
            LoadingDialog(context: context).show();
          }

          try {
            await dio.post(
              '/transaction/cart/add-to-cart',
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
            ).then((postResult) {
              if(postResult.statusCode == 200 || postResult.statusCode == 201) {
                result = true;
              }

              if(hideLoadingOnUpdate == null || hideLoadingOnUpdate == false) {
                BackFromThisPage(context: context).go();
              }
            });
          } on DioException catch(dioExc) {
            if(hideLoadingOnUpdate == null || hideLoadingOnUpdate == false) {
              BackFromThisPage(context: context).go();
            }

            ErrorHandler(context: context, dioExc: dioExc).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> remove(String data) async {
    bool result = false;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.delete(
              '/transaction/cart/remove-item/$data',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            ).then((deleteResult) {
              if(deleteResult.statusCode == 200 || deleteResult.statusCode == 201) {
                result = true;
              }

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

  Future<bool> removeAll(List<String> data) async {
    bool result = false;

    FormData formData = FormData();

    for(int i = 0; i < data.length; i++) {
      formData.fields.add(
        MapEntry('cart_id[$i]', data[i]),
      );
    }

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/transaction/cart/remove-all-item',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              data: formData,
            ).then((deleteResult) {
              if(deleteResult.statusCode == 200 || deleteResult.statusCode == 201) {
                result = true;
              }

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
}