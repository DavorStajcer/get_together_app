import 'package:get_together_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/usecases/usecase.dart';
import 'package:get_together_app/features/authentication/domain/repository/user_repository.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_check_bloc/authentication_check_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

class ListenToAuthStateChanges {
  final UserAuthRepository userRepository;

  ListenToAuthStateChanges(this.userRepository);

  void call(AuthenticationCheckBloc authenticationCheckBloc) {
    userRepository.listenToAuthStream().listen((user) {
      authenticationCheckBloc.add(AuthStateChanged(Right(user)));
    }, onError: (e) {
      authenticationCheckBloc.add(AuthStateChanged(Left(ServerFailure())));
    });
  }
}
