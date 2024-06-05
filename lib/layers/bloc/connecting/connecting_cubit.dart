import 'package:bloc/bloc.dart';
import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_instance.dart';
import 'package:careflix_parental_control/core/shared_preferences/shared_preferences_key.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../generated/l10n.dart';
import '../../../injection_container.dart';
import '../../data/repository/connection_repository.dart';

part 'connecting_state.dart';

class ConnectingCubit extends Cubit<ConnectingState> {
  ConnectingCubit() : super(ConnectingInitial());

  final _connectingRepo = sl<ConnectingRepository>();

  connect(String userID) async {
    emit(ConnectingLoading());
    try {
      final isUserExist = await _connectingRepo.checkIfUserExist(userID);
      if (isUserExist) {
        await SharedPreferencesInstance.pref
            .setString(SharedPreferencesKeys.UserId, userID);
        SharedPreferencesInstance.pref.setString(
            SharedPreferencesKeys.ConnectedDate, DateTime.now().toString());
        final isUserHasParentalControl =
            await _connectingRepo.checkIfUserHasParentalControl(userID);
        emit(ConnectingLoaded(hasParentalControl: isUserHasParentalControl));
      } else {
        emit(ConnectingError(error: "This QR code is invalid!"));
      }
    } catch (e) {
      emit(ConnectingError(error: S.current.thereIsAnError));
    }
  }
}
