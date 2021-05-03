import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/error/success.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network.dart/network_info.dart';
import '../../domain/repository/user_repository.dart';
import '../../presentation/models/auth_param.dart';

class UserAuthRepositoryImpl extends UserAuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;

  UserAuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseStorage? firebaseStorage,
    FirebaseFirestore? firebaseFirestore,
    required this.networkInfo,
  })   : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Stream<User?> listenToAuthStream() {
    return firebaseAuth.authStateChanges();
  }

  @override
  Future<Either<Failure, Success>> logIn(LogInParameters parameters) async {
    if (await networkInfo.isConnected) {
      try {
        print("authenticating");
        await firebaseAuth.signInWithEmailAndPassword(
            email: parameters.email, password: parameters.password);

        return Right(Success());
      } on FirebaseAuthException catch (e) {
        print(e.message);
        return Left(AuthenticationFailure(_mapExceptionCodeToMessage(e.code)));
      }
    } else
      return Left(NetworkFailure("Network error. Check your connection."));
  }

  @override
  Future<Either<Failure, Success>> signUp(SignUpParameters parameters) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: parameters.email, password: parameters.password);

        return Right(Success());
      } on FirebaseAuthException catch (e) {
        return Left(AuthenticationFailure(_mapExceptionCodeToMessage(e.code)));
      }
    } else
      return Left(NetworkFailure("Network error. Check your connection."));
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseAuth.signOut();

        return Right(Success());
      } on FirebaseAuthException catch (e) {
        return Left(AuthenticationFailure(_mapExceptionCodeToMessage(e.code)));
      }
    } else
      return Left(NetworkFailure("Network error. Check your connection."));
  }

  String _mapExceptionCodeToMessage(String? exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case "account-exists-with-different-credential":
        errorMessage = "Wrong password for the email.";
        break;
      case "ERROR_INVALID_EMAIL":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = exceptionCode!;
    }
    return errorMessage;
  }
}
