import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/data/models/address_model.dart';
import 'package:flutter_starter_kit/ui/blocs/user/user_bloc.dart';

part 'manage_address_state.dart';

class ManageAddressCubit extends Cubit<ManageAddressState> {
  final UserBloc userBloc;
  ManageAddressCubit(this.userBloc) : super(ManageAddressState());

  bool saveAddress() {
    bool isValid = validateAddress();

    if (isValid == false) return false;
    userBloc.registerAddress(state.address);
    return true;
  }

  void registerAddress(String name) {
    final AddressModel addressModel = AddressModel(name: name);
    final List<AddressModel> addresses = List.from(state.address);
    addresses.add(addressModel);
    emit(state.copyWith(address: addresses));
  }

  void removeAddress(int index) {
    final List<AddressModel> addresses = List.from(state.address);
    addresses.removeAt(index);
    emit(state.copyWith(address: addresses));
  }

  bool validateAddress() {
    final int addressTotal = state.address.length;

    if (addressTotal < 1) {
      return false;
    }

    return true;
  }
}
