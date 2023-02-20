import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class APIOptions {
  static Future<Dio> init() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: 'https://develop-app.kenari.id/v1',
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

    return dio;
  }
}