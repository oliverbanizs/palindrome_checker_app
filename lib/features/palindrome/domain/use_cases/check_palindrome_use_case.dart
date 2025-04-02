import '../repository/palindrome_repository.dart';

class CheckPalindromeUseCase {
  final PalindromeRepository repository;

  CheckPalindromeUseCase(this.repository);

  Future<void> call(String text) async {
    await repository.checkPalindrome(
      text,
    );
  }
}