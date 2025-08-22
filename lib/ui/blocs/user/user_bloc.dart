import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_users_app/data/models/address_model.dart';
import 'package:my_users_app/data/models/my_user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<RegisterUserEvent>((event, emit) {
      emit(state.copyWith(user: event.user));
    });

    on<RegisterAddressEvent>((event, emit) {
      emit(state.copyWith(address: event.address));
    });
  }
  void registerUser(MyUserModel user) {
    add(RegisterUserEvent(user: user));
  }

  void registerAddress(List<AddressModel> address) {
    add(RegisterAddressEvent(address: address));
  }
}
