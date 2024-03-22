// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsModel _$AccountsModelFromJson(Map<String, dynamic> json) {
  return AccountsModel(
    id: json['id'] as String,
    userId: json['userId'] as String,
    accountId: json['accountId'] as String,
    accountNumber: json['accountNumber'] as String,
    type: json['type'] as String,
    balance: (json['balance'] as num)?.toDouble(),
    currencyCode: json['currencyCode'] as String,
  );
}

Map<String, dynamic> _$AccountsModelToJson(AccountsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'accountId': instance.accountId,
      'accountNumber': instance.accountNumber,
      'type': instance.type,
      'balance': instance.balance,
      'currencyCode': instance.currencyCode,
    };
