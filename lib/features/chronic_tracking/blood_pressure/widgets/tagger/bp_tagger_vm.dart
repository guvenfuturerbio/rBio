import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../model/model.dart';
import '../../viewmodel/bp_measurement_vm.dart';

class BpTaggerVm extends ChangeNotifier {
  final BuildContext context;
  BpMeasurementViewModel? bpModel;
  final bool? isManuel;
  final int? key;

  double height = 0;
  double width = 0;

  late ScrollController scrollController;
  late TextEditingController noteController,
      sysController,
      diaController,
      pulseController;

  BpTaggerVm({
    required this.context,
    this.bpModel,
    this.isManuel,
    this.key,
  }) {
    bpModel ??= BpMeasurementViewModel(
      bpModel: BloodPressureModel(
        isManual: isManuel,
        deviceUUID: '',
        dateTime: DateTime.now(),
      ),
    );

    scrollController = ScrollController();
    noteController = TextEditingController(text: bpModel?.note ?? '');
    sysController = TextEditingController(
        text: bpModel?.sys != null ? bpModel!.sys.toString() : '');
    diaController = TextEditingController(
        text: bpModel?.dia != null ? bpModel?.dia.toString() : '');
    pulseController = TextEditingController(
        text: bpModel?.pulse != null ? bpModel?.pulse.toString() : '');
  }

  void update() {
    getIt<BloodPressureStorageImpl>().update(bpModel!.bpModel, key);
    Atom.dismiss();
  }

  void save() {
    if (bpModel?.sys != null &&
        bpModel?.dia != null &&
        bpModel?.pulse != null) {
      getIt<BloodPressureStorageImpl>()
          .write(bpModel!.bpModel, shouldSendToServer: true);
      Atom.dismiss();
    }
  }

  changePulse(String pulse) {
    if (pulseController.text.isEmpty || pulseController.text[0] == '0') {
      bpModel!.pulse = null;
    } else {
      bpModel?.pulse = int.parse(pulseController.text);
    }
    notifyListeners();
  }

  changeSys(String sys) {
    LoggerUtils.instance.i(sys);
    if (sysController.text.isEmpty || sysController.text[0] == '0') {
      bpModel?.sys = null;
    } else {
      bpModel?.sys = int.parse(sysController.text);
    }
    notifyListeners();
  }

  changeDia(String dia) {
    LoggerUtils.instance.i(dia);
    if (diaController.text.isEmpty || diaController.text[0] == '0') {
      bpModel?.dia = null;
    } else {
      bpModel?.dia = int.parse(diaController.text);
    }
    notifyListeners();
  }

  void addNote(String text) {
    bpModel?.note = text;
    notifyListeners();
  }

  void changeDate(DateTime date) {
    bpModel?.date = date;
    notifyListeners();
  }
}
