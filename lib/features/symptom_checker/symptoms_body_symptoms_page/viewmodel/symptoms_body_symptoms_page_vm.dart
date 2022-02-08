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

  BodySymptomSelectionVm(
      {BuildContext? context,
      required int genderId,
      List<GetBodySymptomsResponse>? symptomList,
      bool? accessedFromSubLocationPage,
      required String year_of_birth,
      bool? isFromVoice,
      BodySublocationsVm? myPv}) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      myPv = myPv;
      isFromVoice = isFromVoice;
      await fetchBodySymptoms(symptomList);
      await fetchProposedSymptoms(
          selectedBodySymptoms, genderId, year_of_birth);
    });
  }

  //Symptom equalizer
  fetchBodySymptoms(List<GetBodySymptomsResponse>? symptomsList) async {
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

  fetchProposedSymptoms(List<GetBodySymptomsResponse>? symptoms, int? gender,
      String? year_of_birth) async {
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
              year_of_birth!);
      proposedSymptomList = proposedSymptoms;
      proposedProgress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.i(e);
      proposedProgress = LoadingProgress.error;
      notifyListeners();
    }
  }

  removeSemptomFromList(GetBodySymptomsResponse symptom) async {
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

  addSemptomToList(GetBodySymptomsResponse symptom) async {
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
}
