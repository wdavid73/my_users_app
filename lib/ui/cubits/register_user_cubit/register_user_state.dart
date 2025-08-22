part of 'register_user_cubit.dart';

class RegisterUserState extends Equatable {
  final TextInput firstName;
  final TextInput lastName;
  final Date dateBirth;
  final bool isValid;

  const RegisterUserState({
    this.firstName = const TextInput.pure(),
    this.lastName = const TextInput.pure(),
    this.dateBirth = const Date.pure(),
    this.isValid = false,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        dateBirth,
        isValid,
      ];

  RegisterUserState copyWith({
    TextInput? firstName,
    TextInput? lastName,
    Date? dateBirth,
    bool? isValid,
  }) =>
      RegisterUserState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateBirth: dateBirth ?? this.dateBirth,
        isValid: isValid ?? this.isValid,
      );
}
