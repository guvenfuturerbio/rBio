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
        title: 'Güncel tedavi',
        description: '',
        dateTime: '01/01/2021 - 09:00',
      ),
    ];
    progress = LoadingProgress.DONE;
  }
}
