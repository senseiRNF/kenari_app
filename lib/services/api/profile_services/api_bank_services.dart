import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/bank_model.dart';
import 'package:kenari_app/services/api/models/list_bank_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';
import 'package:kenari_app/services/local/jsons/local_bank_account_data.dart';

class APIBankServices {
  BuildContext context;

  APIBankServices({
    required this.context,
  });

  Future<BankModel?> getBankByMemberId() async {
    BankModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/bank-account',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'member_id': memberId,
              },
            ).then((getResult) {
              BackFromThisPage(context: context).go();

              result = BankModel.fromJson(getResult.data);
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

  Future<ListBankModel?> getListBank() async {
    ListBankModel? result;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.get(
            '/bank',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((getResult) {
            BackFromThisPage(context: context).go();

            result = ListBankModel.fromJson(getResult.data);
          });
        } on DioException catch(dioExc) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioExc: dioExc).handle();
        }
      });
    });

    return result;
  }

  Future<bool> createBankData(LocalBankAccountData data) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'bank_id': data.bankId,
      'member_id': data.memberId,
      'account_no': data.accountNumber,
      'account_name': data.accountName,
    });

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.post(
            '/bank-account',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            data: formData,
          ).then((postResult) {
            BackFromThisPage(context: context).go();

            result = true;
          });
        } on DioException catch(dioExc) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioExc: dioExc).handle();
        }
      });
    });

    return result;
  }

  Future<bool> updateBankData(String? bankAccountId, LocalBankAccountData data) async {
    bool result = false;

    FormData formData = FormData.fromMap({
      'bank_id': data.bankId,
      'member_id': data.memberId,
      'account_no': data.accountNumber,
      'account_name': data.accountName,
    });

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.patch(
            '/bank-account/$bankAccountId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
            data: formData,
          ).then((postResult) {
            BackFromThisPage(context: context).go();

            result = true;
          });
        } on DioException catch(dioExc) {
          BackFromThisPage(context: context).go();

          ErrorHandler(context: context, dioExc: dioExc).handle();
        }
      });
    });

    return result;
  }

  Future<bool> deleteBankData(String? bankAccountId) async {
    bool result = false;

    await LocalSharedPrefs().readKey('token').then((token) async {
      await APIOptions.init().then((dio) async {
        LoadingDialog(context: context).show();

        try {
          await dio.delete(
            '/bank-account/$bankAccountId',
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          ).then((postResult) {
            BackFromThisPage(context: context).go();

            result = true;
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