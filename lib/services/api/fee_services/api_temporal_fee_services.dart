import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/temporal_fee_model.dart';
import 'package:kenari_app/services/api/models/temporal_fee_result_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/api_response_result.dart';
import 'package:kenari_app/services/local/models/local_temporal_fee_data.dart';

class APITemporalFeeServices {
  BuildContext context;

  APITemporalFeeServices({
    required this.context,
  });

  Future<TemporalFeeModel?> callAll() async {
    TemporalFeeModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/iuran-berjangka',
              queryParameters: {
                'member_id': memberId,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            ).then((getResult) {
              result = TemporalFeeModel.fromJson(getResult.data);

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

  Future<TemporalFeeData?> callById(String temporalFeeId) async {
    TemporalFeeData? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/iuran-berjangka/$temporalFeeId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            if(getResult.statusCode == 200) {
              result = TemporalFeeData.fromJson(getResult.data['data']);
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

  Future<APIResponseResult> writeTransaction(LocalTemporalFeeData data) async {
    late APIResponseResult result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.post(
            '/iuran-berjangka',
            data: {
              'member_id': data.memberId,
              'jumlah_iuran': data.amount,
              'jangka_waktu': data.period,
              'imbal_hasil': data.profit,
              'tanggal_mulai': DateFormat('yyyy-MM-dd').format(data.startDate),
              'tanggal_pencairan': DateFormat('yyyy-MM-dd').format(data.disbursementDate),
              'metode_pembayaran': data.paymentMethod,
            },
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((postResult) {
            BackFromThisPage(context: context).go();

            result = APIResponseResult(apiResult: true, dataResult: TemporalFeeResultModel.fromJson(postResult.data));
          });
        } on DioException catch(dioExc) {
          BackFromThisPage(context: context).go();

          if(dioExc.response == null || dioExc.response!.statusCode != 412) {
            ErrorHandler(context: context, dioExc: dioExc).handle();
          }

          result = APIResponseResult(apiResult: false, dioException: dioExc);
        }
      });
    });

    return result;
  }
}