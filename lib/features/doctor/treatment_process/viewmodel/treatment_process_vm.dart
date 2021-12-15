part of '../view/treatment_process_screen.dart';

class TreatmentProcessVm extends ChangeNotifier with RbioVm {
  @override
  BuildContext mContext;
  List<TreatmentProcessItemModel> list = [];

  LoadingProgress _progress;
  LoadingProgress get progress => _progress;
  set progress(LoadingProgress value) {
    _progress = value;
    notifyListeners();
  }

  TreatmentProcessVm({BuildContext context}) {
    this.mContext = context;

    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) {
        fetchAll();
      });
    }
  }

  Future<void> fetchAll() async {
    progress = LoadingProgress.LOADING;
    await Future.delayed(Duration(seconds: 1));
    list = <TreatmentProcessItemModel>[
      TreatmentProcessItemModel(
        id: '1',
        title: 'Görüntülü Görüşme',
        description:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh',
        dateTime: '01/01/2021 - 09:00',
      ),
      TreatmentProcessItemModel(
        id: '2',
        title: 'Hastane Görüşmesi',
        description:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh',
        dateTime: '01/12/2020 - 10:00',
      ),
      TreatmentProcessItemModel(
        id: '3',
        title: 'Sonuçlar',
        description: 'Kan değerleri',
        dateTime: '01/12/2020 - 09:00',
      ),
    ];
    progress = LoadingProgress.DONE;
  }
}
