part of '../view/mt_home_screen.dart';

class MeasurementTrackingVm with ChangeNotifier {
  List<HomePageModel> items = [];
  HomePageModel _selectedPage;
  HomePageModel activeItem;

  HomePageModel get selectedPage => _selectedPage == null
      ? HomePageModel(title: LocaleProvider.current.chronic_track)
      : items[0];

  MeasurementTrackingVm() {
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
