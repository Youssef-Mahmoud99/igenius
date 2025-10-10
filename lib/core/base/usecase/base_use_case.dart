import 'package:dartz/dartz.dart';

import '../../error/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

abstract class PaginationUseCase<Type, Params> {
  Future<Either<Failure, dynamic>> call(Params params);
}

class NoParams {
  const NoParams();
}