// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubscriptionsToBePaidModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionsToBePaidModel _$SubscriptionsToBePaidModelFromJson(
    Map<String, dynamic> json) {
  return SubscriptionsToBePaidModel(
    json['subscription_name'] as String,
    json['iban'] as String,
    (json['totalAmount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SubscriptionsToBePaidModelToJson(
        SubscriptionsToBePaidModel instance) =>
    <String, dynamic>{
      'subscription_name': instance.subscription_name,
      'iban': instance.iban,
      'totalAmount': instance.totalAmount,
    };
