import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_videos/src/model/loggedin_response.dart';
import 'package:flutter_videos/src/webservice/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CommonRepo _commonRepo;

  AuthBloc(this._commonRepo) : super(AuthLoading()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      LoggedInResponse? result =
          await _commonRepo.loginVendor(event.email!, event.password!);
      if (result != null && result.message! == 'Successfully Logged In') {
        emit(AuthSuccessful());
      }
      if (result == null || result.message! != 'Successfully Logged In') {
        emit(AuthError("Missing password OR  user not found"));
      }
    });
  }
}
