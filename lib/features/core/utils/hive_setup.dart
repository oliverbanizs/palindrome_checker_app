import 'package:hive_flutter/adapters.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';
import '../constants/logger_helper.dart';

class HiveSetup {
  Future<void> initHive() async{
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(PalindromeResultAdapter());

      await Future.wait([
        Hive.openBox<PalindromeResult>('palindromes'),
      ]);
    } catch (e, stackTrace) {
      logger.e("Error during Hive setup: $e, $stackTrace");
    }
  }
}