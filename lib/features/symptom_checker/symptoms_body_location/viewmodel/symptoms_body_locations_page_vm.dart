import 'dart:async';

import 'package:file/local.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class SymptomsBodyLocationsVm extends ChangeNotifier {
  BuildContext mContext;
  List<GetBodyLocationResponse> _bodyLocations;
  GetBodyLocationResponse _selectedBodyLocation;
  LoadingProgress _progress;
  int _selectedBodyId;
  bool isBodySelected = false;

  //Recorder variables
  LocalFileSystem _localFileSystem;
  bool hasRequest = false;
  ValueNotifier<Offset> _notifier;
  bool isFromVoice;
  bool hasPerms = false;

  //decibel meter
  bool _isRecording = false;
  Timer timerForDecibel;

  //Timer
  final dur = const Duration(seconds: 1);
  Stopwatch swatch = Stopwatch();
  bool isStart = false;
  bool isSaved = false;

  SymptomsBodyLocationsVm({
    BuildContext context,
    bool isFromVoice,
    ValueNotifier<Offset> notifierFromPage,
    int selectedGenderIdFromPage,
    String yearOfBirth,
  }) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this._notifier = notifierFromPage;
      this.isFromVoice = isFromVoice;
      await fetchBodyLocations();
    });
  }

  List<GetBodyLocationResponse> get bodyLocations => this._bodyLocations ?? [];

  GetBodyLocationResponse get selectedBodyLocation =>
      this._selectedBodyLocation;
  LoadingProgress get progress => this._progress;
  int get selectedBodyId => this._selectedBodyId;
  set selectedBodyId(int id) => this._selectedBodyId = id;
  LocalFileSystem get localFileSystem =>
      this._localFileSystem ?? LocalFileSystem();
  bool get isRecording => this._isRecording;
  ValueNotifier<Offset> get notifier => this._notifier;

  //Kullanıcının seçtiği veriyi hazır hale getiriyor.
  selectedBodyLocationFetch(GetBodyLocationResponse bodyLoc) async {
    this._selectedBodyLocation = bodyLoc;
    notifyListeners();
  }

  GetBodyLocationResponse getLocationsName(int id) {
    for (var location in bodyLocations) {
      if (location.id == id) {
        return location;
      }
    }
  }

  //Vücut bölgelerini gösteren yapıyı çeken method.
  fetchBodyLocations() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      List<GetBodyLocationResponse> bodyLocations =
          await getIt<SymptomRepository>().getBodyLocations();
      this._bodyLocations = bodyLocations;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }
}
