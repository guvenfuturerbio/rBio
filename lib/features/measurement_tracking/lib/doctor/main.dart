/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/doctor/generated/l10n.dart';
import 'package:onedosehealth/doctor/notifiers/bg_measurements_notifiers.dart';
import 'package:onedosehealth/doctor/pages/home_page/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onedosehealth/doctor/pages/login_page/login_page.dart';
import 'package:onedosehealth/doctor/pages/patient_detail_page/patient_detail_page.dart';
import 'package:onedosehealth/doctor/resources/resources.dart';
import 'package:onedosehealth/doctor/notifiers/patient_notifiers.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'notifiers/user_notifiers.dart';


void main() async{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

  _setupLogging();
  Constants.setEnvironment(Environment.PROD);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientNotifiers()),
        ChangeNotifierProvider(create: (context) => UserNotifiers()),
        ChangeNotifierProvider(create: (context) => BgMeasurementsNotifierDoc())
      ],
      child: MyApp(),
    ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'ComicSans',
        primaryColor: R.color.mainColor,
        accentColor: Colors.white,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      supportedLocales: LocaleProvider.delegate.supportedLocales,
      localizationsDelegates: const [
        LocaleProvider.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      routes: {
        Routes.HOME_PAGE: (context) => DoctorHomePage(),
        Routes.PATIENT_DETAIL: (context) => PatientDetailPage()
      },
      navigatorObservers: [routeObserver],
    );
  }
}*/