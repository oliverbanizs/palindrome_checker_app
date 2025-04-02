import '../../../core/utils/api_response.dart';

abstract class PalindromeRepository {
  Future<ApiResponse>checkPalindrome(String text);
  Future<ApiResponse>getHistory();
  Future<ApiResponse>clearHistory();
}