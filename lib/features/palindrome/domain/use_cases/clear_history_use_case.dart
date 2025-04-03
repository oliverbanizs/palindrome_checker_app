import 'package:palindrome_checker_app/features/core/utils/api_response.dart';

import '../repository/palindrome_repository.dart';

class ClearHistoryUseCase {
  final PalindromeRepository repository;

  ClearHistoryUseCase(this.repository);

  Future<ApiResponse> call() async {
    final response = await repository.clearHistory();
    return response;
  }
}