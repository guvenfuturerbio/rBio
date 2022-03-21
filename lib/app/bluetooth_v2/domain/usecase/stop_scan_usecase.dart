import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../repository/device_repository.dart';

class StopScanUseCase extends UseCase<void, NoParams> {
  final DeviceRepository repository;
  StopScanUseCase(this.repository);

  @override
  Either<Failure, void> call(NoParams params) {
    return repository.stopScan();
  }
}
