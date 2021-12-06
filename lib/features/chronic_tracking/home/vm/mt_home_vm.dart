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

  void getValues() async {
    try {
      _state = LoadingProgress.LOADING;
      notifyListeners();

      if (!(state == LoadingProgress.DONE)) {
        await getIt<GlucoseStorageImpl>().getBloodGlucoseDataOfPerson(
            getIt<ProfileStorageImpl>().getFirst());
        await getIt<ScaleStorageImpl>().checkLastScale();
        items = [
          HomePageModel<BgProgressPageViewModel>(
              title: '${LocaleProvider.current.blood_glucose_progress}',
              key: Key('Glucose'),
              activateCallBack: (key) => setActiveItem(key),
              deActivateCallBack: deActivateItem),
          HomePageModel<ScaleProgressPageViewModel>(
              title: '${LocaleProvider.current.scale_progress}',
              key: Key('Scale'),
              activateCallBack: (key) => setActiveItem(key),
              deActivateCallBack: deActivateItem),
        ];
        _state = LoadingProgress.DONE;
        notifyListeners();
      }
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
      _state = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  setActiveItem(Key key) {
    activeItem = items.firstWhere((element) => element.key == key);
    notifyListeners();
  }

  deActivateItem() {
    activeItem = null;
    notifyListeners();
  }
}
