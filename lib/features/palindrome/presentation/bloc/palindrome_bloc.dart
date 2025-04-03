import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_checker_app/features/core/utils/api_response.dart';
import 'package:palindrome_checker_app/features/core/utils/api_response_status_helper.dart';
import 'package:palindrome_checker_app/features/palindrome/data/repository/palindrome_repository_impl.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/repository/palindrome_repository.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/check_palindrome_use_case.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/clear_history_use_case.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/get_history_use_case.dart';

part 'palindrome_event.dart';
part 'palindrome_state.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {

  PalindromeBloc() : super(PalindromeInitial()) {
    final PalindromeRepository repository = PalindromeRepositoryImpl();

    on<CheckPalindromeEvent>((event, emit) async {
      final CheckPalindromeUseCase useCase = CheckPalindromeUseCase(repository);
      emit(PalindromeLoading());
      final response = await useCase.call(event.input);
      ApiResponseStatusHelper.handleResponseStatus(
        response,
        onOkResponse: () {
          emit(PalindromeLoaded(response.response));
        },
        onErrorResponse: () {
          emit(PalindromeError());
        }
      );
    });

    on<GetHistoryEvent>((event, emit) async {
      final GetHistoryUseCase useCase = GetHistoryUseCase(repository);
      emit(PalindromeLoading());
      final response = await useCase.call();
      ApiResponseStatusHelper.handleResponseStatus(
          response,
          onOkResponse: () {
            emit(PalindromeLoaded(response.response));
          },
          onErrorResponse: () {
            emit(PalindromeError());
          }
      );
    });

    on<ClearHistoryEvent>((event, emit) async {
      final ClearHistoryUseCase useCase = ClearHistoryUseCase(repository);
      emit(PalindromeLoading());
      final response = await useCase.call();
      ApiResponseStatusHelper.handleResponseStatus(
          response,
          onOkResponse: () {
            emit(PalindromeLoaded(response.response));
          },
          onErrorResponse: () {
            emit(PalindromeError());
          }
      );
    });
  }
}
