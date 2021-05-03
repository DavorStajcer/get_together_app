//@dart=2.6

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/authentication/data/datasources/local_datasource.dart';

import 'package:get_together_app/features/authentication/data/repositories/user_repository_impl.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

import 'package:mockito/mockito.dart';

class LocalDatasourceMock extends Mock implements LocalDatasource {}

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class FirebaseStorageMock extends Mock implements FirebaseStorage {}

class NetworkInfoMock extends Mock implements NetworkInfo {}

class UserMock extends Mock implements User {}

class UserCredentialsMock extends Mock implements UserCredential {}

void main() {
  //LocalDatasourceMock localDatasourceMock;
  FirebaseAuthMock firebaseAuthMock;
  FirebaseFirestoreMock firebaseFirestoreMock;
  FirebaseStorageMock firebaseStorageMock;

  UserCredentialsMock userCredentialsMock;
  NetworkInfoMock networkInfoMock;
  UserAuthRepositoryImpl userRepositoryImpl;
  String tUserEmal;
  String tUserPassword;
  String tUserUsername;
  String tPath;
  File tImge;
  LogInParameters tLogInParam;
  SignUpParameters tSignUpParam;

  setUp(() {
    firebaseAuthMock = FirebaseAuthMock();
    firebaseStorageMock = FirebaseStorageMock();
    firebaseFirestoreMock = FirebaseFirestoreMock();
    userCredentialsMock = UserCredentialsMock();
    networkInfoMock = NetworkInfoMock();
    userRepositoryImpl = UserAuthRepositoryImpl(
      firebaseAuth: firebaseAuthMock,
      firebaseFirestore: firebaseFirestoreMock,
      firebaseStorage: firebaseStorageMock,
      networkInfo: networkInfoMock,
    );
    tUserEmal = "testEmail";
    tUserPassword = "testPassword";
    tUserUsername = "testUsername";
    tPath = "testPath";
    tImge = File(tPath);
    tLogInParam = LogInParameters(email: tUserEmal, password: tUserPassword);
    tSignUpParam = SignUpParameters(
        email: tUserEmal,
        password: tUserPassword,
        username: tUserUsername,
        image: tImge);
  });

  group("no errors", () {
    setUp(() {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => true);
    });

    group("logIn", () {
      setUp(() {
        when(firebaseAuthMock.signInWithEmailAndPassword(
                email: tUserEmal, password: tUserPassword))
            .thenAnswer(((realInvocation) async => userCredentialsMock));
      });

      test("should return sucsess", () async {
        final response = await userRepositoryImpl.logIn(tLogInParam);
        expect(response, Right(Success()));
        verify(firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });
    group("signUp", () {
      test("should return sucsess when successfull", () async {
        when(firebaseAuthMock.createUserWithEmailAndPassword(
                email: tUserEmal, password: tUserPassword))
            .thenAnswer(((realInvocation) async => userCredentialsMock));
        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response, Right(Success()));
        verify(firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });
  });

  group("errors", () {
    group("logIn", () {
      test("should return AuthenticationFailure when failed to logIn",
          () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => true);
        when(firebaseAuthMock.signInWithEmailAndPassword(
                email: tUserEmal, password: tUserPassword))
            .thenThrow(FirebaseAuthException(code: "exception"));

        final response = await userRepositoryImpl.logIn(tLogInParam);
        expect(response, Left(AuthenticationFailure("exception")));
        verify(firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });
    });

    group("signUp", () {
      test("should return AuthenticationFailure when failed to signIn",
          () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => true);
        when(firebaseAuthMock.createUserWithEmailAndPassword(
                email: tUserEmal, password: tUserPassword))
            .thenThrow(FirebaseAuthException(code: "exception"));

        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response, Left(AuthenticationFailure("exception")));
        verify(firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword));
      });

      test("should return NetworkFaiulre when no conncetion", () async {
        when(networkInfoMock.isConnected)
            .thenAnswer((realInvocation) async => false);

        final response = await userRepositoryImpl.signUp(tSignUpParam);
        expect(response,
            Left(NetworkFailure("Network error. Check your connection.")));
        verify(networkInfoMock.isConnected);
        verifyZeroInteractions(firebaseAuthMock);
      });
    });
  });
}
