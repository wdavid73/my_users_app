part of 'manage_address_cubit.dart';

class ManageAddressState extends Equatable {
  final List<AddressModel> address;

  const ManageAddressState({
    this.address = const [],
  });

  @override
  List<Object> get props => [
        address,
      ];

  ManageAddressState copyWith({List<AddressModel>? address}) =>
      ManageAddressState(
        address: address ?? this.address,
      );
}
