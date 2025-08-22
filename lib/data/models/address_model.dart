import 'package:flutter_starter_kit/domain/entities/address.dart';

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
