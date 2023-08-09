import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/mandatory_fee_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APIMandatoryFeeServices {
  BuildContext context;

  APIMandatoryFeeServices({required this.context});

  Future<MandatoryFeeModel?> callAll(int? status) async {
    MandatoryFeeModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/iuran-wajib',
              queryParameters: status != null ?
              {
                'member_id': memberId,
                'status': status,
              } :
              {
                'member_id': memberId,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            ).then((getResult) {
              result = MandatoryFeeModel.fromJson(getResult.data);

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

  Future<MandatoryFeeData?> callById(String mandatoryFeeId) async {
    MandatoryFeeData? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/iuran-wajib/$mandatoryFeeId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            if(getResult.statusCode == 200) {
              result = MandatoryFeeData.fromJson(getResult.data['data']);
            }

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