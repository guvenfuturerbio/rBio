part of 'atom.dart';

class AtomMaterialApp extends StatelessWidget {
  final String initialUrl;
  final String title;
  final List<VRouteElement> routes;
  final bool debugShowCheckedModeBanner;
  final ThemeData theme;
  final List<NavigatorObserver> navigatorObservers;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Widget Function(BuildContext context, Widget child) builder;

  const AtomMaterialApp({
    Key key,
    @required this.initialUrl,
    @required this.builder,
    @required this.routes,
    this.title,
    this.debugShowCheckedModeBanner,
    this.theme,
    this.navigatorObservers,
    this.localizationsDelegates = const [],
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VRouter(
      logs: VLogs.info,
      mode: VRouterMode.history,
      initialUrl: initialUrl,
      routes: routes,
      onPop: (data) async {
        // LoggerUtils.instance.i(data.fromUrl);
        // LoggerUtils.instance.i(data.previousVRouterData.previousUrl);
      },
      onSystemPop: (data) async {
        final currentUrl = data.fromUrl;
        if (currentUrl.contains('/home') && currentUrl.length > 6) {
          data.to(PagePaths.MAIN, isReplacement: true);
        } else if (currentUrl.contains('/home')) {
          SystemNavigator.pop();
        } else if (data.historyCanBack()) {
          data.historyBack();
        }
      },
      buildTransition: (
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child,
      ) =>
          FadeTransition(opacity: animation1, child: child),

      //
      builder: (BuildContext context, Widget child) {
        Atom.instance.setContext(context);
        return builder(context, child);
      },

      //
      title: title,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      theme: theme,
      navigatorObservers: navigatorObservers,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
    );
  }
}
