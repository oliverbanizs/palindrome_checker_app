import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:palindrome_checker_app/features/core/constants/logger_helper.dart';
import 'package:palindrome_checker_app/features/palindrome/data/local_datasource/palindrome_local_datasource.dart';
import 'package:palindrome_checker_app/features/palindrome/data/remote_datasource/palindrome_remote_datesource.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/repository/palindrome_repository.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/api_response_status_helper.dart';

class PalindromeRepositoryImpl implements PalindromeRepository {
  final PalindromeRemoteDatasource remoteDatasource = PalindromeRemoteDatasource();
  final PalindromeLocalDatasource localDatasource = PalindromeLocalDatasource();

  Future<bool> hasInternetConnection() async {
    late List<ConnectivityResult> result;
    result = await(Connectivity().checkConnectivity());
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Future<ApiResponse> checkPalindrome(String text) async {
    try {
      String sanitizeText(String text) =>
          text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
      final String cleanText = sanitizeText(text);
      final bool isPalindrome =
          cleanText == cleanText.split('').reversed.join('');
      final PalindromeResult palindrome = PalindromeResult(
        input: text,
        isPalindrome: isPalindrome,
        timeStamp: DateTime.now().toIso8601String(),
      );

      await localDatasource.cachePalindrome(palindrome);

      if (await hasInternetConnection()) {
        try {
          final ApiResponse saveResponse =
          await remoteDatasource.addPalindromeResult(palindrome);
          return ApiResponseStatusHelper.handleResponse(saveResponse);
        } catch (e) {
          logger.e('Remote save failed, using local cache: $e');
          return ApiResponse(apiResponseStatus: 200);
        }
      }

      return ApiResponse(apiResponseStatus: 200);
    } catch (error) {
      logger.e('Error in checking palindrome: $error');
      return ApiResponse(apiResponseStatus: 500);
    }
  }

  @override
  Future<ApiResponse> getHistory() async {
    try {
      if (await hasInternetConnection()) {
        try {
          final ApiResponse remoteResponse =
          await remoteDatasource.fetchPalindromeHistory();

          if (remoteResponse.apiResponseStatus == 200) {
            final remotePalindromes = remoteResponse.response as List<PalindromeResult>;
            await localDatasource.clearPalindromes();
            for (final palindrome in remotePalindromes) {
              await localDatasource.cachePalindrome(palindrome);
            }
            return ApiResponseStatusHelper.handleResponse(remoteResponse);
          }
        } catch (e) {
          logger.e('Failed to fetch remote history, falling back to local: $e');
        }
      }

      final ApiResponse localResponse = await localDatasource.getCachedPalindromes();
      return ApiResponseStatusHelper.handleResponse(localResponse);
    } catch (error) {
      logger.e('Unexpected error in getting history: $error');
      return ApiResponse(apiResponseStatus: 500);
    }
  }

  @override
  Future<ApiResponse> clearHistory() async {
    try {
      await localDatasource.clearPalindromes();
      if (await hasInternetConnection()) {
        try {
          final ApiResponse remoteResponse =
          await remoteDatasource.deleteAllPalindromeRecords();
          return ApiResponseStatusHelper.handleResponse(remoteResponse);
        } catch (e) {
          logger.e('Failed to clear remote history: $e');
          return ApiResponse(apiResponseStatus: 200);
        }
      }

      return ApiResponse(apiResponseStatus: 200);
    } catch (error) {
      logger.e('Unexpected error in clearing history: $error');
      return ApiResponse(apiResponseStatus: 500);
    }
  }
}