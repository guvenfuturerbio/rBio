import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SymptomsHomeVm extends ChangeNotifier {
  BuildContext? mContext;
  LoadingProgress? progress = LoadingProgress.loading;
  String? tokenOfSymptom;
  int? genderIdHolder = 0;
  String? yearOfBirth = '2000';
  bool? selectionsIsCompleted = false;

  SymptomsHomeVm({BuildContext? context}) {
    mContext = context!;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchSymptomToken();
    });
  }

  // Kullanıcının vücut bölgelerini seçtikten sonra karşısına çıkan radiobutton seçeneklerini handle eden fonksiyon
  void fetchGenderSelection(int genderId) async {
    genderIdHolder = genderId;
    notifyListeners();
  }

  // Doğum yılı handle metodu
  void yearOfBirthHandle(String year, int genderIdHld) {
    yearOfBirth = year;
    if (DateTime.now().year - int.parse(year) < 18) {
      genderIdHolder = genderIdHld == 0 || genderIdHld == 2 ? 2 : 3;
    } else {
      genderIdHolder = genderIdHld == 2 || genderIdHld == 0 ? 0 : 1;
    }
    notifyListeners();
  }

  //Token generator fonksiyon
  Future<void> fetchSymptomToken() async {
    progress = LoadingProgress.loading;
    notifyListeners();

    try {
      tokenOfSymptom =
          (await getIt<SymptomRepository>().getSymtptomsApiToken()).token;
      getIt<ISharedPreferencesManager>()
          .setString(SharedPreferencesKeys.symtomAuthToken, tokenOfSymptom!);
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      progress = LoadingProgress.error;
      LoggerUtils.instance.i(e);
      notifyListeners();
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.ok,
        );
      },
    );
  }
}
