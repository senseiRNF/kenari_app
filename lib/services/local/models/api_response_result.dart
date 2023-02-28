import 'package:dio/dio.dart';

class APIResponseResult {
  bool apiResult;
  DioError? dioError;

  APIResponseResult({
    required this.apiResult,
    this.dioError,
  });
}