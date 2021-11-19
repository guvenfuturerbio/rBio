import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import '../../extension/size_extension.dart';
import '../../helper/resources.dart';
import 'splash_page_vm.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String text;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => SplashPageVm(context: context),
      child: Consumer<SplashPageVm>(
        builder: (context, value, child) => Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: SvgPicture.asset(R.image.login_screen_bg,
                          fit: BoxFit.fill)),
                  Expanded(child: SizedBox())
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      R.image.guven_logo,
                      height: context.HEIGHT * .3,
                    ),
                    SizedBox(
                      height: context.HEIGHT * 0.06,
                    ),
                    JumpingText(
                      (LocaleProvider.current.loading),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: R.color.white),
                    ),
                    SizedBox(
                      height: context.HEIGHT * 0.1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
