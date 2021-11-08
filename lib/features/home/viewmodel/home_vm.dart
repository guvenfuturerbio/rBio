import 'package:atom/atom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../view/home_screen.dart';
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

  SpringController springController;

  HomeVm({this.mContext}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      springController = SpringController(initialAnim: Motion.mirror);
      widgetsInUse = await widgets();
      await fetchWidgets();
      notifyListeners();
    });
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
                  ElevatedButton(
                    onPressed: () {
                      isForDelete = false;
                      notifyListeners();
                      Atom.dismiss();
                    },
                    child: const Text(
                      'Dismiss',
                      style: TextStyle(fontSize: 20),
                    ),
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

  // Tüm widgetları çeken fonks.
  List<Widget> widgets() => <Widget>[
        MyReorderableWidget(
          key: const Key('1'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('1'));
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
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('2'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('2'));
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.CREATE_APPOINTMENT);
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text("Hastane Randevusu",
                  style: TextStyle(fontSize: 18)),
              topImg: "assets/images/top_left.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('3'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('3'));
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text("Görüntülü Görüşme Randevusu",
                  style: TextStyle(fontSize: 18)),
              topImg: "assets/images/top_mid.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('4'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('4'));
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text(
                "Kronik\nTakip",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
              ),
              topImg: "assets/images/top_right.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('5'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('5'));
              }
            },
            child: SizedBox(
              height: Atom.height * .2,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/mid_pic.svg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('6'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('6'));
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.APPOINTMENTS);
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text(
                "Randevular",
                style: TextStyle(fontSize: 18),
              ),
              topImg: "assets/images/bottom_left.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('7'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('7'));
              } else if (status == ShakeMod.notShaken) {
                Atom.to(PagePaths.ERESULT);
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text(
                "Sonuçlar",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              topImg: "assets/images/bottom_mid.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('8'),
          body: GestureDetector(
            onTap: () {
              if (isForDelete) {
                addWidget(Key('8'));
              }
            },
            child: VerticalCard.topImage(
              bottomTitle: const Text(
                "Hangi Bölüme Gitmeliyim",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              topImg: "assets/images/bottom_right.png",
              height: Atom.height * .25,
              width: Atom.width * .3,
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
