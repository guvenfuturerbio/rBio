import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../../../core/core.dart';
import '../model/banner_model.dart';
import '../model/drawer_model.dart';
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

  HomeVm({this.mContext});

  // #region Variables
  final sharedPreferencesManager = getIt<ISharedPreferencesManager>();
  List<String> get getUserWidgets {
    final currentUserName = sharedPreferencesManager
        .getString(SharedPreferencesKeys.LOGIN_USERNAME);
    final allUsersModel = getIt<UserNotifier>().getHomeWidgets(currentUserName);
    if (allUsersModel == null) {
      return null;
    } else {
      return allUsersModel.useWidgets;
    }
  }

  final Map<HomeWidgets, Key> keys = {
    HomeWidgets.hospitalAppointment: const Key('hospitalAppointment'),
    HomeWidgets.onlineAppointment: const Key('onlineAppointment'),
    HomeWidgets.chronicTracking: const Key('chronicTracking'),
    HomeWidgets.appointments: const Key('appointments'),
    HomeWidgets.slider: const Key('slider'),
    HomeWidgets.results: const Key('results'),
    HomeWidgets.symptomChecker: const Key('symptomChecker'),
    HomeWidgets.detailedSymptom: const Key('detailedSymptom'),
    HomeWidgets.healthcare_employee: const Key('healthcare_employee'),
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
    HomeWidgets.chronicTracking,
    HomeWidgets.appointments,
    HomeWidgets.slider,
    HomeWidgets.results,
    HomeWidgets.symptomChecker,
    HomeWidgets.detailedSymptom,
    HomeWidgets.healthcare_employee,
  ];

  double startAngle = 0;

  double endAngle = 0;

  ShakeMod status = ShakeMod.notShaken;

  List<Widget> widgetsInUse = [];

  bool showDeletedAlert = false;

  List<BannerTabsModel> bannerTabsModel = [];

  SpringController springController;

  List<DrawerModel> get drawerList => <DrawerModel>[
        DrawerModel(
          title: LocaleProvider.current.profile,
          onTap: () {
            Atom.to(PagePaths.PROFILE);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.lbl_find_hospital,
          onTap: () {
            Atom.to(
              PagePaths.CREATE_APPOINTMENT,
              queryParameters: {
                'forOnline': false.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.take_video_appointment,
          onTap: () {
            Atom.to(
              PagePaths.CREATE_APPOINTMENT,
              queryParameters: {
                'forOnline': true.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.chronic_track_home,
          onTap: () {
            Atom.to(PagePaths.MEASUREMENT_TRACKING);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.appointments,
          onTap: () {
            Atom.to(PagePaths.APPOINTMENTS);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.results,
          onTap: () {
            Atom.to(PagePaths.ERESULT);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.for_you,
          onTap: () {
            Atom.to(PagePaths.FOR_YOU_CATEGORIES);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.symptom_checker,
          onTap: () {
            Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.devices,
          onTap: () {
            Atom.to(PagePaths.DEVICES);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.reminders,
          onTap: () {
            Atom.to(PagePaths.MEDIMINDER_INITIAL);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.request_and_suggestions,
          onTap: () {
            Atom.to(PagePaths.SUGGEST_REQUEST);
          },
        ),
        DrawerModel(
          title: LocaleProvider.current.detailed_symptom,
          onTap: () {
            Atom.to(
              PagePaths.DETAILED_SYMPTOM,
            );
          },
        ),
      ];
  // #endregion

  // #region init
  Future<void> init(AllUsersModel allUsersModel) async {
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) async {
        springController = SpringController(initialAnim: Motion.mirror);
        await fetchWidgets(allUsersModel);
        await fetchBanners();
        notifyListeners();
      });
    }
  }
  // #endregion

  // #region fetchBanners
  Future<void> fetchBanners() async {
    bannerTabsModel =
        await getIt<Repository>().getBannerTab('rBio', 'anaSayfa');
  }
  // #endregion

  // #region fetchWidgets
  Future<void> fetchWidgets(AllUsersModel allUsersModel) async {
    widgetsInUse = [];
    final sharedUserList = getUserWidgets;
    if (sharedUserList == null) {
      List<String> setList = [];
      List<HomeWidgets> values = _getAllCases();
      values.forEach((widgetType) {
        if (widgetType.isShowDefault()) {
          final child = _getWidgetByType(widgetType, false);
          if (child != null) {
            setList.add(widgetType.xRawValue);
            widgetsInUse.add(child);
          }
        }
      });
      await saveWidgetList(setList);
    } else {
      final sharedTypes = sharedUserList.map((e) => e.xHomeWidgets).toList();
      widgetsInUse = _getTypeToWidgetList(sharedTypes, false);
    }
  }
  // #endregion

  // #region removeWidget
  Future<void> removeWidget(HomeWidgets widgetType) async {
    widgetsInUse.removeWhere((element) =>
        ((element.key as ValueKey).value as String).xHomeWidgets == widgetType);
    var sharedUserList = getUserWidgets ?? [];
    sharedUserList.remove(widgetType.xRawValue);
    await saveWidgetList(sharedUserList);
    notifyListeners();
  }
  // #endregion

  // #region addWidget
  Future<void> addWidget(HomeWidgets widgetType) async {
    var sharedUserList = getUserWidgets ?? [];
    sharedUserList.add(widgetType.xRawValue);
    await saveWidgetList(sharedUserList);
    widgetsInUse.add(_getWidgetByType(widgetType, false));
    closeAddAlert();
    notifyListeners();
    Atom.dismiss();
  }
  // #endregion

  // #region onReorder
  void onReorder(int oldIndex, int newIndex) async {
    try {
      Widget row = widgetsInUse.removeAt(oldIndex);
      await widgetsInUse.insert(newIndex, row);
      List<String> setList = widgetsInUse.map((element) {
        return ((element.key as ValueKey).value as String)
            .xHomeWidgets
            .xRawValue;
      }).toList();
      await saveWidgetList(setList);
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }
  // #endregion

  // #region saveWidgetList
  Future<void> saveWidgetList(List<String> list) async {
    await getIt<UserNotifier>().saveHomeWidgets(list);
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
    final allWidgets = _getAllCases().map((e) => e.xRawValue).toList();
    allWidgets.removeWhere((e) => sharedUserList.contains(e));
    // Kullanılmayan widgetlar
    final removedWidgetTypes = allWidgets.map((e) => e.xHomeWidgets).toList();
    final removedChildren = _getTypeToWidgetList(removedWidgetTypes, true);

    Atom.show(
      Container(
        color: Colors.black12,
        child: Consumer<HomeVm>(
          builder: (BuildContext context, HomeVm val, Widget child) {
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
  List<HomeWidgets> _getAllCases() {
    final isDoctor = getIt<UserNotifier>().isDoctor;
    List<HomeWidgets> values = [];
    if (isDoctor) {
      values = doctorDefaultValues;
    } else {
      values = userDefaultValues;
    }
    return values;
  }
  // #endregion

  // #region _getTypeToWidgetList
  List<Widget> _getTypeToWidgetList(
    List<HomeWidgets> types,
    bool isRemovedWidgets,
  ) {
    final result = <Widget>[];
    types.forEach((widgetType) {
      final child = _getWidgetByType(widgetType, isRemovedWidgets);
      if (child != null) {
        result.add(child);
      }
    });
    return result;
  }
  // #endregion

  // #region _getWidgetByType
  Widget _getWidgetByType(HomeWidgets widgetType, bool isRemovedWidgets) {
    switch (widgetType) {
      case HomeWidgets.hospitalAppointment:
        {
          if (getIt<AppConfig>().takeHospitalAppointment)
            return MyReorderableWidget(
              key: keys[HomeWidgets.hospitalAppointment],
              type: HomeWidgets.hospitalAppointment,
              isRemovedWidgets: isRemovedWidgets,
              body: VerticalCard(
                title: LocaleProvider.current.lbl_find_hospital,
                painter: HomeHospitalAppointmentCustomPainter(),
              ),
              onTap: () {
                Atom.to(
                  PagePaths.CREATE_APPOINTMENT,
                  queryParameters: {
                    'forOnline': false.toString(),
                    'fromSearch': false.toString(),
                    'fromSymptom': false.toString(),
                  },
                );
              },
            );

          break;
        }

      case HomeWidgets.onlineAppointment:
        {
          if (getIt<AppConfig>().takeOnlineAppointment)
            return MyReorderableWidget(
              key: keys[HomeWidgets.onlineAppointment],
              type: HomeWidgets.onlineAppointment,
              isRemovedWidgets: isRemovedWidgets,
              body: VerticalCard(
                title: LocaleProvider.current.take_video_appointment,
                painter: HomeOnlineAppointmentCustomPainter(),
              ),
              onTap: () {
                Atom.to(
                  PagePaths.CREATE_APPOINTMENT,
                  queryParameters: {
                    'forOnline': true.toString(),
                    'fromSearch': false.toString(),
                    'fromSymptom': false.toString(),
                  },
                );
              },
            );

          break;
        }

      case HomeWidgets.chronicTracking:
        {
          if (getIt<AppConfig>().chronicTracking)
            return MyReorderableWidget(
              key: keys[HomeWidgets.chronicTracking],
              type: HomeWidgets.chronicTracking,
              isRemovedWidgets: isRemovedWidgets,
              body: VerticalCard(
                title: LocaleProvider.current.chronic_track_home,
                painter: HomeChronicTrackingCustomPainter(),
              ),
              onTap: () {
                Atom.to(PagePaths.MEASUREMENT_TRACKING);
              },
            );

          break;
        }

      case HomeWidgets.appointments:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.appointments],
            type: HomeWidgets.appointments,
            isRemovedWidgets: isRemovedWidgets,
            body: VerticalCard(
              title: LocaleProvider.current.appointments,
              painter: HomeAppointmentsCustomPainter(),
            ),
            onTap: () {
              Atom.to(PagePaths.APPOINTMENTS);
            },
          );
        }

      case HomeWidgets.slider:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.slider],
            type: HomeWidgets.slider,
            isRemovedWidgets: isRemovedWidgets,
            body: HomeSlider(),
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
            body: VerticalCard(
              title: LocaleProvider.current.results,
              painter: HomeResultsCustomPainter(),
            ),
            onTap: () {
              Atom.to(PagePaths.ERESULT);
            },
          );
        }

      case HomeWidgets.symptomChecker:
        {
          if (getIt<AppConfig>().symptomChecker)
            return MyReorderableWidget(
              key: keys[HomeWidgets.symptomChecker],
              type: HomeWidgets.symptomChecker,
              isRemovedWidgets: isRemovedWidgets,
              body: VerticalCard(
                title: LocaleProvider.current.symptom_checker,
                painter: HomeSymptomCheckerCustomPainter(),
              ),
              onTap: () {
                Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
              },
            );

          break;
        }

      case HomeWidgets.detailedSymptom:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.detailedSymptom],
            type: HomeWidgets.detailedSymptom,
            isRemovedWidgets: isRemovedWidgets,
            body: VerticalCard(
              title: LocaleProvider.current.detailed_symptom,
              painter: HomeDetailedCheckupCustomPainter(),
            ),
            onTap: () {
              Atom.to(PagePaths.DETAILED_SYMPTOM);
            },
          );
        }

      case HomeWidgets.healthcare_employee:
        {
          return MyReorderableWidget(
            key: keys[HomeWidgets.healthcare_employee],
            type: HomeWidgets.healthcare_employee,
            isRemovedWidgets: isRemovedWidgets,
            body: VerticalCard(
              title: LocaleProvider.current.healthcare_employee,
              painter: HomeHealthCareEmployeeCustomPainter(),
            ),
            onTap: () {
              Atom.to(PagePaths.DOCTOR_HOME);
            },
          );
        }

      default:
        return null;
    }

    return null;
  }
  // #endregion
}
