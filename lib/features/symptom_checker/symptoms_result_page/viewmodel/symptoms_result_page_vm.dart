import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import '../../../../core/core.dart';
import '../../../../model/model.dart';

class SymptomsResultPageVm extends ChangeNotifier {
  BuildContext? mContext;
  LoadingProgress? progress;
  List<GetSpecialisationsResponse> specialisations = [];
  int? toNavigateDoctorsPageId;
  List<GetDepartmentIdResponse>? _data;
  String specialisationsSentence = "";
  String customPath = "";

  bool hasRequest = false;
  bool isReadyToContinue = false;
  bool isRecordStart = false;

  //Timer
  final dur = const Duration(seconds: 1);
  Stopwatch swatch = Stopwatch();
  bool isStart = false;
  bool isSaved = false;

  SymptomsResultPageVm(
      {BuildContext? context,
      List<GetBodySymptomsResponse>? selectedSymptoms,
      String? gender,
      String? year_of_birth,
      bool? isFromVoice}) {
    mContext = context;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchSpecialisations(selectedSymptoms!, gender!, year_of_birth!);
      await loadJsonData();
    });
  }

  fetchSpecialisations(List<GetBodySymptomsResponse> symptoms, String gender,
      String year_of_birth) async {
    List<int> symptomsIds = [];
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      if (symptoms.isNotEmpty) {
        for (var element in symptoms) {
          symptomsIds.add(element.id!);
        }
      } else {
        print("Symptoms null!");
      }
      List<GetSpecialisationsResponse> specialisations =
          await getIt<SymptomRepository>().getSpeacialisations(
              symptomsIds.toString(), gender, year_of_birth, R.bodyDatas.json);
      specialisations = specialisations;
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      print(e);
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }

  loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/departments.json');
    var responseBody = jsonDecode(jsonText);

    List<GetDepartmentIdResponse> departments = <GetDepartmentIdResponse>[];
    for (var data in responseBody) {
      departments.add(GetDepartmentIdResponse.fromJson(data));
    }
    _data = departments;
    notifyListeners();
  }

  loadNavigationData(int id) async {
    toNavigateDoctorsPageId =
        await navigateToDoctorsPage(departments: _data, id: id);
    //this._data = json.decode(jsonText);
    notifyListeners();
  }

  navigateToDoctorsPage(
      {List<GetDepartmentIdResponse>? departments, int? id}) async {
    try {
      late int resultId;
      departments?.forEach((element) {
        if (int.parse(element.apimedicId!) == id) {
          resultId = int.parse(element.id!);
        }
      });
      return resultId;
    } catch (e) {
      print(e);
    }
  }
}
