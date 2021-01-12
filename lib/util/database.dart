import 'package:Budgy/helpers/database_helper.dart';
import 'package:Budgy/res/code_strings.dart';

class DatabaseUtils {
  static DatabaseHelper _dbHelper = DatabaseHelper.instance;

  static Future<List<Map<String, dynamic>>> createTransaction() {
    _dbHelper.insert(CodeStrings.transactionTableName, {
      // TODO:: create Transaction
    });
  }

  static Future<List<Map<String, dynamic>>> getTransaction(
      int transactionId) async {
    return _dbHelper.query(
      tableName: CodeStrings.transactionTableName,
      where: "${CodeStrings.idColumnName} = ?",
      whereArgs: [transactionId.toString()],
    );
  }

  // TODO:: edit Transaction
  // TODO:: delet Transaction

  // TODO:: create category
  // TODO:: get category
  // TODO:: edit category
  // TODO:: delete category

  // static Future<List<Map<String, dynamic>>> getProgress() async {
  //   List<Map<String, dynamic>> _progressTable =
  //       await _dbHelper.getTable("progress");

  //   return _progressTable;
  // }

  // static void passDragLevel(String letter) async {
  //   _dbHelper.update("progress", "letter", letter, {"pass_drag": true});
  // }

  // static Future<List<Map<String, dynamic>>> getIncompleteDragLevels() async {
  //   return _dbHelper
  //       .query("progress", where: "pass_drag = ?", whereArgs: ["0"]);
  // }
}
