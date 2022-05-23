import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../model/treatment_model.dart';

class TreatmentEditVm extends ChangeNotifier {
  TreatmentModel selectedModel;
  late String patientName;
  TreatmentEditVm(this.selectedModel) {
    patientName = getIt<ProfileStorageImpl>().getFirst().name ?? 'Name';
  }


   final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

  save(String treatment) async {
    await getIt<ChronicTrackingRepository>()
        .addTreatment(getIt<ProfileStorageImpl>().getFirst(), treatment);
    var profiles = await getIt<ChronicTrackingRepository>().getAllProfiles();
    if (profiles.isNotEmpty) {
      getIt<ProfileStorageImpl>().updateFromTreatment(
        profiles.last,
      );
    }
    Atom.historyBack();
  }
}
