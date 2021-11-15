part of 'home_page_new.dart';

class HomePageNewVm extends ChangeNotifier {
  final BuildContext context;
  HomePageNewVm({this.context}) {
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

  bool isActive = false;
  bool isVisible = true;

  HomePageModel _selectedPage;
  HomePageModel get selectedPage => _selectedPage == null
      ? HomePageModel(title: '${UserProfilesNotifier().profiles.active.name}')
      : items[0];

  var menuOptions = [
    MenuOption(
        title: LocaleProvider.current.home,
        navigateRoute: Routes.HOME_PAGE,
        icon: R.image.dashboard_icon,
        iconWidth: 62.7995,
        iconHeight: 74),
    MenuOption(
        title: LocaleProvider.current.blood_glucose_progress,
        navigateRoute: Routes.BG_PROGRESS_PAGE,
        icon: R.image.bg_icon,
        iconWidth: 41.67,
        iconHeight: 70.0),
    MenuOption(
        title: LocaleProvider.current.scale_progress,
        navigateRoute: Routes.SCALE_PROGRESS_PAGE,
        icon: R.image.scale_icon,
        iconWidth: 41.67,
        iconHeight: 70.0),
    MenuOption(
        title: LocaleProvider.current.device_connections,
        navigateRoute: Routes.PAIRED_DEVICES,
        icon: R.image.connect_device_icon,
        iconWidth: 70.0,
        iconHeight: 50.6075),
    MenuOption(
        title: LocaleProvider.current.reminders,
        navigateRoute: Routes.MY_MEDICINES_PAGE,
        icon: R.image.reminder_icon),
    MenuOption(
        title: LocaleProvider.current.consultation,
        navigateRoute: Routes.CONSULTATION_PAGE,
        icon: R.image.consultation_icon,
        iconWidth: 36.3881,
        iconHeight: 70.0),
    /*  MenuOption(
        title: LocaleProvider.current.premium,
        navigateRoute: Routes.PREMIUM_STORE_PAGE,
        icon: R.image.premium_icon,
        iconWidth: 41.794,
        iconHeight: 70.0), */
    MenuOption(
        title: LocaleProvider.current.settings,
        navigateRoute: Routes.SETTINGS_PAGE,
        icon: R.image.settings_icon,
        iconWidth: 70.0,
        iconHeight: 70.0)
  ];

  List<HomePageModel> items = [];
  HomePageModel activeItem;
  setActiveItem(Key key) {
    activeItem = items.firstWhere((element) => element.key == key);
    notifyListeners();
  }

  deActivateItem() {
    activeItem = null;
    notifyListeners();
  }
}

final List<Color> colors = [
  Colors.amber,
  Colors.blue,
  Colors.cyan,
  Colors.grey,
  Colors.teal,
  Colors.purple,
];
