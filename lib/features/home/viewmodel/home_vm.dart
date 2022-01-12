import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../../../core/core.dart';
import '../model/banner_model.dart';
import '../utils/appointments_painter.dart';
import '../utils/chronic_tracking_painter.dart';
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
  double startAngle = 0;
  double endAngle = 0;

  ShakeMod status = ShakeMod.notShaken;

  //Kullanımda olan ve ekranda gösterilen widgetların tutulduğu liste
  List<Widget> widgetsInUse = [];

  //Ekrandan silinen ama menüde görünmesi gereken silinmiş widgetları gösteren liste
  List<Widget> widgetsDeleted = [];

  //Silinmiş widgetların keylerini tutan listemiz. Shared Preferences için kullanılıyor.
  List<String> deletedKeysHolder = [];

  //Elde tutulan widgetların sırasını tutan listemiz. Shared Preferences için kullanılıyor.
  List<String> queryOfWidgetsInUse = [];

  //Widgetların içerisinde bulunan onTap methodu için kullanılan bool değerimiz.
  bool isForDelete = false;
  //Slider widgetları
  List<BannerTabsModel> bannerTabsModel = [];
  SpringController springController;

  List<Map<String, dynamic>> get drawerList => [
        {
          LocaleProvider.current.profile: () {
            Atom.to(PagePaths.PROFILE);
          }
        },
        {
          LocaleProvider.current.lbl_find_hospital: () {
            Atom.to(
              PagePaths.CREATE_APPOINTMENT,
              queryParameters: {
                'forOnline': false.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          },
        },
        {
          LocaleProvider.current.take_video_appointment: () {
            Atom.to(
              PagePaths.CREATE_APPOINTMENT,
              queryParameters: {
                'forOnline': true.toString(),
                'fromSearch': false.toString(),
                'fromSymptom': false.toString(),
              },
            );
          }
        },
        {
          LocaleProvider.current.chronic_track_home: () {
            Atom.to(PagePaths.MEASUREMENT_TRACKING);
          }
        },
        {
          LocaleProvider.current.appointments: () {
            Atom.to(PagePaths.APPOINTMENTS);
          }
        },
        {
          LocaleProvider.current.results: () {
            Atom.to(PagePaths.ERESULT);
          }
        },
        {
          LocaleProvider.current.symptom_checker: () {
            Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
          }
        },
        {
          LocaleProvider.current.devices: () {
            Atom.to(PagePaths.DEVICES);
          }
        },
        {
          LocaleProvider.current.reminders: () {
            Atom.to(PagePaths.MEDIMINDER_INITIAL);
          }
        },
        {
          LocaleProvider.current.request_and_suggestions: () {
            Atom.to(PagePaths.SUGGEST_REQUEST);
          }
        },
        {
          LocaleProvider.current.detailed_symptom: () {
            Atom.to(
              PagePaths.DETAILED_SYMPTOM,
            );
          },
        },
      ];

  HomeVm({this.mContext});

  Future<void> init() async {
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) async {
        springController = SpringController(initialAnim: Motion.mirror);
        await fetchWidgets();
        bannerTabsModel =
            await getIt<Repository>().getBannerTab('rBio', 'anaSayfa');
        notifyListeners();
      });
    }
  }

  // Uygulama ilk açıldığında, silinmiş widgetların keylerini tutan veriyi shared preferences içinden çekip kullanılan widget listesini dolduran method.
  void fetchWidgets() {
    if (getIt<ISharedPreferencesManager>()
        .containsKey(SharedPreferencesKeys.DELETED_WIDGETS)) {
      deletedKeysHolder = getIt<ISharedPreferencesManager>()
          .getStringList(SharedPreferencesKeys.DELETED_WIDGETS);
      widgetsInUse.removeWhere((element) {
        if (deletedKeysHolder.contains(element.key.toString())) {
          widgetsDeleted.add(element);
          return deletedKeysHolder.contains(element.key.toString());
        } else {
          return false;
        }
      });
    }

    // Local'de kayıtlı liste varsa ona göre liste oluşturulur.
    if (getIt<ISharedPreferencesManager>()
        .containsKey(SharedPreferencesKeys.WIDGET_QUERY)) {
      queryOfWidgetsInUse = getIt<ISharedPreferencesManager>()
          .getStringList(SharedPreferencesKeys.WIDGET_QUERY);
      Map<String, Widget> myMap = widgetMap();
      widgetsInUse.clear();
      queryOfWidgetsInUse.forEach((element) {
        widgetsInUse.add(myMap[element]);
      });
    } else {
      widgetsInUse = widgets();
    }
  }

  List<Widget> getDeletedList() {
    Map<String, Widget> myMap = widgetMap();
    final deletedItems = getIt<ISharedPreferencesManager>()
        .getStringList(SharedPreferencesKeys.DELETED_WIDGETS);
    if (deletedItems != null) {
      return deletedItems.map((e) => myMap[e]).toList();
    }

    return [];
  }

  // Kullanıcı widget sildiğinde çalışan fonks.
  Future<void> removeWidget(Key widgetKey) async {
    for (var element in widgetsInUse) {
      if (element.key == widgetKey) {
        widgetsDeleted.add(element);
        deletedKeysHolder.add(element.key.toString());
      }
    }

    widgetsInUse.removeWhere((element) => widgetsDeleted.contains(element));
    getIt<ISharedPreferencesManager>().setStringList(
        SharedPreferencesKeys.DELETED_WIDGETS, deletedKeysHolder);
    await querySaver();
    notifyListeners();
  }

  // Kullanıcı widget eklediğinde çalışan fonks.
  Future<void> addWidget(Key widgetKey) async {
    Map<String, Widget> myMap = widgetMap();
    myMap.forEach((key, value) {
      if (key == widgetKey.toString()) {
        widgetsInUse.add(value);
        deletedKeysHolder.removeWhere((element) => element == key.toString());
      }
    });

    getIt<ISharedPreferencesManager>().setStringList(
        SharedPreferencesKeys.DELETED_WIDGETS, deletedKeysHolder);
    await querySaver();
    widgetsDeleted.removeWhere((element) => widgetsInUse.contains(element));
    isForDelete = false;
    notifyListeners();
    Atom.dismiss();
  }

  // Kullanıcı widgetların sırasını değiştirdiğinde çalışan fonks.
  void onReorder(int oldIndex, int newIndex) async {
    try {
      Widget row = widgetsInUse.removeAt(oldIndex);
      await widgetsInUse.insert(newIndex, row);
      await querySaver();
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  // Yeri değişmiş, silinmiş veya eklenmiş widgetlardan sonra çalışan sıra kaydedici fonks.
  void querySaver() async {
    queryOfWidgetsInUse.clear();
    widgetsInUse.forEach((element) {
      queryOfWidgetsInUse.add(element.key.toString());
    });
    await getIt<ISharedPreferencesManager>()
        .setStringList(SharedPreferencesKeys.WIDGET_QUERY, queryOfWidgetsInUse);
  }

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

  // Widget eklemek için açılan menü
  void showRemovedWidgets() {
    isForDelete = true;
    notifyListeners();

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
                    children: getDeletedList(),
                  ),

                  //
                  RbioElevatedButton(
                    onTap: () {
                      isForDelete = false;
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

  // Widgetların sırasını çektikten sonra sırasına göre doldurluğumuz listenin beslendiği map.
  Map<String, Widget> widgetMap() {
    List<Widget> returner = widgets();
    return <String, Widget>{
      "[<'1'>]": returner[0],
      "[<'2'>]": returner[1],
      "[<'3'>]": returner[2],
      "[<'4'>]": returner[3],
      "[<'5'>]": returner[4],
      "[<'6'>]": returner[5],
      "[<'7'>]": returner[6],
    };
  }

  final _key1 = const Key('1');
  final _key2 = const Key('2');
  final _key3 = const Key('3');
  final _key4 = const Key('4');
  final key5 = const Key('5');
  final _key6 = const Key('6');
  final _key7 = const Key('7');

  // Tüm widgetları çeken fonks.
  List<Widget> widgets() => <Widget>[
        //
        if (getIt<AppConfig>().takeHospitalAppointment)
          MyReorderableWidget(
            key: _key1,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key1);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(
                    PagePaths.CREATE_APPOINTMENT,
                    queryParameters: {
                      'forOnline': false.toString(),
                      'fromSearch': false.toString(),
                      'fromSymptom': false.toString(),
                    },
                  );
                }
              },
              child: Consumer<LocaleNotifier>(
                builder: (context, vm, child) {
                  return VerticalCard(
                    title: LocaleProvider.current.lbl_find_hospital,
                    painter: HomeHospitalAppointmentCustomPainter(),
                  );
                },
              ),
            ),
          ),

        //
        if (getIt<AppConfig>().takeOnlineAppointment)
          MyReorderableWidget(
            key: _key2,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key2);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(
                    PagePaths.CREATE_APPOINTMENT,
                    queryParameters: {
                      'forOnline': true.toString(),
                      'fromSearch': false.toString(),
                      'fromSymptom': false.toString(),
                    },
                  );
                }
              },
              child: Consumer<LocaleNotifier>(
                builder: (context, vm, child) {
                  return VerticalCard(
                    title: LocaleProvider.current.take_video_appointment,
                    painter: HomeOnlineAppointmentCustomPainter(),
                  );
                },
              ),
            ),
          ),

        //
        if (getIt<AppConfig>().chronicTracking)
          MyReorderableWidget(
            key: _key3,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key3);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(PagePaths.MEASUREMENT_TRACKING);
                }
              },
              child: Consumer<LocaleNotifier>(
                builder: (context, vm, child) {
                  return VerticalCard(
                    title: LocaleProvider.current.chronic_track_home,
                    painter: HomeChronicTrackingCustomPainter(),
                  );
                },
              ),
            ),
          ),

        //
        MyReorderableWidget(
          key: _key4,
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(_key4);
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.APPOINTMENTS);
              }
            },
            child: Consumer<LocaleNotifier>(
              builder: (context, vm, child) {
                return VerticalCard(
                  title: LocaleProvider.current.appointments,
                  painter: HomeAppointmentsCustomPainter(),
                );
              },
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: key5,
          body: HomeSlider(),
        ),

        //
        MyReorderableWidget(
          key: _key6,
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(_key6);
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.ERESULT);
              }
            },
            child: Consumer<LocaleNotifier>(
              builder: (context, vm, child) {
                return VerticalCard(
                  title: LocaleProvider.current.results,
                  painter: HomeResultsCustomPainter(),
                );
              },
            ),
          ),
        ),

        //
        if (getIt<AppConfig>().symptomChecker)
          MyReorderableWidget(
            key: _key7,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key7);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
                }
              },
              child: Consumer<LocaleNotifier>(
                builder: (context, vm, child) {
                  return VerticalCard(
                    title: LocaleProvider.current.symptom_checker,
                    painter: HomeSymptomCheckerCustomPainter(),
                  );
                },
              ),
            ),
          ),
      ];

  void openConsultation() {
    Atom.to(PagePaths.CONSULTATION);
  }
}

extension ShakeModExt on ShakeMod {
  ShakeMod toggle() {
    if (this == ShakeMod.shaken) {
      return ShakeMod.notShaken;
    } else {
      return ShakeMod.shaken;
    }
  }

  bool get isShaken {
    return this == ShakeMod.shaken;
  }
}
