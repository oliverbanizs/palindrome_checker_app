import '../../domain/entity/palindrome_result.dart';

class PalindromeResultModel extends PalindromeResult {

  PalindromeResultModel({
    required super.input,
    required super.isPalindrome,
    required super.timeStamp,
  });

  factory PalindromeResultModel.fromJson(Map<String, dynamic> json) {
    return PalindromeResultModel(
      input: json['input'],
      isPalindrome: json['isPalindrome'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input': input,
      'isPalindrome': isPalindrome,
      'timeStamp': timeStamp,
    };
  }
}