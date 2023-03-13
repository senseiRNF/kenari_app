import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:kenari_app/services/local/local_shared_prefs.dart';

class APIOptions {
  static Future<Dio> init() async {
    Dio dio = Dio();

    await LocalSharedPrefs().readKey('dev_url').then((devURL) {
      dio.options = BaseOptions(
        baseUrl: devURL ?? '',
        headers: {
          'Accept': 'application/json',
        },
        connectTimeout: 30000,
        receiveTimeout: 30000,
      );

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

        return client;
      };
    });

    return dio;
  }
}