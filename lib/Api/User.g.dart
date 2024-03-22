// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['userId'] as String,
    id: json['id'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    countryCode: json['countryCode'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    picture: json['picture'] as String,
    pinCode: json['pinCode'] as String,
    country: json['country'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    deviceToken: json['deviceToken'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth,
      'picture': instance.picture,
      'pinCode': instance.pinCode,
      'country': instance.country,
      'email': instance.email,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'userId': instance.userId,
      'deviceToken': instance.deviceToken,
    };
