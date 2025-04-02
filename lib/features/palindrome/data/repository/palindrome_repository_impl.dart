import 'package:palindrome_checker_app/features/palindrome/domain/repository/palindrome_repository.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/api_response.dart';
import '../../../core/utils/api_response_status_helper.dart';

class PalindromeRepositoryImpl implements PalindromeRepository {

  @override
  Future<ApiResponse>checkPalindrome(String text) async {
    String sanitizeText(String text) => text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    final String cleanText = sanitizeText(text);
    final bool isPalindrome = cleanText == cleanText.split('').reversed.join('');
    final response = await http.get(Uri());
    return ApiResponseStatusHelper.handleResponse(response);
  }

  @override
  Future<ApiResponse>getHistory() async {
    final response = await http.get(Uri());
    return ApiResponseStatusHelper.handleResponse(response);
  }

  @override
  Future<ApiResponse>clearHistory() async {
    final response = await http.get(Uri());
    return ApiResponseStatusHelper.handleResponse(response);
  }
}