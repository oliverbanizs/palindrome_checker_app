part of 'palindrome_bloc.dart';

abstract class PalindromeEvent {
  const PalindromeEvent();
}

class CheckPalindromeEvent extends PalindromeEvent {
  final String input;
  const CheckPalindromeEvent(this.input);
}

class GetHistoryEvent extends PalindromeEvent {
  const GetHistoryEvent();
}

class ClearHistoryEvent extends PalindromeEvent {
  const ClearHistoryEvent();
}