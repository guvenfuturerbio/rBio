import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/user_notifier.dart';
import 'home/home_page_new/home_page_new.dart';
import 'signup&login/login_page/login_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(builder: (context, value, child) {
      //print(value.state.toString());
      if (value.user != null) {
        return HomePageNew();
      } else
        return LoginPage();
    });
  }
}
