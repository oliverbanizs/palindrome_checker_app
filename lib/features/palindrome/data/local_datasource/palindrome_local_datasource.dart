import 'package:palindrome_checker_app/features/core/utils/db_helper.dart';
import 'package:palindrome_checker_app/features/palindrome/domain/entity/palindrome_result.dart';

import '../model/palindrome_result_model.dart';

class PalindromeLocalDatasource {
  Future<void> cachePalindrome(PalindromeResultModel palindrome) async {
    /*final db = await DBHelper().initDB();
    await db.insert(tableName, palindrome.toMap()); */
    throw UnimplementedError();
  }

  Future<List<PalindromeResult>> getCachedPalindromes() async {
    /*final db = await DBHelper().initDB();
    final maps = await db.query(tableName);
    return maps.map(PalindromeResultModel.fromMap).toList(); */
    throw UnimplementedError();
  }
}