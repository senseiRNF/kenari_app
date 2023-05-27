import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/seller_product_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/local_variant_data.dart';

class APISellerProductServices {
  BuildContext context;

  APISellerProductServices({required this.context});

  Future<SellerProductModel?> call() async {
    SellerProductModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await LocalSharedPrefs().readKey('company_id').then((companyId) async {
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
                queryParameters: {
                  'member_id': memberId,
                  'company_id': companyId,
                },
              ).then((getResult) {
                result = SellerProductModel.fromJson(getResult.data);

                BackFromThisPage(context: context).go();
              });
            } on DioError catch(dioErr) {
              BackFromThisPage(context: context).go();

              ErrorHandler(context: context, dioErr: dioErr).handle();
            }
          });
        });
      });
    });

    return result;
  }

  Future<bool> update(UpdateVariantData data) async {
    bool result = false;

    FormData formData = FormData();

    if(data.files.isNotEmpty) {
      for(int i = 0; i < data.files.length; i++) {
        formData.files.add(
          MapEntry('files', await MultipartFile.fromFile(data.files[i].path)),
        );
      }
    }

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          formData.fields.addAll({
            MapEntry('name', data.name),
            MapEntry('member_id', memberId ?? ''),
            MapEntry('product_category_id', data.productCategoryId),
            MapEntry('description', data.description),
            MapEntry('price', data.price),
            MapEntry('stock', data.stock),
            MapEntry('is_stock_always_available', '${data.isAlwaysAvailable}'),
            MapEntry('is_pre_order', '${data.isPreorder}'),
            MapEntry('address_id', data.addressId),
          });

          if(data.items.isNotEmpty) {
            for(int i = 0; i < data.items.length; i++) {
              formData.fields.add(
                MapEntry('items[$i]', data.items[i].toString()),
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