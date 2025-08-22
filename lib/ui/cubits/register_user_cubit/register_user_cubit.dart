import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/data/models/my_user_model.dart';
import 'package:flutter_starter_kit/ui/blocs/blocs.dart';
import 'package:flutter_starter_kit/ui/shared/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final UserBloc userBloc;
  RegisterUserCubit(this.userBloc) : super(RegisterUserState());

  bool onSubmit() {
    _touchEveryField();
    if (!state.isValid) return false;

    final Map<String, dynamic> data = {
      "first_name": state.firstName.value,
      "last_name": state.lastName.value,
      "date_birth": state.dateBirth.value,
    };

    userBloc.registerUser(MyUserModel.fromJson(data));

    return state.isValid;
  }

  void firstNameChanged(String value) {
    final firstName = TextInput.dirty(value: value);
    emit(state.copyWith(
      firstName: firstName,
      isValid: Formz.validate([firstName]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = TextInput.dirty(value: value);
    emit(state.copyWith(
      lastName: lastName,
      isValid: Formz.validate([lastName]),
    ));
  }

  void dateBirthChanged(DateTime value) {
    final dateBirth = Date.dirty(value: value);
    emit(state.copyWith(
      dateBirth: dateBirth,
      isValid: Formz.validate([dateBirth]),
    ));
  }

  void _touchEveryField() {
    final firstName = TextInput.dirty(value: state.firstName.value);
    final lastName = TextInput.dirty(value: state.lastName.value);
    final dateBirth = Date.dirty(value: state.dateBirth.value);

    emit(state.copyWith(
      firstName: firstName,
      lastName: lastName,
      dateBirth: dateBirth,
      isValid: Formz.validate([firstName, lastName, dateBirth]),
    ));
  }
}
