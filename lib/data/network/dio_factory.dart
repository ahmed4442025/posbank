import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:posbank/app/app_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCEPT_Value = "*/*";
const String Accept_Encoding = "Accept_Encoding";
const String Accept_Encoding_value = "gzip, deflate, br";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: ACCEPT_Value,
      Accept_Encoding: Accept_Encoding_value
    };

    dio.options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: headers,
        receiveTimeout: AppConstants.apiTimeOut,
        sendTimeout: AppConstants.apiTimeOut);

    if (!kReleaseMode && AppConstants.printDioLog) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
