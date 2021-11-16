import 'package:flutter/material.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/notifiers/user_notifiers.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/doctor/pages/home_page/home_page.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/home/home_page/home_page_view.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/home/home_page_new/home_page_new.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/signup&login/login_page/login_page.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/services/user_service.dart';
import 'package:provider/provider.dart';

class SplashPageVm extends ChangeNotifier {
  BuildContext mContext;
  SplashPageVm({BuildContext context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.mContext = context;
      startRouteOps();
    });
  }

  startRouteOps() async {
    try {
      await UserService().handleAutoLogin(mContext);
      var userNotifier = Provider.of<UserNotifiers>(mContext, listen: false);
      if (userNotifier.isDoctor == 'true') {
        Navigator.of(mContext).pushAndRemoveUntil(
          MaterialPageRoute(builder: (contextTrans) => DoctorHomePage()),
          ModalRoute.withName(Routes.DOCTOR_HOME_PAGE),
        );
      } else {
        Navigator.of(mContext).pushAndRemoveUntil(
          MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
          ModalRoute.withName(Routes.HOME_PAGE),
        );
      }
    } catch (e) {
      Navigator.of(mContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (contextTrans) => LoginPage()),
        ModalRoute.withName(Routes.LOGIN_PAGE),
      );
    }
  }
}
