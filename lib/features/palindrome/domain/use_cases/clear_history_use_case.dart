import '../repository/palindrome_repository.dart';

class ClearHistoryUseCase {
  final PalindromeRepository repository;

  ClearHistoryUseCase(this.repository);

  Future<void> call(String text) async {
    await repository.clearHistory();
  }
}