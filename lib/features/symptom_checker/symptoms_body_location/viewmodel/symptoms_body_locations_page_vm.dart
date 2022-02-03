import 'dart:async';

import 'package:file/local.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class SymptomsBodyLocationsVm extends ChangeNotifier {
  BuildContext? mContext;
  List<GetBodyLocationResponse>? bodyLocations;
  GetBodyLocationResponse? selectedBodyLocation;
  LoadingProgress? progress;
  int? selectedBodyId;
  bool? isBodySelected = false;
  ValueNotifier<Offset>? notifier;

  SymptomsBodyLocationsVm({
    BuildContext? context,
    ValueNotifier<Offset>? notifierFromPage,
    int? selectedGenderIdFromPage,
    String? yearOfBirth,
  }) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      notifier = notifierFromPage!;
      await fetchBodyLocations();
    });
  }

  //Kullanıcının seçtiği veriyi hazır hale getiriyor.
  selectedBodyLocationFetch(GetBodyLocationResponse? bodyLoc) async {
    selectedBodyLocation = bodyLoc;
    notifyListeners();
  }

  GetBodyLocationResponse? getLocationsName(int id) {
    for (var location in bodyLocations!) {
      if (location.id == id) {
        return location;
      }
    }
  }

  //Vücut bölgelerini gösteren yapıyı çeken method.
  fetchBodyLocations() async {
    progress = LoadingProgress.loading;
    notifyListeners();

    try {
      List<GetBodyLocationResponse> bodyLocations =
          await getIt<SymptomRepository>().getBodyLocations();
      bodyLocations = bodyLocations;
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      print(e);
      progress = LoadingProgress.error;
      notifyListeners();
    }
  }
}
