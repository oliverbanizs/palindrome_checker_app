import 'api_response.dart';

class ApiResponseStatusHelper {
  static ApiResponse handleResponse(ApiResponse response, {Function()? onOkResponse, Function()? onErrorResponse}) {
    if(response.apiResponseStatus == 200) {
      onOkResponse?.call;
      return ApiResponse(
          apiResponseStatus: response.apiResponseStatus,
          response: response.response != null ? response : null
      );
    } else {
      onErrorResponse?.call;
      return ApiResponse(
          apiResponseStatus: response.apiResponseStatus,
          response: response.response != null ? response : null
      );
    }
  }
}