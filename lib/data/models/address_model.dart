import 'package:my_users_app/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({required super.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
