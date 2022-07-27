import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../config/config.dart';
import '../core/core.dart';
import '../core/theme/theme_cubit.dart';

class AtomApp extends StatelessWidget {
  final bool jailbroken;
  final String initialRoute;
  final ThemeNotifier themeNotifier;

  const AtomApp({
    Key? key,
    required this.jailbroken,
    required this.initialRoute,
    required this.themeNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AtomMaterialApp(
      initialUrl: jailbroken == true ? PagePaths.jailbroken : initialRoute,
      routes: VRouterRoutes.routes(getIt<IAppConfig>()),
      onPop: (vRedirector) async {},
      onSystemPop: (data) async {
        if (Atom.isDialogShow) {
          try {
            Atom.dismiss();
            data.stopRedirection();
          } catch (e, stackTrace) {
            LoggerUtils.instance.i(e);
            getIt<IAppConfig>()
                .platform
                .sentryManager
                .captureException(e, stackTrace: stackTrace);
          }
        } else {
          final currentUrl = data.fromUrl ?? "";
          if (currentUrl.contains('/home')) {
            SystemNavigator.pop();
          } else if (data.historyCanBack()) {
            data.historyBack();
          }
        }
      },

      //
      title: getIt<IAppConfig>().title,
      debugShowCheckedModeBanner: false,
      navigatorObservers: const [],
      showPerformanceOverlay: false,

      //
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: themeNotifier.textScale.getValue(),
            ),
            child: child!,
          ),
        );
      },

      //
      theme: _getTheme(context),

      //
      locale: context.watch<LocaleNotifier>().current,
      localizationsDelegates: const [
        LocaleProvider.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: context.read<LocaleNotifier>().supportedLocales,
    );
  }

  ThemeData? _getTheme(BuildContext context) {
    final _currentTheme = context.watch<ThemeCubit>().state;

    return ThemeData(
      brightness: _currentTheme.brightness,
      fontFamily: _currentTheme.fontFamily,
      textTheme: _currentTheme.textTheme,
      primaryColor: _currentTheme.primaryColor,
      scaffoldBackgroundColor: _currentTheme.scaffoldBackgroundColor,

      // * ColorScheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: _currentTheme.primaryColor,
        brightness: _currentTheme.brightness,
      ).copyWith(
        secondary: _currentTheme.secondaryColor,
        primary: _currentTheme.textColor,
        inversePrimary: _currentTheme.inverseTextColor,
        onPrimary: _currentTheme.onPrimaryTextColor,
        secondaryContainer: _currentTheme.secondaryContainerColor,
      ),

      // * CardTheme
      cardTheme: const CardTheme().copyWith(
        elevation: R.sizes.defaultElevation,
        color: _currentTheme.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
      ),

      // * AppBarTheme
      appBarTheme: AppBarTheme(
        backgroundColor: _currentTheme.appbarColor,
        titleTextStyle: _currentTheme.textTheme.headline1?.copyWith(
          color: _currentTheme.appbarTextColor,
          fontWeight: FontWeight.w400,
        ),
        iconTheme: IconThemeData(
          color: _currentTheme.appbarIconColor,
        ),
      ),

      // * BottomNavigationBarTheme
      bottomNavigationBarTheme: _currentTheme.bottomNavigationBarTheme,

      // * IconTheme
      iconTheme: _currentTheme.iconTheme,

      // * FloatingActionButtonTheme
      floatingActionButtonTheme: _currentTheme.floatingActionButtonTheme,

      // * TextSelectionTheme
      textSelectionTheme: _currentTheme.textSelectionTheme,

      // * CupertinoTheme
      cupertinoOverrideTheme: _currentTheme.cupertinoTheme,

      // * DialogTheme
      dialogTheme: DialogTheme(
        backgroundColor: _currentTheme.cardBackgroundColor,
      ),

      // * TextButtonTheme
      // * ElevatedButtonTheme
      // * OutlinedButtonTheme
      // * InputDecorationTheme
      // * BottomSheetTheme
      // * CheckboxTheme
      // * DividerTheme
    )..addCustomTheme(_currentTheme.myCustomTheme);
  }
}
