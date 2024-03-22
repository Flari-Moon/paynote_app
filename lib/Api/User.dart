import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String phoneNumber;
  String countryCode;
  String firstName;
  String lastName;
  String dateOfBirth;
  String picture;
  String pinCode;
  String country;
  String email;
  String id;
  String createdAt;
  String updatedAt;
  String userId;
  String deviceToken;

  User(
      {this.userId,
      this.id,
      this.email,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.dateOfBirth,
      this.picture,
      this.pinCode,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.deviceToken});

  @override
  String toString() {
    /*if (typeOfRequest.contains("update")) {
            return ' {  "uuid": "$uuid", "pincode": "$pincode"}}';
        }
        else if (typeOfRequest.contains("get")) {
            return ' {  "phoneNumber": "$phoneNumber"}}';
        }
        else if (typeOfRequest.contains("set")) {*/
    return '[{"deviceToken": "$deviceToken","userId": "$userId","id": "$id","phoneNumber": "$phoneNumber", "countryCode": "$countryCode", "firstName": "$firstName", "lastName": "$lastName", "picture": "$picture", "email": "$email", "dateOfBirth": "$dateOfBirth"}]';
    /*  }
        else {
            return '"user" :{phoneNumber: $phoneNumber, countryCode: $countryCode, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, picture: $picture, uuid: $uuid, pincode: $pincode, country: $country, email: $email}';
        }*/
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
