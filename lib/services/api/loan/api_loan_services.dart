import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/loan_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/models/api_response_result.dart';
import 'package:kenari_app/services/local/models/local_loan_data.dart';

class APILoanServices {
  BuildContext context;
  
  APILoanServices({
    required this.context,
  });

  Future<LoanModel?> callAll() async {
    LoanModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/peminjaman',
              queryParameters: {
                'member_id': memberId,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
            ).then((getResult) {
              result = LoanModel.fromJson(getResult.data);

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

  Future<LoanData?> callById(String loanId) async {
    LoanData? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/peminjaman/$loanId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            if(getResult.statusCode == 200) {
              result = LoanData.fromJson(getResult.data['data']);
            }

            BackFromThisPage(context: context).go();
          });
        } on DioError catch(dioErr) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioErr: dioErr).handle();
        }
      });
    });

    return result;
  }

  Future<APIResponseResult> writeTransaction(LocalLoanData data) async {
    late APIResponseResult result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.post(
            '/peminjaman',
            data: {
              'member_id': data.memberId,
              'jumlah_pinjaman_pengajuan': data.submissionAmount,
              'biaya_admin_persen': data.adminFeePercentage,
              'bunga_bulanan_persen': data.monthlyInterestPercentage,
              'jangka_waktu': data.period,
            },
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((postResult) {
            BackFromThisPage(context: context).go();

            result = APIResponseResult(apiResult: true);
          });
        } on DioError catch(dioErr) {
          BackFromThisPage(context: context).go();

          if(dioErr.response == null || dioErr.response!.statusCode != 412) {
            ErrorHandler(context: context, dioErr: dioErr).handle();
          }

          result = APIResponseResult(apiResult: false, dioError: dioErr);
        }
      });
    });

    return result;
  }
}