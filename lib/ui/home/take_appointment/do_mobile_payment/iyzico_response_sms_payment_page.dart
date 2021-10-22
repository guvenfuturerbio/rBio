import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/core.dart';

class IyzicoResponseSmsPaymentScreen extends StatefulWidget {
  final String html;

  bool fromDeepLink;
  final String departmentName;
  final String doctorName;
  final String appointmentType;
  final String hospitalName;
  final String appointmentFee;
  final bool fromCovidPcr;

  IyzicoResponseSmsPaymentScreen({
    Key key,
    this.html,
    this.departmentName,
    this.doctorName,
    this.appointmentType,
    this.hospitalName,
    this.appointmentFee,
    this.fromDeepLink = false,
    this.fromCovidPcr = false,
  }) : super(key: key);

  @override
  _IyzicoResponseSmsPaymentScreenState createState() =>
      _IyzicoResponseSmsPaymentScreenState(html);
}

class _IyzicoResponseSmsPaymentScreenState
    extends State<IyzicoResponseSmsPaymentScreen> {
  final String html;

  _IyzicoResponseSmsPaymentScreenState(String formHtml)
      : html = """<html>
        <body onload="document.getElementsByTagName('form')[0].submit();">
          <center><p>Loading...</p></center>
          <div style="opacity: 0">$formHtml</div>
        </body>
        </html>""";

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        var data = message.data;

        try {
          Navigator.of(context).pop();
          String code = data['code'];
          String errorText = data['error_text'];
          String videoId = data['video_id'];
          String userName = parseJwtPayLoad(getIt<ISharedPreferencesManager>()
              .get(SharedPreferencesKeys.JWT_TOKEN))['name'];
          if (code == "13") {
            // Payment successful
            if (widget.fromCovidPcr) {
              AnalyticsManager().sendEvent(new PcrPaymentSuccessEvent(
                  widget.hospitalName, widget.appointmentFee));
            } else {
              AnalyticsManager().sendEvent(new OAPaymentSuccessEvent(
                  widget.departmentName,
                  widget.doctorName,
                  widget.appointmentType,
                  widget.hospitalName,
                  widget.appointmentFee));
            }
          }
          showGradientDialog(context, code, errorText, videoId, userName);
        } catch (e) {
          print(e);
        }
        return;
      },
    );

    return Scaffold(
      appBar: MainAppBar(context: context, leading: ButtonBackWhite(context)),
      body: kIsWeb
          ? HtmlElementView(
              viewType: "PayPalButtons",
            )
          : WebView(
              initialUrl: Uri.dataFromString(
                html,
                mimeType: 'text/html',
              ).toString(),
              javascriptMode: JavascriptMode.unrestricted,
            ),
    );
  }

  void showGradientDialog(
    BuildContext context,
    String code,
    String errorText,
    String videoId,
    String userName,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialogForPaymentDialog(
          errorText,
          videoId,
          code,
          userName,
        );
      },
    );
  }
}
