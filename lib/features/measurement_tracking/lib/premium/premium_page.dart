import 'package:flutter/material.dart';

import '../helper/resources.dart';

class PremiumPage extends StatefulWidget {
  @override
  _PremiumPage createState() => _PremiumPage();
}

class _PremiumPage extends State<PremiumPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.only(top: 42),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.DOCTOR_DM_CHAT_PAGE);
              },
              child: Container(
                height: 200,
                color: Colors.yellow,
                child: Center(
                  child: Text("Doktor Chat"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.PREMIUM_STORE_PAGE);
              },
              child: Container(
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text("Store"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
