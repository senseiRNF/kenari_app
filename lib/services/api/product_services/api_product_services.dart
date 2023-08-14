import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/detail_product_model.dart';
import 'package:kenari_app/services/api/models/product_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APIProductServices {
  BuildContext context;

  APIProductServices({
    required this.context,
  });

  Future<ProductModel?> call(Map<String, dynamic>? query) async {
    ProductModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/transaction/product',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            queryParameters: query,
          ).then((getResult) {
            result = ProductModel.fromJson(getResult.data);

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

  Future<DetailProductModel?> callById(String productId) async {
    DetailProductModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('company_id').then((companyId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/product/$productId',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'company_id': companyId,
              },
            ).then((getResult) {
              result = DetailProductModel.fromJson(getResult.data);

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

  Future<Map<String, ProductModel?>> multipleCall() async {
    Map<String, ProductModel> result = {};

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/transaction/product',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            queryParameters: {
              'take': '5',
              'filter_by': 'new_product',
            },
          ).then((getResult) async {
            result.addEntries({
              MapEntry('newProduct', ProductModel.fromJson(getResult.data)),
            });

            try {
              await dio.get(
                '/transaction/product',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                ),
                queryParameters: {
                  'take': '3',
                  'filter_by': 'best_seller',
                },
              ).then((getResult) async {
                result.addEntries({
                  MapEntry('recommendedProduct', ProductModel.fromJson(getResult.data)),
                });

                try {
                  await dio.get(
                    '/transaction/product',
                    options: Options(
                      headers: {
                        'Authorization': 'Bearer $token',
                      },
                    ),
                    queryParameters: {
                      'take': '5',
                      'filter_by': 'discount',
                    },
                  ).then((getResult) async {
                    result.addEntries({
                      MapEntry('discountProduct', ProductModel.fromJson(getResult.data)),
                    });

                    BackFromThisPage(context: context).go();
                  });
                } on DioException catch(dioExc) {
                  BackFromThisPage(context: context).go();

                  ErrorHandler(context: context, dioExc: dioExc).handle();
                }
              });
            } on DioException catch(dioExc) {
              BackFromThisPage(context: context).go();

              ErrorHandler(context: context, dioExc: dioExc).handle();
            }
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