import 'package:dartz/dartz.dart';

import 'failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}
