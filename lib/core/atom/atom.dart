import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrouter/src/core/extended_context.dart';
import 'package:vrouter/vrouter.dart';

import '../navigation/app_paths.dart';

part 'atom_extensions.dart';
part 'atom_material_app.dart';

class Atom {
  Atom._();

  static Atom _instance;

  static Atom get instance {
    _instance ??= Atom._();
    return _instance;
  }

  // ------------ ------------ ------------

  BuildContext ctx;
  void setContext(BuildContext newContext) {
    ctx = newContext;
  }

  static BuildContext get context => Atom.instance.ctx;

  // UI
  static bool get isWeb => Atom.instance.isWeb;
  static bool get isDebugMode => Atom.instance.isDebugMode;
  static bool get isProfileMode => Atom.instance.isProfileMode;
  static bool get isReleaseMode => Atom.instance.isReleaseMode;

  static bool get isAndroid => Atom.instance.isAndroid;
  static bool get isFuchsia => Atom.instance.isFuchsia;
  static bool get isIOS => Atom.instance.isIOS;
  static bool get isLinux => Atom.instance.isLinux;
  static bool get isMacOS => Atom.instance.isMacOS;
  static bool get isWindows => Atom.instance.isWindows;

  static Size get size => Atom.instance.size;
  static double get height => Atom.instance.height;
  static double get width => Atom.instance.width;
  static get devicePixelRatio => Atom.instance.pixelRatio;
  static get textScaleFactor => Atom.instance.textScaleFactor;
  static get isDarkMode => Atom.instance.isDarkMode;
  static get isPlatformDarkMode => Atom.instance.isPlatformDarkMode;
  static ThemeData get theme => Atom.instance.theme;

  // Navigation
  static void to(
    String path, {
    Map<String, String> queryParameters = const {},
    String hash = '',
    Map<String, String> historyState = const {},
    isReplacement = false,
  }) =>
      context.vRouter.to(
        path,
        queryParameters: queryParameters,
        hash: hash,
        historyState: historyState,
        isReplacement: isReplacement,
      );

  static void pop({
    Map<String, String> pathParameters = const {},
    Map<String, String> queryParameters = const {},
    String hash = '',
    Map<String, String> newHistoryState = const {},
  }) {
    context.vRouter.pop(
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      hash: hash,
      newHistoryState: newHistoryState,
    );
  }

  static String get url => context.vRouter.url;

  static void historyBack() => context.vRouter.historyBack();

  static Map<String, String> get queryParameters =>
      context.vRouter.queryParameters;
}
