import '../../../bluetooth_v2.dart';
import '../accu_chek_ops/accu_chek_ops_cubit.dart';

class AccuChekPairCubit extends Cubit<bool?> {
  AccuChekPairCubit(this.accuChekPairUseCase, this.accuChekOpsCubit)
      : super(null);
  final AccuChekPairUseCase accuChekPairUseCase;
  final AccuChekOpsCubit accuChekOpsCubit;

  bool lock = false;
  void pairDevice(DeviceEntity device) {
    if (!lock) {
      lock = true;
      final accuChek = accuChekPairUseCase.call(DeviceParams(device: device));
      accuChek.fold(
        (l) {
          emit(false);
        },
        (r) async {
          final accuChekResult = await r;
          if (accuChekResult) {
            emit(true);
            accuChekOpsCubit.readData(device);
          } else {
            emit(false);
          }
        },
      );
    }
  }
}
