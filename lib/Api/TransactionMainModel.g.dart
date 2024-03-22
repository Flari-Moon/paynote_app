// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionMainModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionMainModel _$TransactionMainModelFromJson(Map<String, dynamic> json) {
  return TransactionMainModel(
    json['date'] as String,
    json['transaction'] == null
        ? null
        : TransactionSortedDateModel.fromJson(
            json['transaction'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransactionMainModelToJson(
        TransactionMainModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'transaction': instance.transaction,
    };
