// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BResponse _$BResponseFromJson(Map<String, dynamic> json) {
  return BResponse(
    status: json['status'] as int,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BResponseToJson(BResponse instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
