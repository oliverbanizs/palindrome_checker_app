import 'package:palindrome_checker_app/features/core/utils/api_response.dart';

import '../repository/palindrome_repository.dart';

class GetHistoryUseCase {
  final PalindromeRepository repository;

  GetHistoryUseCase(this.repository);

  Future<ApiResponse> call() async {
    final response = await repository.getHistory();
    return response;
  }
}