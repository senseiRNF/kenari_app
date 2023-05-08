import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

const String baseURL = 'https://develop-app.kenari.id/v1';

class APIOptions {
  static Future<Dio> init() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseURL,
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 20000),
    );

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      return client;
    };

    return dio;
  }
}