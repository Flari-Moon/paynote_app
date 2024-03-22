// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$UserFromJson(Map<String, dynamic> json) {
  return Language(
    userId: json['userId'] as String,
    id: json['id'] as String,
    language: json['language'] as String,
    deviceToken: json['deviceToken'] as String,
  );
}

Map<String, dynamic> _$UserToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'userId': instance.userId,
      'deviceToken': instance.deviceToken,
    };
