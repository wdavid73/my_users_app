import 'package:flutter_starter_kit/domain/entities/my_user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    required super.firstName,
    required super.lastName,
    required super.dateBirth,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> json) => MyUserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateBirth: json["date_birth"],
      );

  String get fullName => "$firstName $lastName";
}
