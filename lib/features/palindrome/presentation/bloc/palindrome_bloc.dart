import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_checker_app/features/palindrome/data/repository/palindrome_repository_impl.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/repository/palindrome_repository.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/check_palindrome_use_case.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/clear_history_use_case.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/use_cases/get_history_use_case.dart';

part 'palindrome_event.dart';
part 'palindrome_state.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  final PalindromeRepository _repository = PalindromeRepositoryImpl();

  PalindromeBloc() : super(PalindromeInitial()) {
    on<CheckPalindromeEvent>(_onCheckPalindrome);
    on<GetHistoryEvent>(_onGetHistory);
    on<ClearHistoryEvent>(_onClearHistory);
  }

  Future<void> _onCheckPalindrome(
      CheckPalindromeEvent event, Emitter<PalindromeState> emit) async {
    final useCase = CheckPalindromeUseCase(_repository);
    emit(PalindromeLoading());
    final response = await useCase.call(event.input);
    response.apiResponseStatus == 200 ? add(const GetHistoryEvent()) :
    emit(PalindromeError());
  }

  Future<void> _onGetHistory(
      GetHistoryEvent event, Emitter<PalindromeState> emit) async {
    final useCase = GetHistoryUseCase(_repository);
    emit(PalindromeLoading());
    final response = await useCase.call();
    response.apiResponseStatus == 200 ? emit(PalindromeLoaded(response.response.response)) :
    emit(PalindromeError());
  }

  Future<void> _onClearHistory(
      ClearHistoryEvent event, Emitter<PalindromeState> emit) async {
    final useCase = ClearHistoryUseCase(_repository);
    emit(PalindromeLoading());
    final response = await useCase.call();
    response.apiResponseStatus == 200 ? add(const GetHistoryEvent()) :
    emit(PalindromeError());
  }
}