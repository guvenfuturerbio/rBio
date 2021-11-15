import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/payment/FcmPaymentResponse.dart';
import 'package:onedosehealth/notification_handler.dart';
import 'package:onedosehealth/pages/home/home_page/home_page_view.dart';
import 'package:onedosehealth/pages/home/home_page_new/home_page_new.dart';
import 'package:onedosehealth/widgets/gradient_dialog.dart';

enum Stage { ERROR, LOADING, DONE }

class PaymentResponsePageViewModel with ChangeNotifier {
  BuildContext context;
  String _html;
  PaymentResponsePageViewModel({BuildContext context, String url}) {
    //_initFirebaseMessaging();
    this.context = context;
    this._html = """<html>
        <body onload="document.getElementsByTagName('form')[0].submit();">
          <p>Loading...</p>
          <div style="opacity: 0">$url</div>
        </body>
        </html>""";
    NotificationHandler().addListener(() {
      Map<dynamic, dynamic> message;
      message = NotificationHandler().message;
      if (Platform.isIOS) {
      } else {
        message = message["data"];
      }
      int type = int.parse(message['type']) ?? 0;
      if (type == 2) {
        int code = int.parse(
            FcmPaymentResponse.fromJson(jsonDecode((message['datum']))).code);
        showPaymentResponse(code);
      }
    });
  }

  String get html => this._html;

  showPaymentResponse(int code) {
    if (code == 0) {
      showInformationDialog(
          text: LocaleProvider.current.iyzico_response_0,
          response: () {
            Navigator.pop(context);
          });
    } else if (code == 9) {
      showInformationDialog(
          text: LocaleProvider.current.iyzico_response_9,
          response: () {
            Navigator.pop(context);
          });
    } else if (code == 10) {
      showInformationDialog(
          text: LocaleProvider.current.iyzico_response_10,
          response: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
                ModalRoute.withName(Routes.HOME_PAGE));
          });
    } else if (code == 13) {
      showInformationDialog(
          text: LocaleProvider.current.iyzico_response_13,
          response: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (contextTrans) => HomePageNew()),
                ModalRoute.withName(Routes.HOME_PAGE));
          });
    } else {
      showInformationDialog(
          text: LocaleProvider.current.sorry_dont_transaction,
          response: () {
            Navigator.pop(context);
          });
    }
  }

  showInformationDialog({String text, Function response}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        }).then((value) => response());
  }
}
