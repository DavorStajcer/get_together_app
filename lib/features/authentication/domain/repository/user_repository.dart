import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_check_bloc/authentication_check_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, Success>> logIn(LogInParameters parameters);
  Future<Either<Failure, Success>> signUp(SignUpParameters parameters);
  Stream<User> listenToAuthStream();
  Future<Either<Failure, Success>> signOut();
}
