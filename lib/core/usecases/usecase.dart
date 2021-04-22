import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/failure.dart';

abstract class Usecase<T, P> {
  Future<Either<Failure, T>> call(P param);
}

abstract class Param {}
