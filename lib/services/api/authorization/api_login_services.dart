import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenari_app/miscellaneous/dialog_functions.dart';
import 'package:kenari_app/miscellaneous/route_functions.dart';
import 'package:kenari_app/services/api/api_options.dart';
import 'package:kenari_app/services/api/models/login_model.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APILoginServices {
  BuildContext context;
  String email;
  String password;
  bool rememberMe;

  APILoginServices({
    required this.context,
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  Future<bool> call() async {
    bool result = false;

    await APIOptions.init().then((dio) async {
      LoadingDialog(context: context).show();

      try {
        await dio.post(
          '/auth/login',
          data: {
            'email': email,
            'password': password,
            'remember_me': rememberMe == true ? 1 : 0,
          },
        ).then((postResult) {
          LoginModel loginModel = LoginModel.fromJson(postResult.data);

          if(loginModel.loginData != null) {
            if(loginModel.loginData!.token != null) {
              LocalSharedPrefs().writeKey('token', loginModel.loginData!.token);

              if(loginModel.loginData!.user != null) {
                LocalSharedPrefs().writeKey('email', loginModel.loginData!.user!.email);
                LocalSharedPrefs().writeKey('id', loginModel.loginData!.user!.sId);
                LocalSharedPrefs().writeKey('name', loginModel.loginData!.user!.name);
              }
            }
          }

          BackFromThisPage(context: context).go();

          result = true;
        });
      } on DioError catch(dioErr) {
        BackFromThisPage(context: context).go();

        ErrorHandler(context: context, dioErr: dioErr).handle();
      }
    });

    return result;
  }
}