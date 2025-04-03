import 'dart:convert';
import '../constants/logger_helper.dart';
import 'api_response.dart';
import 'package:http/http.dart' as http;

class ApiResponseStatusHelper {
  static ApiResponse handleResponse(http.Response response, [Function(dynamic)? parseData]) {
    try {
      final String responseBody = utf8.decode(response.bodyBytes).trim();
      final dynamic data = jsonDecode(responseBody);

      return ApiResponse(
        response: parseData != null ? parseData(data) : data,
        apiResponseStatus: response.statusCode,
      );
    } catch (e) {
      logger.e('Error Handling Response: $e');
      return ApiResponse(apiResponseStatus: response.statusCode);
    }
  }

  static void handleResponseStatus(ApiResponse response, {required Function() onOkResponse, required Function() onErrorResponse}) {
    if(response.apiResponseStatus == 200) {
      onOkResponse();
    } else {
      onErrorResponse();
    }
  }
}