import 'package:hive/hive.dart';

part 'palindrome_result.g.dart';

@HiveType(typeId: 0)
class PalindromeResult extends HiveObject {
  @HiveField(0)
  final String input;
  @HiveField(1)
  final bool isPalindrome;
  @HiveField(2)
  final String timeStamp;

  PalindromeResult({
    required this.input,
    required this.isPalindrome,
    required this.timeStamp,
  });

  Map<String, dynamic> toJson() => {
        'input': input,
        'isPalindrome': isPalindrome,
        'timeStamp': timeStamp,
      };

  PalindromeResult copyWith(
      {String? input, bool? isPalindrome, String? timeStamp}) {
    return PalindromeResult(
        input: input ?? this.input,
        isPalindrome: isPalindrome ?? this.isPalindrome,
        timeStamp: timeStamp ?? this.timeStamp);
  }
}
