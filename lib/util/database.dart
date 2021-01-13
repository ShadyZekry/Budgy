import 'package:Budgy/helpers/database_helper.dart';
import 'package:Budgy/res/code_strings.dart';
import 'package:flutter/cupertino.dart';

class DatabaseUtils {
  static DatabaseHelper _dbHelper = DatabaseHelper.instance;

  static void createTransaction({
    @required DateTime datetime,
    @required int amount,
    @required String currency,
    @required bool isExpense,
    @required int categoryId,
  }) {
    _dbHelper.insert(CodeStrings.transactionTableName, {
      CodeStrings.datetimeColumnName: datetime.toString(),
      CodeStrings.amountColumnName: amount,
      CodeStrings.currencyColumnName: currency,
      CodeStrings.isExpenseColumnName: isExpense.toString(),
      CodeStrings.categoryIdColumnName: categoryId,
    });
  }

  static Future<Map<String, dynamic>> getTransaction(int transactionId) async {
    List<Map<String, dynamic>> data = await _dbHelper.query(
        tableName: CodeStrings.transactionTableName,
        where: "${CodeStrings.idColumnName} = ?",
        whereArgs: [transactionId.toString()],
        columns: [CodeStrings.datetimeColumnName, CodeStrings.idColumnName]);

    return data[0];
  }

  static Future<List<Map<String, dynamic>>> getAllTransaction() async {
    return await _dbHelper.query(
      tableName: CodeStrings.transactionTableName,
      columns: [CodeStrings.datetimeColumnName, CodeStrings.idColumnName],
    );
  }

  // TODO:: edit Transaction
  // TODO:: delet Transaction

  // TODO:: create category
  // TODO:: get category
  // TODO:: edit category
  // TODO:: delete category
}
