import 'package:hive/hive.dart';
import 'package:palindrome_checker_app/features/core/utils/api_response.dart';
import '../../../core/constants/logger_helper.dart';
import '../../domain/entity/palindrome_result.dart';

class PalindromeLocalDatasource {
  final Box<PalindromeResult> _palindromeBox;

  PalindromeLocalDatasource() : _palindromeBox = Hive.box<PalindromeResult>('palindromes');

  Future<ApiResponse> cachePalindrome(PalindromeResult palindrome) async {
    try {
      await _palindromeBox.add(palindrome);
      logger.i('Palindrome cached successfully');
      return ApiResponse(
        apiResponseStatus: 200,
      );
    } catch (e, stackTrace) {
      logger.e('Error caching palindrome: $e', stackTrace: stackTrace);
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }

  Future<ApiResponse> getCachedPalindromes() async {
    try {
      final palindromes = _palindromeBox.values.toList();
      logger.i('Retrieved ${palindromes.length} cached palindromes');
      return ApiResponse(
        apiResponseStatus: 200,
        response: palindromes,
      );
    } catch (e, stackTrace) {
      logger.e('Error retrieving cached palindromes: $e', stackTrace: stackTrace);
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }

  Future<ApiResponse> clearPalindromes() async {
    try {
      await _palindromeBox.clear();
      logger.i('All palindromes cleared from cache');
      return ApiResponse(
        apiResponseStatus: 200,
        response: {'deletedCount': _palindromeBox.length},
      );
    } catch (e, stackTrace) {
      logger.e('Error clearing palindromes: $e', stackTrace: stackTrace);
      return ApiResponse(
        apiResponseStatus: 500,
      );
    }
  }
}