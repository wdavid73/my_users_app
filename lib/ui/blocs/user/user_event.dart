part of 'user_bloc.dart';

class UserEvent {}

class RegisterUserEvent extends UserEvent {
  final MyUserModel user;
  RegisterUserEvent({required this.user});
}

class RegisterAddressEvent extends UserEvent {
  final List<AddressModel> address;
  RegisterAddressEvent({required this.address});
}
