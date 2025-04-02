import 'package:sqflite/sqflite.dart';
const String tableName = 'palindromes';
class DBHelper {
  Future<Database> initDB() async {
    final path = await getDatabasesPath();
    return openDatabase(
      path,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE $tableName(text TEXT PRIMARY KEY, isPalindrome INTEGER, timestamp INTEGER)',
      ),
      version: 1,
    );
  }
}