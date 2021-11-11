import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/model/model.dart';

class SymptomsResultPageVm extends ChangeNotifier {
  BuildContext mContext;
  LoadingProgress _progress;
  List<GetSpecialisationsResponse> _specialisations;
  int _toNavigateDoctorsPageId;
  String specialisationsSentence = "";
  String customPath = "";

  bool hasRequest = false;
  bool _isReadyToContinue = false;
  bool _isRecordStart = false;

  //Timer
  final dur = const Duration(seconds: 1);
  Stopwatch swatch = Stopwatch();
  bool isStart = false;
  bool isSaved = false;

  SymptomsResultPageVm(
      {BuildContext context,
      List<GetBodySymptomsResponse> selectedSymptoms,
      String gender,
      String year_of_birth,
      bool isFromVoice}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchSpecialisations(selectedSymptoms, gender, year_of_birth);
      await loadJsonData();
    });
  }

  bool get isReadyToContinue => this._isReadyToContinue;
  bool get isRecordStart => this._isRecordStart;

  LoadingProgress get progress => this._progress;

  List<GetSpecialisationsResponse> get specialisations =>
      this._specialisations ?? [];
  int get toNavigateDoctorsPageId => this._toNavigateDoctorsPageId;

  fetchSpecialisations(List<GetBodySymptomsResponse> symptoms, String gender,
      String year_of_birth) async {
    List<int> symptomsIds = [];
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      for (var element in symptoms) {
        symptomsIds.add(element.id);
      }
      List<GetSpecialisationsResponse> specialisations =
          await getIt<SymptomRepository>().getSpeacialisations(
              symptomsIds.toString(), gender, year_of_birth, R.bodyDatas.json);
      this._specialisations = specialisations;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/departments.json');
    var responseBody = jsonDecode(jsonText);
  }
}
