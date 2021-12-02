import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/core.dart';

class GalleryPopUpVm extends ChangeNotifier {
  final BuildContext context;
  GalleryPopUpVm(this.context);

  PhotoViewScaleStateController controller = PhotoViewScaleStateController();
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  close() {
    Atom.dismiss();
  }
}
