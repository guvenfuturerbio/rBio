import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';

class BodySymptomSelectionVm extends ChangeNotifier {
  late BuildContext mContext;
  late List<GetBodySymptomsResponse> tmpSelectedSymptoms = [];
  late List<GetBodySymptomsResponse> selectedBodySymptoms = [];
  late List<GetBodySymptomsResponse> proposedSymptomList = [];
  late List<String> proposedSymptomsNamesList = [];
  late List<String> selectedBodySymptomNamesList = [];
  late LoadingProgress progress;
  late LoadingProgress proposedProgress = LoadingProgress.loading;
  late BodySublocationsVm myPv;
  late String propSymp;
  late bool isFromVoice;

  late int removeIndexHolder;

  BodySymptomSelectionVm({
    BuildContext? context,
    required int genderId,
    List<GetBodySymptomsResponse>? symptomList,
    bool? accessedFromSubLocationPage,
    required String yearOfBirth,
    bool? isFromVoice,
    BodySublocationsVm? myPv,
  }) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      myPv = myPv;
      isFromVoice = isFromVoice;
      await fetchBodySymptoms(symptomList);
      await fetchProposedSymptoms(selectedBodySymptoms, genderId, yearOfBirth);
    });
  }

  //Symptom equalizer
  Future<void> fetchBodySymptoms(
      List<GetBodySymptomsResponse>? symptomsList) async {
    try {
      symptomsList?.forEach((element) {
        if (!selectedBodySymptoms.contains(element)) {
          selectedBodySymptoms.add(element);
        }
      });
      //this._selectedBodySymptoms = symptomsList;
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.i(e);
      notifyListeners();
    }
  }

  Future<void> fetchProposedSymptoms(
    List<GetBodySymptomsResponse>? symptoms,
    int? gender,
    String? yearOfBirth,
  ) async {
    proposedProgress = LoadingProgress.loading;
    notifyListeners();
    try {
      List<int> tmpSymptomIdHolder = [];
      for (var element in symptoms!) {
        tmpSymptomIdHolder.add(element.id!);
      }
      List<GetBodySymptomsResponse> proposedSymptoms =
          await getIt<SymptomRepository>().getProposedSymptoms(
        tmpSymptomIdHolder.toString(),
        gender == 0 || gender == 2 ? 'male' : 'female',
        yearOfBirth!,
      );
      proposedSymptomList = changeNamesOfSymps(proposedSymptoms);
      proposedProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.i(e);
      proposedProgress = LoadingProgress.error;
      notifyListeners();
    }
  }

  Future<void> removeSemptomFromList(GetBodySymptomsResponse symptom) async {
    selectedBodySymptomNamesList.clear();
    tmpSelectedSymptoms = selectedBodySymptoms;
    if (tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.remove(symptom);
    }
    if (tmpSelectedSymptoms.isNotEmpty) {
      for (var element in tmpSelectedSymptoms) {
        selectedBodySymptomNamesList.add(element.name!.toLowerCase());
      }
    }
    selectedBodySymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  Future<void> addSemptomToList(GetBodySymptomsResponse symptom) async {
    selectedBodySymptomNamesList.clear();
    tmpSelectedSymptoms = selectedBodySymptoms;
    if (!tmpSelectedSymptoms.contains(symptom)) {
      tmpSelectedSymptoms.add(symptom);
    }
    for (var element in tmpSelectedSymptoms) {
      selectedBodySymptomNamesList.add(element.name!.toLowerCase());
    }
    selectedBodySymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  List<GetBodySymptomsResponse> changeNamesOfSymps(
      List<GetBodySymptomsResponse> bodySymps) {
    for (var element in bodySymps) {
      if (element.id == 996) {
        element.name = "Ayak bile??inde ??ekil bozuklu??u";
      } else if (element.id == 997) {
        element.name = "Ayak parma????nda ??ekil bozuklu??u";
      } else if (element.id == 25) {
        element.name = "Deride yumru (Nod??l)";
      } else if (element.id == 128) {
        element.name = "Zaman ve yer konusunda kar??????kl??k";
      } else if (element.id == 994) {
        element.name = "Dizde ??ekil bozuklu??u";
      } else if (element.id == 172) {
        element.name = "??drar yollar??nda ak??nt??";
      } else if (element.id == 72) {
        element.name = "I????k halkalar?? g??rmek";
      } else if (element.id == 993) {
        element.name = "Kal??ada ??ekil bozuklu??u";
      } else if (element.id == 995) {
        element.name = "Parmakta ??ekil bozuklu??u";
      } else if (element.id == 191) {
        element.name = "Kar??na bast??r??p ??ekince a??r??";
      } else if (element.id == 983) {
        element.name = "Sabah kat??l??????";
      } else if (element.id == 998) {
        element.name = "S??rtta ??ekil bozuklu??u";
      }
    }
    return bodySymps;
  }
}
