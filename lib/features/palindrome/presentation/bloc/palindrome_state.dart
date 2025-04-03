part of 'palindrome_bloc.dart';

abstract class PalindromeState {
  const PalindromeState();
}

class PalindromeInitial extends PalindromeState {
}

class PalindromeLoading extends PalindromeState {
}

class PalindromeLoaded extends PalindromeState {
  final List<PalindromeResult> palindromes;

  const PalindromeLoaded(this.palindromes);
}

class PalindromeError extends PalindromeState {
}

