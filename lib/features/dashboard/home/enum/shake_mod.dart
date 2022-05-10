part of '../view/home_screen.dart';

enum ShakeMod {
  shaken,
  notShaken,
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
