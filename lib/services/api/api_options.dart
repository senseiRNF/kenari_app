import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
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
        sendTimeout: const Duration(milliseconds: 15000),
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
      );

      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

        return client;
      };
    });

    return dio;
  }
}