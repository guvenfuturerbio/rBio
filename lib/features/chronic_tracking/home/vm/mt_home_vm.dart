part of '../view/mt_home_screen.dart';

class MeasurementTrackingVm with ChangeNotifier {
  List<HomePageModel> items = [];

  LoadingProgress _state = LoadingProgress.LOADING;
  LoadingProgress get state => _state;

  HomePageModel _selectedPage;
  HomePageModel activeItem;

  HomePageModel get selectedPage => _selectedPage == null
      ? HomePageModel(title: LocaleProvider.current.chronic_track)
      : items[0];

  MeasurementTrackingVm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getValues();
    });
  }

  Future<void> getValues() async {
    try {
      _state = LoadingProgress.LOADING;
      notifyListeners();

      if (!(state == LoadingProgress.DONE)) {
        await getIt<GlucoseStorageImpl>().checkLastGlucoseData();
        await getIt<ScaleStorageImpl>().checkLastScale();
        await getIt<BloodPressureStorageImpl>().checkLastBp();

        items = [
          HomePageModel<BgProgressPageViewModel>(
            title: '${LocaleProvider.current.blood_glucose_progress}',
            key: Key('Glucose'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<ScaleProgressPageViewModel>(
            title: '${LocaleProvider.current.scale_progress}',
            key: Key('Scale'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<BpProgressPageVm>(
            title: '${LocaleProvider.current.scale_progress}',
            key: Key('Pressure'),
            activateCallBack: (key) => setActiveItem(key),
          ),
        ];

        _state = LoadingProgress.DONE;
        notifyListeners();
      }
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      _state = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  void setActiveItem(Key key) {
    Utils.instance.releaseOrientation();

    if (key == Key('Glucose')) {
      Atom.to(PagePaths.BLOOD_GLUCOSE_PROGRESS);
    } else if (key == Key('Scale')) {
      Atom.to(PagePaths.BMI_PROGRESS);
    } else if (key == Key('Pressure')) {
      Atom.to(PagePaths.BP_PROGRESS);
    }
    notifyListeners();
  }
}
