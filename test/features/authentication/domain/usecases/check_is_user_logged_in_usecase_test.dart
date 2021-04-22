/* import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/core/error/failure.dart';

import 'package:get_together_app/features/authentication/domain/repository/user_repository.dart';
import 'package:get_together_app/features/authentication/domain/usecases/listen_to_auth_state_changes.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';
import 'package:mockito/mockito.dart';

class UserRepositoryMock extends Mock implements UserAuthRepository {}

void main() {
  UserRepositoryMock userRepositoryMock;
  CheckIsUserLoggedInUsecase checkIsUserLoggedInUsecase;

  setUp(() {
    userRepositoryMock = UserRepositoryMock();
    checkIsUserLoggedInUsecase = CheckIsUserLoggedInUsecase(userRepositoryMock);
  });

  group("no errors", () {
    test("should return true when user is logged in and call user repo method",
        () async {
      when(userRepositoryMock.checkIsAuthenticated())
          .thenAnswer((realInvocation) async => Right(true));

      final response = await checkIsUserLoggedInUsecase(NoParameters());

      expect(response, Right(true));
      verify(userRepositoryMock.checkIsAuthenticated());
    });
    test(
        "should return false when user is not logged in and call user repo method",
        () async {
      when(userRepositoryMock.checkIsAuthenticated())
          .thenAnswer((realInvocation) async => Right(false));

      final response = await checkIsUserLoggedInUsecase(NoParameters());

      expect(response, Right(false));
      verify(userRepositoryMock.checkIsAuthenticated());
    });
  });
  group("error", () {
    test("should return ServerFailure when repository returns it", () async {
      when(userRepositoryMock.checkIsAuthenticated())
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final response = await checkIsUserLoggedInUsecase(NoParameters());

      expect(response, Left(ServerFailure()));
      verify(userRepositoryMock.checkIsAuthenticated());
    });
    test("should return CasheFailure when repository returns it", () async {
      when(userRepositoryMock.checkIsAuthenticated())
          .thenAnswer((realInvocation) async => Left(CashFailure()));

      final response = await checkIsUserLoggedInUsecase(NoParameters());

      expect(response, Left(CashFailure()));
      verify(userRepositoryMock.checkIsAuthenticated());
    });
  });
}
 */