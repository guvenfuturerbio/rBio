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
    return ThemeData(
      brightness: context.watch<ThemeCubit>().state.brightness,
      fontFamily: context.watch<ThemeCubit>().state.fontFamily,
      textTheme: context.watch<ThemeCubit>().state.textTheme,
      primaryColor: context.watch<ThemeCubit>().state.primaryColor,
      scaffoldBackgroundColor:
          context.watch<ThemeCubit>().state.scaffoldBackgroundColor,

      // * ColorScheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: context.watch<ThemeCubit>().state.primaryColor,
        brightness: context.watch<ThemeCubit>().state.brightness,
      ).copyWith(
        secondary: context.watch<ThemeCubit>().state.secondaryColor,
        primary: context.watch<ThemeCubit>().state.textColor,
        inversePrimary: context.watch<ThemeCubit>().state.inverseTextColor,
        onPrimary: context.watch<ThemeCubit>().state.onPrimaryTextColor,
        secondaryContainer:
            context.watch<ThemeCubit>().state.secondaryContainerColor,
      ),

      // * CardTheme
      cardTheme: const CardTheme().copyWith(
        elevation: 0.0,
        color: context.watch<ThemeCubit>().state.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
      ),

      // * AppBarTheme
      appBarTheme: AppBarTheme(
        backgroundColor: context.watch<ThemeCubit>().state.appbarColor,
        titleTextStyle:
            context.watch<ThemeCubit>().state.textTheme.headline1?.copyWith(
                  color: context.watch<ThemeCubit>().state.appbarTextColor,
                  fontWeight: FontWeight.w400,
                ),
        iconTheme: IconThemeData(
          color: context.watch<ThemeCubit>().state.appbarIconColor,
        ),
      ),

      // * BottomNavigationBarTheme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: context.watch<ThemeCubit>().state.bottomMenuColor,
      ),

      // * IconTheme
      iconTheme: IconThemeData(
        color: context.watch<ThemeCubit>().state.iconColor,
      ),

      // * FloatingActionButtonTheme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: context.watch<ThemeCubit>().state.fabBackgroundColor,
      ),

      // * TextSelectionTheme
      textSelectionTheme: context.watch<ThemeCubit>().state.textSelectionTheme,

      // * CupertinoTheme
      cupertinoOverrideTheme: context.watch<ThemeCubit>().state.cupertinoTheme,

      // * DialogTheme
      dialogTheme: const DialogTheme(
          //
          ),
    )..addCustomTheme(
        MyCustomTheme(
          iron: context.watch<ThemeCubit>().state.iron,
          grey: context.watch<ThemeCubit>().state.grey,
          white: context.watch<ThemeCubit>().state.white,
          black: context.watch<ThemeCubit>().state.black,
          punch: context.watch<ThemeCubit>().state.punch,
          roman: context.watch<ThemeCubit>().state.roman,
          malibu: context.watch<ThemeCubit>().state.malibu,
          deYork: context.watch<ThemeCubit>().state.deYork,
          skeptic: context.watch<ThemeCubit>().state.skeptic,
          boulder: context.watch<ThemeCubit>().state.boulder,
          mercury: context.watch<ThemeCubit>().state.mercury,
          codGray: context.watch<ThemeCubit>().state.codGray,
          gallery: context.watch<ThemeCubit>().state.gallery,
          concrete: context.watch<ThemeCubit>().state.concrete,
          supernova: context.watch<ThemeCubit>().state.supernova,
          tonysPink: context.watch<ThemeCubit>().state.tonysPink,
          dustyGray: context.watch<ThemeCubit>().state.dustyGray,
          greenHaze: context.watch<ThemeCubit>().state.greenHaze,
          casablanca: context.watch<ThemeCubit>().state.casablanca,
          frenchPass: context.watch<ThemeCubit>().state.frenchPass,
          kournikova: context.watch<ThemeCubit>().state.kournikova,
          ultramarine: context.watch<ThemeCubit>().state.ultramarine,
          frenchLilac: context.watch<ThemeCubit>().state.frenchLilac,
          textDisabledColor:
              context.watch<ThemeCubit>().state.textDisabledColor,
          energyYellow: context.watch<ThemeCubit>().state.energyYellow,
          cornflowerBlue: context.watch<ThemeCubit>().state.cornflowerBlue,
          fuzzyWuzzyBrown: context.watch<ThemeCubit>().state.fuzzyWuzzyBrown,
        ),
      );
  }
}
