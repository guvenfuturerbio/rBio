import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vrouter/vrouter.dart';

import 'atom_overlay.dart';
import 'atom_extensions.dart';

part 'atom_base_dialog.dart';

class Atom extends IAtomOverlay {
  Atom._();

  static Atom? _instance;

  static Atom get instance {
    _instance ??= Atom._();
    return _instance!;
  }

  // ------------ ------------ ------------

  late BuildContext ctx;
  void setContext(BuildContext newContext) {
    ctx = newContext;
    _setValues();
  }

  void _setValues() {
    Atom.safeTop = mediaQuery.padding.top;
    Atom.safeBottom = mediaQuery.padding.bottom;
    Atom.safeLeft = mediaQuery.padding.left;
    Atom.safeRight = mediaQuery.padding.right;
  }

  static BuildContext get context => Atom.instance.ctx;

  static TransitionBuilder builder({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(
          context,
          AtomOverlay(
            baseOverlay: Atom.instance,
            backgroundChild: child,
          ),
        );
      } else {
        return AtomOverlay(
          baseOverlay: Atom.instance,
          backgroundChild: child,
        );
      }
    };
  }

  // ************************** **************************

  // #region Getters
  static bool get isWeb => Atom.instance.isWeb;
  static bool get isDebugMode => Atom.instance.isDebugMode;
  static bool get isProfileMode => Atom.instance.isProfileMode;
  static bool get isReleaseMode => Atom.instance.isReleaseMode;

  static double safeTop = 0;
  static double safeBottom = 0;
  static double safeLeft = 0;
  static double safeRight = 0;

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
  // #endregion

  // #region Navigation
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
  // #endregion

  // #region Dialog
  @override
  Widget? get w => _w;

  @override
  OverlayEntry? overlayEntry;

  static bool isDialogShow = false;
  Widget? _w;
  GlobalKey<AtomOverlayChildState>? _key;
  GlobalKey<AtomOverlayChildState>? get key => _key;

  static Future<T> show<T>(
    Widget child, {
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
  }) async {
    isDialogShow = true;
    return instance._show<T>(
      _AtomBaseDialog(
        child: child,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
      ),
    ) as Future<T>;
  }

  static void dismiss([dynamic result]) async {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        instance._dismiss(result);
      });
    } else {
      instance._dismiss(result);
    }
  }

  static Completer<dynamic>? dialogCompleter;
  Future _show<T>(Widget child) async {
    assert(instance.overlayEntry != null, 'overlayEntry should not be null');

    var _key = GlobalKey<AtomOverlayChildState>();
    dialogCompleter = Completer<T>();

    instance._w = AtomOverlayChild(
      key: _key,
      animation: true,
      child: child,
    );

    _markNeedsBuild();

    instance._key = _key;

    return dialogCompleter!.future;
  }

  void _dismiss(dynamic result) {
    var loadingContainerState = instance.key?.currentState;
    if (loadingContainerState != null) {
      final completer = Completer<void>();
      loadingContainerState.dismiss(completer);
      completer.future.then((value) {
        _reset();
        dialogCompleter?.complete(result);
        dialogCompleter = null;
      });
      return;
    }
  }

  void _reset() {
    instance._w = null;
    instance._key = null;
    isDialogShow = false;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        instance.overlayEntry?.markNeedsBuild();
      });
    } else {
      instance.overlayEntry?.markNeedsBuild();
    }
  }
  // #endregion
}
