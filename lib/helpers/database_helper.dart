import 'package:budgy/resources/res.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //DB needs to be a singleton, this is one of many ways to create singletons
  factory DatabaseHelper() => instance;
  static final DatabaseHelper instance = const DatabaseHelper._internal();
  const DatabaseHelper._internal();

  // Database? _sqfliteDatabase;
  Future<Database> get _db async {
    // if (_sqfliteDatabase != null) return _sqfliteDatabase;

    return await _openDB();
  }

  Future<Database> _openDB() async {
    final Database db = await openDatabase(
      //first parameter is the database path on device's disk
      join(await getDatabasesPath(), CodeStrings.dbName),
      // 'onCreate' is called if the database doesn't exist
      onCreate: _createDB,
      version: 1,
    );

    return db;
  }

  void _createDB(Database db, int version) async {
    // Run the CREATE TABLE statement on the database.
    await db.execute('''
      CREATE TABLE ${CodeStrings.categoryTableName} (
        ${CodeStrings.idColumnName} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CodeStrings.nameColumnName} TEXT NOT NULL,
        ${CodeStrings.iconColumnName} BOOLEAN NOT NULL,
        ${CodeStrings.colorColumnName} BOOLEAN NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE ${CodeStrings.transactionTableName} (
        ${CodeStrings.idColumnName} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CodeStrings.datetimeColumnName} DATETIME NOT NULL,
        ${CodeStrings.amountColumnName} DOUBLE NOT NULL,
        ${CodeStrings.currencyColumnName} CHARACTER(3) NOT NULL,
        ${CodeStrings.isExpenseColumnName} INTEGER NOT NULL,
        ${CodeStrings.categoryIdColumnName} INTEGER NOT NULL,
        FOREIGN KEY(${CodeStrings.categoryIdColumnName}) REFERENCES ${CodeStrings.categoryTableName}(${CodeStrings.idColumnName})
      )
      ''');
    // await db
    //     .insert(CodeStrings.miscTableName, {CodeStrings.scoreColumnName: 0});
  }

  void insert(String tableName, Map<String, dynamic> row) async {
    Database _db = await instance._db;
    await _db.insert(tableName, row);
  }

  void update(
    String tableName,
    String columnName,
    dynamic columnValue,
    Map<String, dynamic> newValues,
  ) async {
    Database _db = await instance._db;
    await _db.update(tableName, newValues,
        where: '$columnName = ?', whereArgs: [columnValue]);
  }

  void delete(String tableName, String columnName, dynamic columnValue) async {
    Database _db = await instance._db;
    await _db
        .delete(tableName, where: '$columnName = ?', whereArgs: [columnValue]);
  }

  Future<List<Map<String, dynamic>>> getTable(String tableName) async {
    Database _db = await instance._db;
    return await _db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> query({
    required String tableName,
    List<String>? columns,
    String? where,
    List<String>? whereArgs,
  }) async {
    Database _db = await instance._db;
    return await _db.query(tableName,
        columns: columns, where: where, whereArgs: whereArgs);
  }
}
