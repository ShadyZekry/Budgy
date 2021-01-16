import 'package:json_annotation/json_annotation.dart';
part 'Transaction.g.dart';

@JsonSerializable()
class Transaction {
  int id;
  DateTime datetime;
  int amount;
  String currency;
  @JsonKey(
    name: "is_expense",
    toJson: _isExpenseToJson,
    fromJson: _isExpenseFromJson,
  )
  bool isExpense;
  @JsonKey(name: "category_id")
  int categoryId;

  Transaction.empty();
  Transaction(
    this.id,
    this.datetime,
    this.amount,
    this.currency,
    this.isExpense,
    this.categoryId,
  );

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  static bool _isExpenseFromJson(int value) => value == 1 ? true : false;
  static int _isExpenseToJson(bool value) => value ? 1 : 0;
}
