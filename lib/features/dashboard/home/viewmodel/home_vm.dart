import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../../../../core/core.dart';
import '../model/banner_model.dart';
import '../utils/appointments_painter.dart';
import '../utils/chronic_tracking_painter.dart';
import '../utils/detailed_symptom_checker.dart';
import '../utils/healthcare_employee_painter.dart';
import '../utils/hospital_appointment_painter.dart';
import '../utils/online_appointment_painter.dart';
import '../utils/results_painter.dart';
import '../utils/symptom_checker_painter.dart';
import '../view/home_screen.dart';
import '../widgets/home_slider.dart';
import '../widgets/reorderable_widget.dart';
import '../widgets/vertical_card_widget.dart';

class HomeVm extends ChangeNotifier {
  final BuildContext mContext;
  final IAppConfig appConfig;
  final Repository repository;
  final UserFacade userFacade;
  final UserNotifier userNotifier;
  final ISharedPreferencesManager sharedPreferencesManager;
  HomeVm({
    required this.mContext,
    required this.appConfig,
    required this.repository,
    required this.userFacade,
    required this.userNotifier,
    required this.sharedPreferencesManager,
  });

  // #region Variables
  List<String>? get getUserWidgets {
    final currentUserName =
        sharedPreferencesManager.getString(SharedPreferencesKeys.loginUserName);
    if (currentUserName == null) return null;
    final allUsersModel = userFacade.getHomeWidgets(currentUserName);
    if (allUsersModel == null) {
      return null;
    } else {
      return allUsersModel.useWidgets;
    }
  }

  static const keyHospitalAppointment = ValueKey('hospitalAppointment');
  static const keyOnlineAppointment = ValueKey('onlineAppointment');
  static const keyChronicTracking = ValueKey('chronicTracking');
  static const keyAppointments = ValueKey('appointments');
  static const keySlider = ValueKey('slider');
  static const keyResults = ValueKey('results');
  static const keySymptomChecker = ValueKey('symptomChecker');
  static const keyDetailedSymptom = ValueKey('detailedSymptom');
  static const keyHealthcareEmployee = ValueKey('healthcareEmployee');

  final Map<HomeWidgets, Key> keys = {
    HomeWidgets.hospitalAppointment: keyHospitalAppointment,
    HomeWidgets.onlineAppointment: keyOnlineAppointment,
    HomeWidgets.chronicTracking: keyChronicTracking,
    HomeWidgets.appointments: keyAppointments,
    HomeWidgets.slider: keySlider,
    HomeWidgets.results: keyResults,
    HomeWidgets.symptomChecker: keySymptomChecker,
    HomeWidgets.detailedSymptom: keyDetailedSymptom,
    HomeWidgets.healthcareEmployee: keyHealthcareEmployee,
  };

  final List<HomeWidgets> userDefaultValues = [
    HomeWidgets.hospitalAppointment,
    HomeWidgets.onlineAppointment,
    HomeWidgets.chronicTracking,
    HomeWidgets.appointments,
    HomeWidgets.slider,
    HomeWidgets.results,
    HomeWidgets.symptomChecker,
    HomeWidgets.detailedSymptom,
  ];

  final List<HomeWidgets> doctorDefaultValues = [
    HomeWidgets.hospitalAppointment,
    HomeWidgets.onlineAppointment,
    HomeWidgets.healthcareEmployee,
    HomeWidgets.appointments,
    HomeWidgets.slider,
    HomeWidgets.results,
    HomeWidgets.symptomChecker,
    HomeWidgets.detailedSymptom,
  ];

  double startAngle = 0;

  double endAngle = 0;

  ShakeMod status = ShakeMod.notShaken;

  List<Widget> widgetsInUse = [];

  bool showDeletedAlert = false;

  List<BannerTabsModel> bannerTabsModel = [];

  late SpringController springController;
  // #endregion

  // #region init
  Future<void> init(AllUsersModel? allUsersModel) async {
    springController = SpringController(initialAnim: Motion.mirror);
    await fetchWidgets(allUsersModel);
    if (appConfig.productType == ProductType.oneDose) {
      await fetchBanners();
    }
    if (bannerTabsModel.isEmpty) {
      removeItemWidgetList(HomeWidgets.slider);
    }

    notifyListeners();
  }
  // #endregion

  // #region fetchBanners
  Future<void> fetchBanners() async {
    bannerTabsModel = await repository.getBannerTab('rBio', 'anaSayfa');
  }
  // #endregion

