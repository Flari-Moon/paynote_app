import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'Language.g.dart';

@JsonSerializable()
class Language {
  String id;

  String userId;
  String deviceToken;

  String language;

  Language({this.userId, this.id, this.language, this.deviceToken});

  @override
  String toString() {
    return '[{"language":"$language"}]';
  }

  factory Language.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
