import 'package:Budgy/helpers/database_helper.dart';
import 'package:Budgy/models/Transaction.dart';
import 'package:Budgy/resources/code_strings.dart';

class TransactionService {
  static DatabaseHelper _dbHelper = DatabaseHelper.instance;

  static void createTransaction(Transaction transaction) {
    _dbHelper.insert(CodeStrings.transactionTableName, {
      CodeStrings.datetimeColumnName: transaction.datetime.toString(),
      CodeStrings.amountColumnName: transaction.amount,
      CodeStrings.currencyColumnName: transaction.currency,
      CodeStrings.isExpenseColumnName: transaction.isExpense.toString(),
      CodeStrings.categoryIdColumnName: transaction.categoryId,
    });
  }

  static Future<Transaction> getTransaction(int transactionId) async {
    List<Map<String, dynamic>> data = await _dbHelper.query(
        tableName: CodeStrings.transactionTableName,
        where: "${CodeStrings.idColumnName} = ?",
        whereArgs: [transactionId.toString()],
        columns: [CodeStrings.datetimeColumnName, CodeStrings.idColumnName]);

    return Transaction.fromJson(data[0]);
  }

  static Future<List<Transaction>> getAllTransaction() async {
    List<Map<String, dynamic>> data = await _dbHelper.query(
      tableName: CodeStrings.transactionTableName,
      columns: [CodeStrings.datetimeColumnName, CodeStrings.idColumnName],
    );

    return data
        .map<Transaction>((element) => Transaction.fromJson(element))
        .toList();
  }

  static void editTransaction(
      int transactionId, Transaction newTransaction) async {
    _dbHelper.update(
      CodeStrings.transactionTableName,
      CodeStrings.idColumnName,
      transactionId,
      newTransaction.toJson(),
    );
  }

  static void deleteTransaction(int transactionId) async {
    _dbHelper.delete(
      CodeStrings.transactionTableName,
      CodeStrings.idColumnName,
      transactionId,
    );
  }
}
