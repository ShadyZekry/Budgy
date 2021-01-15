// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    json['id'] as int,
    json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
    json['amount'] as int,
    json['currency'] as String,
    Transaction._isExpenseFromJson(json['is_expense'] as int),
    json['category_id'] as int,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime?.toIso8601String(),
      'amount': instance.amount,
      'currency': instance.currency,
      'is_expense': Transaction._isExpenseToJson(instance.isExpense),
      'category_id': instance.categoryId,
    };
