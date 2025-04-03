import 'package:palindrome_checker_app/features/core/utils/api_response.dart';

import '../repository/palindrome_repository.dart';

class CheckPalindromeUseCase {
  final PalindromeRepository repository;

  CheckPalindromeUseCase(this.repository);

  Future<ApiResponse> call(String text) async {
    final response = await repository.checkPalindrome(
      text,
    );
    return response;
  }
}