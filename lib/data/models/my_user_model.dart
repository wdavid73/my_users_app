import 'package:my_users_app/domain/entities/my_user.dart';

class MyUserModel extends MyUser {
  const MyUserModel({
    required super.firstName,
    required super.lastName,
    required super.dateBirth,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    // Handle both DateTime and String date formats
    final dateBirth = json["date_birth"] is DateTime
        ? json["date_birth"] as DateTime
        : DateTime.parse(json["date_birth"] as String);

    return MyUserModel(
      firstName: json["first_name"] as String,
      lastName: json["last_name"] as String,
      dateBirth: dateBirth,
    );
  }

  String get fullName => "$firstName $lastName";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          dateBirth == other.dateBirth;

  @override
  int get hashCode => Object.hash(firstName, lastName, dateBirth);
}
