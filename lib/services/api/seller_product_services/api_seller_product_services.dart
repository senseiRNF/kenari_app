import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APISellerProductServices {
  BuildContext context;

  APISellerProductServices({required this.context});

  Future<bool> update(Map data) async {
    bool result = false;

    FormData formData = FormData();

    if(data['files'].isNotEmpty) {
      for(int i = 0; i < data['files'].length; i++) {
        formData.files.add(
          MapEntry('files[$i]', await MultipartFile.fromFile(data['files'][i].path)),
        );
      }
    }

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          formData.fields.addAll({
            MapEntry('name', data['name']),
            MapEntry('member_id', memberId ?? ''),
            MapEntry('product_category_id', data['product_category_id']),
            MapEntry('description', data['description']),
            MapEntry('price', data['price']),
            MapEntry('stock', data['stock']),
            MapEntry('is_stock_always_available', '${data['is_always_available']}'),
            MapEntry('is_pre_order', '${data['is_preorder']}'),
            MapEntry('address_id', data['address_id']),
          });

          if(data['items'].isNotEmpty) {
            for(int i = 0; i < data['items'].length; i++) {
              formData.fields.add(
                MapEntry('items[$i]', data['items'][i]),
              );
            }
          }

          try {
            await dio.post(
              '/product',
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