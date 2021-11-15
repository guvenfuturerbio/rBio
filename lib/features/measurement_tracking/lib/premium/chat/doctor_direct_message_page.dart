import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import '../../helper/resources.dart';

class HelpContactUsPage extends StatefulWidget {
  final String url, title;
  HelpContactUsPage(this.url, this.title);
  @override
  _HelpContactUsPageState createState() => _HelpContactUsPageState();
}

class _HelpContactUsPageState extends State<HelpContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return ListView(
          children: <Widget>[
            Container(
              height: 130,
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      //launch("tel://4449494");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        gradient: LinearGradient(
                            colors: [R.regularBlue, R.color.light_blue],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight),
                        border: Border.all(
                          width: 1,
                          color: R.color.defaultBlue,
                        ),
                      ),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            R.image.ic_phone_call_grey,
                            color: R.color.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            LocaleProvider.current.call_us,
                            style: TextStyle(color: R.color.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      LocaleProvider.current.call_us_message,
                      style:
                          TextStyle(color: R.color.defaultBlue, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 30,
            )
          ],
        );
      }),
    );
  }
}
