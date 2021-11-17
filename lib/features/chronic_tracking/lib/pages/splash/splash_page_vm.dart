import 'package:flutter/material.dart';

import '../../helper/resources.dart';
import '../../services/user_service.dart';
import '../home/home_page_new/home_page_new.dart';
import '../signup&login/login_page/login_page.dart';

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
      Navigator.of(mContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
        ModalRoute.withName(Routes.HOME_PAGE),
      );
    } catch (e) {
      Navigator.of(mContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (contextTrans) => LoginPage()),
        ModalRoute.withName(Routes.LOGIN_PAGE),
      );
    }
  }
}
