part of '../view/mt_home_screen.dart';

class MeasurementTrackingVm with ChangeNotifier {
  List<HomePageModel> items = [];

  LoadingProgress _state = LoadingProgress.loading;
  LoadingProgress get state => _state;

  HomePageModel? _selectedPage;
  HomePageModel? activeItem;

  HomePageModel get selectedPage => _selectedPage == null
      ? HomePageModel(title: LocaleProvider.current.chronic_track)
      : items[0];

  MeasurementTrackingVm() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getValues();
    });
  }

  Future<void> getValues() async {
    try {
      _state = LoadingProgress.loading;
      notifyListeners();

      if (!(state == LoadingProgress.done)) {
        await getIt<GlucoseStorageImpl>().checkLastGlucoseData();
        await getIt<ScaleStorageImpl>().checkLastScale();
        await getIt<BloodPressureStorageImpl>().checkLastBp();

        items = [
          HomePageModel<BgProgressPageViewModel>(
            title: LocaleProvider.current.blood_glucose_progress,
            key: const Key('Glucose'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<ScaleProgressPageViewModel>(
            title: LocaleProvider.current.scale_progress,
            key: const Key('Scale'),
            activateCallBack: (key) => setActiveItem(key),
          ),
          HomePageModel<BpProgressPageVm>(
            title: LocaleProvider.current.scale_progress,
            key: const Key('Pressure'),
            activateCallBack: (key) => setActiveItem(key),
          ),
        ];

        _state = LoadingProgress.done;
        notifyListeners();
      }
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      _state = LoadingProgress.error;
      notifyListeners();
    }
  }

  void setActiveItem(Key key) {
    Utils.instance.releaseOrientation();

    if (key == const Key('Glucose')) {
      Atom.to(PagePaths.bloodGlucoseProgress);
    } else if (key == const Key('Scale')) {
      Atom.to(PagePaths.bmiProgress);
    } else if (key == const Key('Pressure')) {
      Atom.to(PagePaths.bpProgress);
    }
    notifyListeners();
  }
}
