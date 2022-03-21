import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/usecases.dart';
import '../entity/device_entity.dart';
import '../repository/device_repository.dart';

class SearchDeviceUseCase extends UseCase<void, SearchParams> {
  final DeviceRepository repository;
  SearchDeviceUseCase(this.repository);

  @override
  Either<Failure, Stream<List<DeviceEntity>>> call(SearchParams params) {
    return repository.searchDevices(params.searchTerms);
  }
}

class SearchParams {
  SearchParams({required this.searchTerms});
  final List<String> searchTerms;
}
