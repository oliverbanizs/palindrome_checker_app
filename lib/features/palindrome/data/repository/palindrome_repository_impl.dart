import 'package:palindrome_checker_app/features/core/constants/logger_helper.dart';
import 'package:palindrome_checker_app/features/palindrome/data/remote_datasource/palindrome_remote_datesource.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/repository/palindrome_repository.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/api_response_status_helper.dart';

class PalindromeRepositoryImpl implements PalindromeRepository {
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

      final ApiResponse saveResponse =
          await PalindromeRemoteDatasource().addPalindromeResult(palindrome);

      return ApiResponseStatusHelper.handleResponse(
        saveResponse,
      );
    } catch (error) {
      logger.e('Error in checkPalindrome: $error');
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }

  @override
  Future<ApiResponse> getHistory() async {
    try {
      final ApiResponse fetchResponse =
          await PalindromeRemoteDatasource().fetchPalindromeHistory();

      return ApiResponseStatusHelper.handleResponse(
        fetchResponse,
      );
    } catch (error) {
      logger.e('Unexpected error in getHistory: $error');
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }

  @override
  Future<ApiResponse> clearHistory() async {
    try {
      final ApiResponse deleteResponse =
          await PalindromeRemoteDatasource().deleteAllPalindromeRecords();

      return ApiResponseStatusHelper.handleResponse(
        deleteResponse,
      );
    } catch (error) {
      logger.e('Unexpected error in clearHistory: $error');
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }
}
