import 'package:guven_service/guven_service.dart';
import 'package:scale_health_impl/scale_health_impl.dart';
import 'package:scale_hive_impl/scale_hive_impl.dart';

class ScaleRepository {
  final GuvenService _guvenService;
  final ScaleHiveImpl _scaleHiveImpl;
  final ScaleHealthImpl _scaleHealthImpl;

  ScaleRepository(
    this._guvenService,
    this._scaleHiveImpl,
    this._scaleHealthImpl,
  );
}
