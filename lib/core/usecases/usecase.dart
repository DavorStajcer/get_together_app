import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failure.dart';

abstract class Usecase<T, P> {
  Future<Either<Failure, T>> call(P param);
}

class NoParameters extends Equatable {
  @override
  List<Object> get props => [];
}
