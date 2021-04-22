import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'auth_mode_state.dart';

class AuthModeCubit extends Cubit<AuthModeState> {
  AuthModeCubit() : super(AuthModeLogIn());

  void changeAuthState() {
    if (state is AuthModeLogIn)
      emit(AuthModeSignUp());
    else
      emit(AuthModeLogIn());
  }
}
