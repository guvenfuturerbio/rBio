import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import 'atom_instance.dart';

class AtomMaterialApp extends StatelessWidget {
  final String title;
  final String initialUrl;
  final List<VRouteElement> routes;
  final bool debugShowCheckedModeBanner;
  final Future<void> Function(VRedirector) onPop;
  final Future<void> Function(VRedirector) onSystemPop;
  final Widget Function(BuildContext context, Widget? child) builder;

  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;

  final Locale? locale;
  final Iterable<Locale> supportedLocales;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;

  final GlobalKey<NavigatorState>? navigatorKey;
  final String Function(BuildContext)? onGenerateTitle;
  final List<NavigatorObserver>? navigatorObservers;

  final Color? color;
  final Map<Type, Action<Intent>>? actions;
  final bool? checkerboardOffscreenLayers;
  final bool? showPerformanceOverlay;
  final bool? checkerboardRasterCacheImages;
  final bool? debugShowMaterialGrid;
  final ScrollBehavior? scrollBehavior;

  const AtomMaterialApp({
    Key? key,
    required this.title,
    required this.initialUrl,
    required this.routes,
    required this.debugShowCheckedModeBanner,
    required this.onPop,
    required this.onSystemPop,
    required this.builder,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.localizationsDelegates = const [],
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.navigatorKey,
    this.onGenerateTitle,
    this.navigatorObservers,
    this.color,
    this.actions,
    this.checkerboardOffscreenLayers,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.debugShowMaterialGrid,
    this.scrollBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VRouter(
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,

      //
      logs: VLogs.info,
      mode: VRouterMode.history,
      initialUrl: initialUrl,
      routes: routes,
      onPop: onPop,
      onSystemPop: onSystemPop,
      buildTransition: (
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child,
      ) =>
          FadeTransition(opacity: animation1, child: child),

      //
      builder: Atom.builder(
        builder: (context, child) {
          Atom.instance.setContext(context);
          return builder(context, child);
        },
      ),

      // Theme
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,

      // Localization
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,

      // Navigation
      navigatorKey: navigatorKey,
      onGenerateTitle: onGenerateTitle,
      navigatorObservers: navigatorObservers ?? const [],

      //
      color: color,
      actions: actions,
      debugShowMaterialGrid: debugShowMaterialGrid ?? false,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers ?? false,
      showPerformanceOverlay: showPerformanceOverlay ?? false,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages ?? false,
      scrollBehavior: scrollBehavior,
    );
  }
}
