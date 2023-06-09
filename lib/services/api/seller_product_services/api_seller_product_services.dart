import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as base_http;
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
              },
            ).then((getResult) {
              result = SellerProductModel.fromJson(getResult.data);

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioErr) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioErr: dioErr).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> dioUpdate(UpdateVariantData data) async {
    bool result = false;

    FormData formData = FormData();

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {

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

        if(data.files.isNotEmpty) {
          for(int i = 0; i < data.files.length; i++) {
            formData.files.add(
              MapEntry('files', await MultipartFile.fromFile(data.files[i].path, filename: data.files[i].name)),
            );
          }
        }

        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/product',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'multipart/form-data',
                },
              ),
              data: formData,
            ).then((postResult) {
              if(postResult.statusCode == 200 || postResult.statusCode == 201) {
                result = true;
              }

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioErr) {
            BackFromThisPage(context: context).go();

            ErrorHandler(context: context, dioErr: dioErr).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> httpUpdate(UpdateVariantData data) async {
    bool result = false;

    Uri uri = Uri.parse('$baseURL/product');

    base_http.MultipartRequest multipartRequest = base_http.MultipartRequest('POST', uri);

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        multipartRequest.headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        multipartRequest.fields.addAll({
          'name': data.name,
          'member_id': memberId ?? '',
          'product_category_id': data.productCategoryId,
          'description': data.description,
          'price': data.price,
          'stock': data.stock,
          'is_stock_always_available': '${data.isAlwaysAvailable}',
          'is_pre_order': '${data.isPreorder}',
          'address_id': data.addressId,
        });

        if(data.items.isNotEmpty) {
          for(int i = 0; i < data.items.length; i++) {
            multipartRequest.fields.addAll({
              'items[$i]': data.items[i].toString(),
            });
          }
        }

        if(data.files.isNotEmpty) {
          for(int i = 0; i < data.files.length; i++) {
            multipartRequest.files.add(
              base_http.MultipartFile('files', File(data.files[i].path).readAsBytes().asStream(), File(data.files[i].path).lengthSync(), filename: data.files[i].name),
            );
          }
        }

        try {
          LoadingDialog(context: context).show();

          await multipartRequest.send().then((postResult) {
            if(postResult.statusCode == 200 || postResult.statusCode == 201) {
              result = true;
            }

            print('\n\n${postResult.statusCode}\n\n');

            BackFromThisPage(context: context).go();
          });
        } on base_http.ClientException catch (err) {
          BackFromThisPage(context: context).go();

          print(err.message);
        }
      });
    });

    return result;
  }

  Future<bool> tempDioUpdate(UpdateVariantData data) async {
    bool result = false;

    FormData formData = FormData();

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {

        if(data.files.isNotEmpty) {
          for(int i = 0; i < data.files.length; i++) {
            formData.files.add(
              MapEntry('files', await MultipartFile.fromFile(data.files[i].path, filename: data.files[i].name)),
            );
          }
        }

        await TempAPIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.post(
              '/get-media',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'multipart/form-data',
                },
              ),
              data: formData,
            ).then((postResult) {
              print('\n\n\n${postResult.data}\n\n\n');

              if(postResult.statusCode == 200 || postResult.statusCode == 201) {
                result = true;
              }

              BackFromThisPage(context: context).go();
            });
          } on DioException catch(dioErr) {
            BackFromThisPage(context: context).go();

            print('\n\n\n${dioErr}\n\n\n');

            ErrorHandler(context: context, dioErr: dioErr).handle();
          }
        });
      });
    });

    return result;
  }

  Future<bool> tempHttpUpdate(UpdateVariantData data) async {
    bool result = false;

    Uri uri = Uri.parse('http://10.10.50.17:8082/api/get-media');

    base_http.MultipartRequest multipartRequest = base_http.MultipartRequest('POST', uri);

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        multipartRequest.headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

        if(data.files.isNotEmpty) {
          for(int i = 0; i < data.files.length; i++) {
            multipartRequest.files.add(
              base_http.MultipartFile('files', File(data.files[i].path).readAsBytes().asStream(), File(data.files[i].path).lengthSync(), filename: data.files[i].name),
            );
          }
        }

        try {
          LoadingDialog(context: context).show();

          await multipartRequest.send().then((postResult) {
            print('\n\n${postResult}\n\n');

            if(postResult.statusCode == 200 || postResult.statusCode == 201) {
              result = true;
            }

            BackFromThisPage(context: context).go();
          });
        } on base_http.ClientException catch (httpErr) {
          BackFromThisPage(context: context).go();

          OkDialog(context: context, message: httpErr.message);
        }
      });
    });

    return result;
  }
}