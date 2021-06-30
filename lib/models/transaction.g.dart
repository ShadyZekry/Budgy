// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    id: json['id'] as int?,
    datetime: DateTime.parse(json['datetime'] as String),
    amount: (json['amount'] as num).toDouble(),
    currency: json['currency'] as String,
    isExpense: Transaction._isExpenseFromJson(json['is_expense'] as int),
    categoryId: json['category_id'] as int,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime.toIso8601String(),
      'amount': instance.amount,
      'currency': instance.currency,
      'is_expense': Transaction._isExpenseToJson(instance.isExpense),
      'category_id': instance.categoryId,
    };
