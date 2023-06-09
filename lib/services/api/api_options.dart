import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart';

const String baseURL = 'https://develop-app.kenari.id/v1';

class APIOptions {
  static Future<Dio> init() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseURL,
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
    );

    IOHttpClientAdapter clientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient client = HttpClient();

        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

        return client;
      },
    );

    dio.httpClientAdapter = clientAdapter;

    return dio;
  }
}

class HTTPOptions {
  static Future<Client> init() async {
    Client client = Client();

    return client;
  }
}

class TempAPIOptions {
  static Future<Dio> init() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: 'http://10.10.50.17:8082/api',
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
    );

    IOHttpClientAdapter clientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        HttpClient client = HttpClient();

        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

        return client;
      },
    );

    dio.httpClientAdapter = clientAdapter;

    return dio;
  }
}