  // #region fetchWidgets
  Future<void> fetchWidgets(AllUsersModel? allUsersModel) async {
    widgetsInUse = [];

    final sharedUserList = getUserWidgets;
    if (sharedUserList == null) {
      List<String> setList = [];
      List<HomeWidgets> values = _getAllCases();
      for (var widgetType in values) {
        if (widgetType.isShowDefault()) {
          final child = _getWidgetByType(widgetType, false);
          if (child != null) {
            setList.add(widgetType.xRawValue);
            widgetsInUse.add(child);
          }
        }
      }

      await saveWidgetList(setList);
    } else {
      final sharedTypes = sharedUserList.map((e) => e.xHomeWidgets).toList();
      widgetsInUse = _getTypeToWidgetList(sharedTypes, false);
    }
  }
  // #endregion

  // #region removeWidget
  Future<void> removeWidget(HomeWidgets widgetType) async {
    removeItemWidgetList(widgetType);
    await removeWidgetLocalStorage(widgetType);
    notifyListeners();
  }

  void removeItemWidgetList(HomeWidgets widgetType) {
    widgetsInUse.removeWhere((element) =>
        ((element.key as ValueKey).value as String).xHomeWidgets == widgetType);
  }

  Future<void> removeWidgetLocalStorage(HomeWidgets widgetType) async {
    var sharedUserList = getUserWidgets ?? [];
    sharedUserList.remove(widgetType.xRawValue);
    await saveWidgetList(sharedUserList);
  }
  // #endregion

  // #region addWidget
  Future<void> addWidget(HomeWidgets widgetType) async {
    List<String> sharedUserList = List<String>.from(getUserWidgets ?? []);
    final newWidget = _getWidgetByType(widgetType, false);
    if (newWidget != null) {
      if (!(widgetsInUse
          .any((element) => element.key == keys[HomeWidgets.slider]))) {
        if (newWidget.key == keys[HomeWidgets.slider]) {
          widgetsInUse.insert(2, newWidget);
          sharedUserList.insert(2, widgetType.xRawValue);
        } else {
          widgetsInUse.add(newWidget);
          sharedUserList.add(widgetType.xRawValue);
        }
      } else {
        if (widgetsInUse
                .indexOf(widgetsInUse.singleWhere(
                    (element) => element.key == keys[HomeWidgets.slider]))
                .isEven &&
            widgetsInUse.last.key != keys[HomeWidgets.slider]) {
          addAfterSlider(newWidget);
          sharedUserList.insert(
            widgetsInUse.indexOf(widgetsInUse.singleWhere(
                    (element) => element.key == keys[HomeWidgets.slider])) +
                1,
            widgetType.xRawValue,
          );
        } else if (widgetsInUse
                .indexOf(widgetsInUse.singleWhere(
                    (element) => element.key == keys[HomeWidgets.slider]))
                .isEven &&
            widgetsInUse.last.key == keys[HomeWidgets.slider]) {
          addBeforeSlider(newWidget);
          sharedUserList.insert(
              widgetsInUse.indexOf(widgetsInUse.singleWhere(
                      (element) => element.key == keys[HomeWidgets.slider])) -
                  1,
              widgetType.xRawValue);
        } else if (widgetsInUse.indexOf(widgetsInUse.singleWhere(
                (element) => element.key == keys[HomeWidgets.slider])) ==
            1) {
          sharedUserList.insert(1, widgetType.xRawValue);
          widgetsInUse.insert(1, newWidget);
        } else if (widgetsInUse.indexOf(widgetsInUse.singleWhere(
                (element) => element.key == keys[HomeWidgets.slider])) ==
            3) {
          widgetsInUse.insert(3, newWidget);
          sharedUserList.insert(3, widgetType.xRawValue);
        } else if (widgetsInUse.indexOf(widgetsInUse.singleWhere(
                (element) => element.key == keys[HomeWidgets.slider])) ==
            5) {
          widgetsInUse.insert(5, newWidget);
          sharedUserList.insert(5, widgetType.xRawValue);
        } else {
          widgetsInUse.add(newWidget);
          sharedUserList.add(widgetType.xRawValue);
        }
      }
      await saveWidgetList(sharedUserList);
      closeAddAlert();
      notifyListeners();
      Atom.dismiss();
    }
  }
  // #endregion

  // #region onReorder
  void onReorder(int oldIndex, int newIndex) async {
    try {
      Widget row = widgetsInUse.removeAt(oldIndex);
      widgetsInUse.insert(newIndex, row);
      List<String?> setList = widgetsInUse.map((Widget element) {
        final _widget =
            ((element.key as ValueKey).value as String).xHomeWidgets;
        if (_widget != null) {
          return _widget.xRawValue;
        }
      }).toList();
      List<String> newList = [];
      for (var item in setList) {
        if (item != null) {
          newList.add(item);
        }
      }
      await saveWidgetList(newList);
    } catch (e, stackTrace) {
      appConfig.platform.sentryManager.captureException(
        e,
        stackTrace: stackTrace,
      );
    }
  }
  // #endregion

