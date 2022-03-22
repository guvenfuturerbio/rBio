import 'package:dartz/dartz.dart';

import 'failures.dart';

abstract class UseCase<Type, Params> {
  Either<BluetoothFailures, Type> call(Params params);
}

abstract class FutureUseCase<Type, Params> {
  Future<Either<BluetoothFailures, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<BluetoothFailures, Type>> call(Params params);
}

class NoParams {}
