import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/notification_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APINotificationServices {
  BuildContext context;

  APINotificationServices({
    required this.context,
  });

  Future<NotificationModel?> call(int type, int menu) async {
    NotificationModel? result;

    String selectedType = type == 0 ? 'UPDATE' : 'TRANSAKSI';
    String? selectedMenu;

    switch(menu) {
      case 0:
        break;
      case 1:
        selectedMenu = 'IURAN';
        break;
      case 2:
        selectedMenu = 'PINJAMAN';
        break;
      case 3:
        selectedMenu = 'TITIP JUAL';
        break;
      case 4:
        selectedMenu = 'PESANAN';
        break;
      default:
        break;
    }

    await LocalSharedPrefs().readKey('token').then((token) async {
      await LocalSharedPrefs().readKey('member_id').then((memberId) async {
        await APIOptions.init().then((dio) async {
          LoadingDialog(context: context).show();

          try {
            await dio.get(
              '/notification',
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                },
              ),
              queryParameters: {
                'member_id': memberId,
                'type': selectedType,
                'menu': selectedMenu,
              },
            ).then((getResult) {
              result = NotificationModel.fromJson(getResult.data);

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

  Future<bool> postNotificationToken(String? fcmToken, String? token, String? userId) async {
    print('FCM Token: $fcmToken');

    bool result = false;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.post(
          '/token',
          data: {
            'token': fcmToken,
            'user_id': userId,
          },
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

        result = false;
      }
    });

    return result;
  }

  Future<bool> removeNotificationToken(String? fcmToken, String? token) async {
    bool result = false;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.delete(
          '/token/$fcmToken',
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

        result = false;
      }
    });

    return result;
  }
}