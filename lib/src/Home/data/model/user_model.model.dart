// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.email,
    required this.phoneNumber,
    required this.uid,
    required this.active,
  });

  final String? email;
  final String? phoneNumber;
  final String uid;
  final String active;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        phoneNumber: json["phone_number"],
        uid: json["uid"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone_number": phoneNumber,
        "uid": uid,
        "active": active,
      };
}
