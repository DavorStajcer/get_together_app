import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/features/authentication/domain/usecases/log_user_in.dart';
import 'package:get_together_app/features/authentication/domain/usecases/sign_user_in.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogUserIn logUserIn;
  final SignUserIn signUserIn;

  AuthBloc({
    @required this.logUserIn,
    @required this.signUserIn,
  }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading();
    Either<Failure, Success> response;
    log(event.toString());
    if (event is LogInEvent)
      response = await logUserIn(event.authParam);
    else
      response = await signUserIn((event as SignUpEvent).authParam);

    yield* _mapRepsonseToState(response);
  }

  Stream<AuthState> _mapRepsonseToState(
      Either<Failure, Success> response) async* {
    yield* response.fold((
      failure,
    ) async* {
      String errorMessage;
      if (failure is NetworkFailure) errorMessage = "Network failure";
      if (failure is AuthenticationFailure)
        errorMessage = failure.message;
      else
        errorMessage = "Error occured";
      yield AuthFailed(errorMessage);
    }, (
      success,
    ) async* {
      yield AuthSuccessfull();
    });
  }
}