  // #region saveWidgetList
  Future<void> saveWidgetList(List<String> list) async {
    await userFacade.saveHomeWidgets(list);
  }
  // #endregion

  // #region changeStatus
  void changeStatus() {
    status = status.toggle();
    if (status.isShaken) {
      startAngle = 2;
      endAngle = -2;
    } else {
      startAngle = 0;
      endAngle = 0;
    }
    notifyListeners();
  }
  // #endregion

  // #region showRemovedWidgets
  void showRemovedWidgets() {
    openAddAlert();
    notifyListeners();

    final sharedUserList = getUserWidgets;
    if (sharedUserList == null) return;
    final allWidgets = _getAllCases(true).map((e) => e.xRawValue).toList();
    allWidgets.removeWhere((e) => sharedUserList.contains(e));
    // Kullanılmayan widgetlar
    final removedWidgetTypes = allWidgets.map((e) => e.xHomeWidgets).toList();
    final removedChildren = _getTypeToWidgetList(removedWidgetTypes, true);

    Atom.show(
      Container(
        color: Colors.black12,
        child: Consumer<HomeVm>(
          builder: (BuildContext context, HomeVm val, Widget? child) {
            return SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: removedChildren,
                  ),

                  //
                  R.sizes.hSizer8,

                  //
                  RbioElevatedButton(
                    onTap: () {
                      closeAddAlert();
                      notifyListeners();
                      Atom.dismiss();
                    },
                    title: LocaleProvider.current.close_lbl,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  // #endregion

  // #region openAddAlert
  void openAddAlert() {
    showDeletedAlert = true;
  }
  // #endregion

  // #region closeAddAlert
  void closeAddAlert() {
    showDeletedAlert = false;
  }
  // #endregion

  // #region _getAllCases
  List<HomeWidgets> _getAllCases([bool isDoctorRemove = false]) {
    final isDoctor = userNotifier.user.xGetHealthcareEmployeeOrFalse;
    List<HomeWidgets> values = [];
    if (isDoctor) {
      values = doctorDefaultValues;
      if (isDoctorRemove) {
        values.add(HomeWidgets.chronicTracking);
      }
    } else {
      values = userDefaultValues;
    }
    return values.toSet().toList();
  }
  // #endregion

  // #region _getTypeToWidgetList
  List<Widget> _getTypeToWidgetList(
    List<HomeWidgets?> types,
    bool isRemovedWidgets,
  ) {
    final result = <Widget>[];
    for (var widgetType in types) {
      final child = _getWidgetByType(widgetType, isRemovedWidgets);
      if (child != null) {
        result.add(child);
      }
    }
    return result;
  }
  // #endregion

  // #region _getWidgetByType
  Widget? _getWidgetByType(HomeWidgets? widgetType, bool isRemovedWidgets) {
    switch (widgetType) {
      case HomeWidgets.hospitalAppointment:
        {
          if (appConfig.functionality.takeHospitalAppointment) {
            return MyReorderableWidget(
              key: keys[HomeWidgets.hospitalAppointment]!,
              type: HomeWidgets.hospitalAppointment,
              isRemovedWidgets: isRemovedWidgets,
              body: Consumer<LocaleNotifier>(
                builder: (context, localeVm, widget) {
                  return VerticalCard(
                    title: LocaleProvider.current.lbl_find_hospital,
                    painter: HomeHospitalAppointmentCustomPainter(),
                  );
                },
              ),
              onTap: () {
                Atom.to(
                  PagePaths.createAppointment,
                  queryParameters: {
                    'forOnline': false.toString(),
                    'fromSearch': false.toString(),
                    'fromSymptom': false.toString(),
                  },
                );
              },
            );
          }

          break;
        }

      case HomeWidgets.onlineAppointment:
        {
          if (appConfig.functionality.takeOnlineAppointment) {
            return MyReorderableWidget(
              key: keys[HomeWidgets.onlineAppointment]!,
              type: HomeWidgets.onlineAppointment,
              isRemovedWidgets: isRemovedWidgets,
              body: Consumer<LocaleNotifier>(
                builder: (context, localeVm, widget) {
                  return VerticalCard(
                    title: LocaleProvider.current.take_video_appointment,
                    painter: HomeOnlineAppointmentCustomPainter(),
                  );
                },
              ),
              onTap: () {
                Atom.to(
                  PagePaths.createAppointment,
                  queryParameters: {
                    'forOnline': true.toString(),
                    'fromSearch': false.toString(),
                    'fromSymptom': false.toString(),
                  },
                );
              },
            );
          }

          break;
        }

      case HomeWidgets.chronicTracking:
        {
          if (appConfig.functionality.chronicTracking) {
            return MyReorderableWidget(
              key: keys[HomeWidgets.chronicTracking]!,
              type: HomeWidgets.chronicTracking,
              isRemovedWidgets: isRemovedWidgets,
              body: Consumer<LocaleNotifier>(
                builder: (context, localeVm, widget) {
                  return VerticalCard(
                    title: LocaleProvider.current.chronic_track_home,
                    painter: HomeChronicTrackingCustomPainter(),
                  );
                },
              ),
              onTap: () {
                Atom.to(PagePaths.measurementTrackingHome);
              },
            );
          }

          break;
        }

      case HomeWidgets.appointments:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.appointments]!,
            type: HomeWidgets.appointments,
            isRemovedWidgets: isRemovedWidgets,
            body: Consumer<LocaleNotifier>(
              builder: (context, localeVm, widget) {
                return VerticalCard(
                  title: LocaleProvider.current.appointments,
                  painter: HomeAppointmentsCustomPainter(),
                );
              },
            ),
            onTap: () {
              Atom.to(PagePaths.appointment);
            },
          );
        }

      case HomeWidgets.slider:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.slider]!,
            type: HomeWidgets.slider,
            isRemovedWidgets: isRemovedWidgets,
            body: const HomeSlider(),
            showDeleteIcon: false,
            isVerticalCard: false,
          );
        }

      case HomeWidgets.results:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.results],
            type: HomeWidgets.results,
            isRemovedWidgets: isRemovedWidgets,
            body: Consumer<LocaleNotifier>(
              builder: (context, localeVm, widget) {
                return VerticalCard(
                  title: LocaleProvider.current.results,
                  painter: HomeResultsCustomPainter(),
                );
              },
            ),
            onTap: () {
              Atom.to(PagePaths.eResult);
            },
          );
        }

      case HomeWidgets.symptomChecker:
        {
          if (appConfig.functionality.symptomChecker) {
            return MyReorderableWidget(
              key: keys[HomeWidgets.symptomChecker],
              type: HomeWidgets.symptomChecker,
              isRemovedWidgets: isRemovedWidgets,
              body: Consumer<LocaleNotifier>(
                builder: (context, localeVm, widget) {
                  return VerticalCard(
                    title: LocaleProvider.current.symptom_checker,
                    painter: HomeSymptomCheckerCustomPainter(),
                  );
                },
              ),
              onTap: () {
                Atom.to(PagePaths.symptomMainMenu);
              },
            );
          }

          break;
        }

      case HomeWidgets.detailedSymptom:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.detailedSymptom],
            type: HomeWidgets.detailedSymptom,
            isRemovedWidgets: isRemovedWidgets,
            body: Consumer<LocaleNotifier>(
              builder: (context, localeVm, widget) {
                return VerticalCard(
                  title: LocaleProvider.current.detailed_symptom,
                  painter: HomeDetailedCheckupCustomPainter(),
                );
              },
            ),
            onTap: () {
              Atom.to(PagePaths.detailedSymptom);
            },
          );
        }

      case HomeWidgets.healthcareEmployee:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.healthcareEmployee],
            type: HomeWidgets.healthcareEmployee,
            isRemovedWidgets: isRemovedWidgets,
            body: Consumer<LocaleNotifier>(
              builder: (context, localeVm, widget) {
                return VerticalCard(
                  title: LocaleProvider.current.healthcare_employee,
                  painter: HomeHealthCareEmployeeCustomPainter(),
                );
              },
            ),
            onTap: () {
              Atom.to(PagePaths.doctorHome);
            },
          );
        }

      default:
        return null;
    }

    return null;
  }

  void addAfterSlider(Widget newWidget) {
    widgetsInUse.insert(
        widgetsInUse.indexOf(widgetsInUse.singleWhere(
                (element) => element.key == keys[HomeWidgets.slider])) +
            1,
        newWidget);
  }

  void addBeforeSlider(Widget newWidget) {
    widgetsInUse.insert(
        widgetsInUse.indexOf(widgetsInUse.singleWhere(
                (element) => element.key == keys[HomeWidgets.slider])) -
            1,
        newWidget);
  }
  // #endregion
}
