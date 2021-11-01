import 'package:atom/atom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../view/home_screen.dart';
import '../widgets/card_widget.dart';
import '../widgets/reorderable_widget.dart';
import '../widgets/vertical_card_widget.dart';

class ListItemVm extends ChangeNotifier {
  final BuildContext mContext;
  double startAngle = 0;
  double endAngle = 0;
  ShakeMod status = ShakeMod.notShaken;
  //TODO : WİDGET EKLEME İŞLEMİ HENÜZ GERÇEKLEŞTİRİLMEDİ.
  List<Widget> widgetsInUse = [];
  List<Widget> widgetsDeleted = [];
  SpringController springController;

  ListItemVm({this.mContext}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      springController = SpringController(initialAnim: Motion.mirror);
      widgetsInUse = widgets();
      notifyListeners();
    });
  }

  void removeWidget(Key widgetKey) {
    for (var element in widgetsInUse) {
      if (element.key == widgetKey) {
        widgetsDeleted.add(element);
      }
    }
    widgetsInUse.removeWhere((element) => widgetsDeleted.contains(element));
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    Widget row = widgetsInUse.removeAt(oldIndex);
    widgetsInUse.insert(newIndex, row);
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

  void addItem() {
    Atom.show(
      GestureDetector(
        onTap: () {
          Atom.dismiss();
        },
        child: Container(
          color: Colors.black12.withOpacity(0.8),
          child: Consumer<ListItemVm>(
            builder: (_, val, __) => SizedBox.expand(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  //alignment: WrapAlignment.center,
                  spacing: 0,
                  runSpacing: 0,
                  children: widgetsDeleted,
                ),
                ElevatedButton(
                  onPressed: () => Atom.dismiss(),
                  child: const Text(
                    'Dismiss',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  List<Widget> widgets() => <Widget>[
        MyReorderableWidget(
          key: const Key('1'),
          body: CustomCard.getImageSquare(
            "assets/images/asd.png",
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Ergün Yunus Cengiz",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Atom.height * 0.07,
            Atom.height * 0.07,
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 25,
            ),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('2'),
          body: VerticalCard.topImage(
            bottomTitle:
                const Text("Hastane Randevusu", style: TextStyle(fontSize: 18)),
            topImg: "assets/images/top_left.png",
            height: Atom.height * .25,
            width: Atom.width * .3,
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('3'),
          body: VerticalCard.topImage(
              bottomTitle: const Text("Görüntülü Görüşme Randevusu",
                  style: TextStyle(fontSize: 18)),
              topImg: "assets/images/top_mid.png",
              height: Atom.height * .25,
              width: Atom.width * .3),
        ),

        //
        MyReorderableWidget(
          key: const Key('4'),
          body: VerticalCard.topImage(
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

        //
        MyReorderableWidget(
          key: const Key('5'),
          body: SizedBox(
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
                )),
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('6'),
          body: VerticalCard.topImage(
            bottomTitle: const Text(
              "Randevular",
              style: TextStyle(fontSize: 18),
            ),
            topImg: "assets/images/bottom_left.png",
            height: Atom.height * .25,
            width: Atom.width * .3,
          ),
        ),

        //
        MyReorderableWidget(
          key: const Key('7'),
          body: VerticalCard.topImage(
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

        //
        MyReorderableWidget(
          key: const Key('8'),
          body: VerticalCard.topImage(
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
