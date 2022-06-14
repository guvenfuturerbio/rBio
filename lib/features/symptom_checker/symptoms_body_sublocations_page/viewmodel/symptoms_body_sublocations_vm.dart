import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/features/symptom_checker/symptoms_result_page/model/get_body_symptoms_response.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class BodySublocationsVm extends ChangeNotifier {
  BuildContext? mContext;
  List<GetBodySublocationResponse?> bodySubLocations = [];
  GetBodySublocationResponse? selectedBodySubLocation;
  LoadingProgress progress = LoadingProgress.loading;
  LoadingProgress? symptomControl;
  List<ExpandableController> expControllerList = [];
  List<List<GetBodySymptomsResponse>?> allBodySymptoms = [];
  List<GetBodySymptomsResponse>? selectedSymptoms = [];
  List<GetBodySymptomsResponse>? tmpSelectedSymptoms = [];
  int? selectedGenderId;
  String? yearOfBirth;
  String? bodyLocNames = "";
  List<String> bodyLocNamesList = [];
  late GetBodyLocationResponse selectedBodyLocation;

  //Add and remove symptom variables for voice command
  bool didToggle = false;
  late int partIndexHolder;
  List<String> symptomNamesList = [];
  List<String> selectedPartSymptomList = [];

  BodySublocationsVm(
      {BuildContext? context,
      int? bodyLocationId,
      int? genderId,
      bool? isFromVoicePage,
      String? yearOfBirth,
      GetBodyLocationResponse? selectedBodyLocation}) {
    mContext = context!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchBodySubLocations(bodyLocationId!, genderId!);
      //initializeRecord();
      selectedGenderId = genderId;
      yearOfBirth = yearOfBirth;
      selectedBodyLocation = selectedBodyLocation;
    });
  }

  expControllerCreator() {
    List<ExpandableController> tmpList = [];
    for (int i = 0; i < bodySubLocations.length; i++) {
      //initialExpanded true olursa ExpandablePanel kapalı geliyor.
      tmpList.add(ExpandableController(initialExpanded: true));
    }
    expControllerList = tmpList;
  }

  disposeController() {
    for (var item in expControllerList) {
      item.dispose();
    }
  }

  //Vücudun alt bölgelerini çeken method.
  fetchBodySubLocations(int id, int genderId) async {
    progress = LoadingProgress.loading;
    notifyListeners();
    try {
      List<GetBodySublocationResponse> bodySubLocationsList =
          await getIt<SymptomRepository>().getBodySubLocations(id);
      bodySubLocations = bodySubLocationsList;
      progress = LoadingProgress.done;
      await expControllerCreator();
      notifyListeners();
      await fetchBodySymptoms(bodySubLocationsList, genderId);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.i(e);
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }

  //Vücudun semptomlarını çeken method.
  fetchBodySymptoms(
      List<GetBodySublocationResponse> subLocObjects, int genderId) async {
    symptomControl = LoadingProgress.loading;
    notifyListeners();
    try {
      List<List<GetBodySymptomsResponse>> tmpAllSymp = [];
      for (int i = 0; i < subLocObjects.length; i++) {
        List<GetBodySymptomsResponse> bodySymptoms =
            await getIt<SymptomRepository>()
                .getBodySymptoms(subLocObjects[i].id!, genderId);
        bodySymptoms = changeNamesOfSymps(bodySymptoms);
        tmpAllSymp.add(bodySymptoms);
      }
      allBodySymptoms = tmpAllSymp;
      symptomControl = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      symptomControl = LoadingProgress.error;
      notifyListeners();
      LoggerUtils.instance.i(e);
    }
  }

  addSemptomToList(GetBodySymptomsResponse symptom) async {
    if (!(tmpSelectedSymptoms?.contains(symptom) ?? false)) {
      tmpSelectedSymptoms?.add(symptom);
      if (symptom.hasRedFlag ?? false) {
        showGradientDialog(mContext!, LocaleProvider.current.emergency_lbl,
            LocaleProvider.current.emergency);
      }
    }
    selectedSymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  //Seçilen semptommları listeden silen metod.
  removeSemptomFromList(GetBodySymptomsResponse? symptom) async {
    if (tmpSelectedSymptoms?.contains(symptom) ?? false) {
      tmpSelectedSymptoms?.remove(symptom);
    }
    selectedSymptoms = tmpSelectedSymptoms;
    notifyListeners();
  }

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RbioMessageDialog(
            description: text,
            buttonTitle: LocaleProvider.current.ok,
          );
        });
  }

  List<GetBodySymptomsResponse> changeNamesOfSymps(
      List<GetBodySymptomsResponse> bodySymps) {
    for (var element in bodySymps) {
      if (element.id == 996) {
        element.name = "Ayak bileğinde şekil bozukluğu";
      } else if (element.id == 997) {
        element.name = "Ayak parmağında şekil bozukluğu";
      } else if (element.id == 25) {
        element.name = "Deride yumru (Nodül)";
      } else if (element.id == 128) {
        element.name = "Zaman ve yer konusunda karışıklık";
      } else if (element.id == 994) {
        element.name = "Dizde şekil bozukluğu";
      } else if (element.id == 172) {
        element.name = "İdrar yollarında akıntı";
      } else if (element.id == 72) {
        element.name = "Işık halkaları görmek";
      } else if (element.id == 993) {
        element.name = "Kalçada şekil bozukluğu";
      } else if (element.id == 995) {
        element.name = "Parmakta şekil bozukluğu";
      } else if (element.id == 191) {
        element.name = "Karına bastırıp çekince ağrı";
      } else if (element.id == 983) {
        element.name = "Sabah katılığı";
      } else if (element.id == 998) {
        element.name = "Sırtta şekil bozukluğu";
      }
    }
    return bodySymps;
  }
}
