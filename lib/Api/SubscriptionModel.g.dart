// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubscriptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return SubscriptionModel(
    json['subscriptionName'] as String,
    json['iban'] as String,
    json['defaultAmount'] as String,
    json['totalCount'] as int,
    json['totalAmount'] as String,
  );
}

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'subscriptionName': instance.subscriptionName,
      'iban': instance.iban,
      'defaultAmount': instance.defaultAmount,
      'totalCount': instance.totalCount,
      'totalAmount': instance.totalAmount,
    };
