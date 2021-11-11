import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SymptomsHomeVm extends ChangeNotifier {
  BuildContext mContext;
  LoadingProgress _progress = LoadingProgress.LOADING;
  String _tokenOfSymptom;
  int _genderIdHolder;
  String _yearOfBirth = '2000';
  String _resultOfTts;
  bool selectionsIsCompleted = false;

  SymptomsHomeVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchSymptomToken();
    });
  }

  LoadingProgress get progress => this._progress;
  String get tokenOfSymptom => this._tokenOfSymptom;
  int get genderIdHolder => this._genderIdHolder ?? 0;
  String get yearOfBirth => this._yearOfBirth ?? '2000';
  String get resultOfTts => this._resultOfTts ?? "Nope";

  // Kullanıcının vücut bölgelerini seçtikten sonra karşısına çıkan radiobutton seçeneklerini handle eden fonksiyon
  void fetchGenderSelection(int genderId) async {
    this._genderIdHolder = genderId;
    notifyListeners();
  }

  // Doğum yılı handle metodu
  void yearOfBirthHandle(String year, int genderIdHld) {
    this._yearOfBirth = year;
    if (DateTime.now().year - int.parse(year) < 18) {
      this._genderIdHolder = genderIdHld == 0 || genderIdHld == 2 ? 2 : 3;
    } else {
      this._genderIdHolder = genderIdHld == 2 || genderIdHld == 0 ? 0 : 1;
    }
    notifyListeners();
  }

  //Token generator fonksiyon
  Future<void> fetchSymptomToken() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      this._tokenOfSymptom =
          (await getIt<SymptomRepository>().getSymtptomsApiToken()).token;
      getIt<ISharedPreferencesManager>().setString(
          SharedPreferencesKeys.SYMPTOM_AUTH_TOKEN, this._tokenOfSymptom);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      this._progress = LoadingProgress.ERROR;
      print(e);
      notifyListeners();
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
