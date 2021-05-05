//@dart=2.6

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';
import 'package:mockito/mockito.dart';
import '../../../../firebase_mock/firebase_service.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

void main() {
  FirebaseService firebaseService;
  NetworkInfoMock networkInfoMock;
  UserAuthRepositoryImpl userRepositoryImpl;
  String tUserEmal;
  String tUserPassword;
  String tUserUsername;
  String tPath;
  File tImage;
  LogInParameters tLogInParam;
  SignUpParameters tSignUpParam;

  setUp(() {
    firebaseService = FirebaseService()
      ..setUpFirebaseFirestore()
      ..setUpFirebaseStorage()
      ..setUpFirebaseAuth();

    networkInfoMock = NetworkInfoMock();
    userRepositoryImpl = UserAuthRepositoryImpl(
      firebaseAuth: firebaseService.firebaseAuthMock,
      firebaseFirestore: firebaseService.firebaseFirestoreMock,
      firebaseStorage: firebaseService.firebaseStorageMock,
      networkInfo: networkInfoMock,
    );

    tUserEmal = "testEmail";
    tUserPassword = "testPassword";
    tUserUsername = "testUsername";
    tPath = "testPath";
    tImage = File(tPath);
    tLogInParam = LogInParameters(email: tUserEmal, password: tUserPassword);
    tSignUpParam = SignUpParameters(
        email: tUserEmal,
        password: tUserPassword,
        username: tUserUsername,
        image: tImage);
  });

  group("no errors", () {
    setUp(() {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => true);
    });

    group("logIn", () {
      setUp(() {
        firebaseService.setUpSuccessfullAuth(tUserEmal, tUserPassword);
      });
      test("should return sucsess", () async {
        final response = await userRepositoryImpl.logIn(tLogInParam);
        expect(response, Right(Success()));
        verify(firebaseService.firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });

    group("signUp", () {
      test("should return sucsess when successfull", () async {
        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response, Right(Success()));
        verify(firebaseService.firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });
  });

  group("errors", () {
    setUp(() {
      firebaseService.setUpFailedAuth(tUserEmal, tUserPassword);
    });

    group("logIn", () {
      test("should return AuthenticationFailure when failed to logIn",
          () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => true);

        final response = await userRepositoryImpl.logIn(tLogInParam);
        expect(response, Left(AuthenticationFailure("exception")));
        verify(firebaseService.firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });

    group("signUp", () {
      test("should return AuthenticationFailure when failed to signIn",
          () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => true);

        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response, Left(AuthenticationFailure("exception")));
        verify(firebaseService.firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });

      test("should return NetworkFaiulre when no conncetion", () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => false);

        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response,
            Left(NetworkFailure("Network error. Check your connection.")));
        verify(networkInfoMock.isConnected);
        verifyZeroInteractions(firebaseService.firebaseAuthMock);
      });
    });
  });
}
