import '../repository/palindrome_repository.dart';

class GetHistoryUseCase {
  final PalindromeRepository repository;

  GetHistoryUseCase(this.repository);

  Future<void> call(String text) async {
    await repository.getHistory();
  }
}