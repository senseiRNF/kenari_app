import 'package:dio/dio.dart';

class APIResponseResult {
  bool apiResult;
  dynamic dataResult;
  DioError? dioError;

  APIResponseResult({
    required this.apiResult,
    this.dataResult,
    this.dioError,
  });
}