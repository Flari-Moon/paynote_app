// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserTransactionsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransactionsResponse _$UserTransactionsResponseFromJson(
    Map<String, dynamic> json) {
  return UserTransactionsResponse(
    status: json['status'] as int,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : TransactionsData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserTransactionsResponseToJson(
        UserTransactionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

TransactionsData _$TransactionsDataFromJson(Map<String, dynamic> json) {
  return TransactionsData(
    transactions: (json['transactions'] as List)
        ?.map((e) => e == null
            ? null
            : TransactionSortedDateModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransactionsDataToJson(TransactionsData instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
    };
