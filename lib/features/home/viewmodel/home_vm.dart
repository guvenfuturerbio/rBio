import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../../../core/core.dart';
import '../../../core/notifiers/user_notifier.dart';
import '../model/banner_model.dart';
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

  HomeVm({this.mContext});

  Future<void> init() async {
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) async {
        springController = SpringController(initialAnim: Motion.mirror);
        widgetsInUse = await widgets();
        await fetchWidgets();
        bannerTabsModel =
            await getIt<Repository>().getBannerTab('rBio', 'anaSayfa');
        notifyListeners();
        try {
          print("BURDAYIM");
          getIt<SymptomRepository>().getSymtptomsApiToken();
        } catch (e) {
          print(e);
        }
      });
    }
  }

  // Uygulama ilk açıldığında, silinmiş widgetların keylerini tutan veriyi shared preferences içinden çekip kullanılan widget listesini dolduran method.
  fetchWidgets() {
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
      if (getIt<ISharedPreferencesManager>()
          .containsKey(SharedPreferencesKeys.WIDGET_QUERY)) {
        queryOfWidgetsInUse = getIt<ISharedPreferencesManager>()
            .getStringList(SharedPreferencesKeys.WIDGET_QUERY);
        Map<String, Widget> myMap = widgetMap();
        widgetsInUse.clear();
        queryOfWidgetsInUse.forEach((element) {
          widgetsInUse.add(myMap[element]);
        });
      }
    }
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
    for (var elementO in widgetsDeleted) {
      if (elementO.key == widgetKey) {
        widgetsInUse.add(elementO);
        deletedKeysHolder
            .removeWhere((element) => element == elementO.key.toString());
      }
    }
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
    Widget row = widgetsInUse.removeAt(oldIndex);
    await widgetsInUse.insert(newIndex, row);
    await querySaver();
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
        color: Colors.black12.withOpacity(0.8),
        child: Consumer<HomeVm>(
          builder: (BuildContext context, HomeVm val, Widget child) {
            return SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 0,
                    children: widgetsDeleted,
                  ),
                  RbioElevatedButton(
                    onTap: () {
                      isForDelete = false;
                      notifyListeners();
                      Atom.dismiss();
                    },
                    title: 'Dismiss',
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
      "[<'8'>]": returner[7],
    };
  }

  final _key1 = const Key('1');
  final _key2 = const Key('2');
  final _key3 = const Key('3');
  final _key4 = const Key('4');
  final key5 = const Key('5');
  final _key6 = const Key('6');
  final _key7 = const Key('7');
  final _key8 = const Key('8');
  final _key9 = const Key('9');

  // Tüm widgetları çeken fonks.
  List<Widget> widgets() => <Widget>[
        MyReorderableWidget(
          key: _key1,
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(_key1);
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.PROFILE);
              }
            },
            child: RbioUserTile(
              name:
                  '${PatientSingleton().getPatient().firstName} ${PatientSingleton().getPatient().lastName}',
              leadingImage: UserLeadingImage.Circle,
              trailingIcon: UserTrailingIcons.RightArrow,
              onTap: () {
                Atom.to(PagePaths.PROFILE);
              },
              width: Atom.width,
            ),
          ),
        ),

        //
        Visibility(
          visible: getIt<UserNotifier>().isDoctor,
          child: MyReorderableWidget(
            key: _key9,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key9);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(PagePaths.DOCTOR_HOME);
                }
              },
              child: RbioUserTile(
                name: LocaleProvider.current.doctor,
                leadingImage: UserLeadingImage.Circle,
                trailingIcon: UserTrailingIcons.RightArrow,
                onTap: () {
                  Atom.to(PagePaths.DOCTOR_HOME);
                },
                width: Atom.width,
              ),
            ),
          ),
        ),

        //
        if (getIt<AppConfig>().takeHospitalAppointment)
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
                      'forOnline': false.toString(),
                    },
                  );
                }
              },
              child: VerticalCard(
                topImage: R.image.homeTopLeft,
                bottomTitle: Text(
                  LocaleProvider.current.lbl_find_hospital,
                  style: getIt<ITheme>().textTheme.headline2,
                ),
              ),
            ),
          ),

        //
        if (getIt<AppConfig>().takeOnlineAppointment)
          MyReorderableWidget(
            key: _key3,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key3);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(
                    PagePaths.CREATE_APPOINTMENT,
                    queryParameters: {
                      'forOnline': true.toString(),
                    },
                  );
                }
              },
              child: VerticalCard(
                topImage: R.image.homeTopMid,
                bottomTitle: Text(
                  LocaleProvider.current.take_video_appointment,
                  style: getIt<ITheme>().textTheme.headline2,
                ),
              ),
            ),
          ),

        //
        if (getIt<AppConfig>().chronicTracking)
          MyReorderableWidget(
            key: _key4,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key4);
                } else if (status == ShakeMod.notShaken) {
                  getIt<UserNotifier>().isCronic
                      ? Atom.to(PagePaths.MEASUREMENT_TRACKING)
                      : Atom.show(GuvenAlert(
                          backgroundColor: getIt<ITheme>().cardBackgroundColor,
                          title: GuvenAlert.buildTitle(
                              "Kronik takip özelliğini kullanmak için lütfen ${LocaleProvider.current.phone_guven} numarasını arayınız"),
                          actions: [
                            GuvenAlert.buildMaterialAction(
                                LocaleProvider.current.ok, () {
                              Atom.dismiss();
                            })
                          ],
                        ));
                }
              },
              child: VerticalCard(
                topImage: R.image.homeTopRight,
                bottomTitle: Text(
                  LocaleProvider.current.chronic_track_home,
                  textAlign: TextAlign.start,
                  style: getIt<ITheme>().textTheme.headline2,
                ),
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
                Atom.to(PagePaths.APPOINTMENTS);
              }
            },
            child: VerticalCard(
              topImage: R.image.homeBottomLeft,
              bottomTitle: Text(
                LocaleProvider.current.appointments,
                style: getIt<ITheme>().textTheme.headline2,
              ),
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: _key7,
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(_key7);
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.ERESULT);
              }
            },
            child: VerticalCard(
              topImage: R.image.homeBottomMid,
              bottomTitle: Text(
                LocaleProvider.current.results,
                style: getIt<ITheme>().textTheme.headline2,
              ),
            ),
          ),
        ),

        //
        if (getIt<AppConfig>().symptomChecker)
          MyReorderableWidget(
            key: _key8,
            body: GestureDetector(
              onTap: () {
                if (isForDelete) {
                  addWidget(_key8);
                } else if (status == ShakeMod.notShaken) {
                  Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
                }
              },
              child: VerticalCard(
                topImage: R.image.homeBottomRight,
                bottomTitle: Text(
                  LocaleProvider.current.symptom_checker,
                  style: getIt<ITheme>().textTheme.headline2,
                ),
              ),
            ),
          ),
      ];
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
