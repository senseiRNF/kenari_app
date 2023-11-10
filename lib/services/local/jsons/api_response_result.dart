import 'package:dio/dio.dart';

class APIResponseResult {
  bool apiResult;
  dynamic dataResult;
  DioException? dioException;

  APIResponseResult({
    required this.apiResult,
    this.dataResult,
    this.dioException,
  });
}