part of 'user_bloc.dart';

class UserState extends Equatable {
  final MyUserModel? user;
  final List<AddressModel> address;
  const UserState({
    this.user,
    this.address = const [],
  });

  UserState copyWith({
    MyUserModel? user,
    List<AddressModel>? address,
  }) =>
      UserState(
        user: user ?? this.user,
        address: address ?? this.address,
      );

  @override
  List<Object?> get props => [
        address,
        user,
      ];
}
