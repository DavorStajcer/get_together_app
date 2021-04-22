import 'package:get_together_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/usecases/usecase.dart';
import 'package:get_together_app/features/authentication/domain/repository/user_repository.dart';
import 'package:get_together_app/features/authentication/presentation/models/auth_param.dart';

class LogUserIn extends Usecase<Success, AuthenticationParameters> {
  final UserAuthRepository userAuthRepository;

  LogUserIn(this.userAuthRepository);

  @override
  Future<Either<Failure, Success>> call(
      AuthenticationParameters parameters) async {
    return await userAuthRepository.logIn(parameters);
  }
}
