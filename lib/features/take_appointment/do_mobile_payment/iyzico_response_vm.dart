import 'dart:async';
import 'dart:io';

import 'package:atom/atom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/src/client.dart';
import 'package:logging/logging.dart';

import '../../../core/enums/shared_preferences_keys.dart';
import '../../../core/locator.dart';
import '../../../core/manager/shared_preferences_manager.dart';
import '../../../core/navigation/app_paths.dart';
import '../../../core/utils/jwt_token_parser.dart';
import '../../../core/widgets/gradient_dialog_for_payment_dialog.dart';
import '../../../generated/l10n.dart';

class IyzicoResponseVm with ChangeNotifier {
  // Properties
  String _serverUrl = "https://api.guven.com.tr/cerebrumplushub";
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> stream;
  bool connectionIsOpen;
  String code;
  String errorText;
  String videoId;
  String uid;
  Logger _logger;
  StreamSubscription<LogRecord> _logMessagesSub;
  
  IyzicoResponseVm(this.uid) {
    listenFirestore();
  }

  void _handleLogMessage(LogRecord msg) {
    print(msg.message);
  }

  @override
  void dispose() {
    stream.cancel();
    _logMessagesSub?.cancel();
    super.dispose();
  }

  String listenFirestore() {
    stream = FirebaseFirestore.instance
        .collection("/iyzico")
        .doc(uid)
        .snapshots()
        .listen((event) {
      if (event.data() != null && event.data()['code'] != "99") {
        String userName = parseJwtPayLoad(getIt<ISharedPreferencesManager>()
            .get(SharedPreferencesKeys.JWT_TOKEN))['name'];
        errorText = event.data()['errorText'];
        videoId = event.data()['videoId'];
        code = event.data()['code'];
        Atom.to(PagePaths.MAIN, isReplacement: true);

        if (code == "13") {
          Atom.show(GradientDialogForPaymentDialog(
            LocaleProvider.current.payment_successful,
            videoId,
            code,
            userName,
          ));
        } else {
          Atom.show(GradientDialogForPaymentDialog(
            LocaleProvider.current.payment_not_successful,
            videoId,
            code,
            userName,
          ));
        }
      }
    });
  }

  void _handleMessage(List<Object> args) {
    {
      print('Message came from the channel');
      code = args[0];
      errorText = args[1];
      videoId = args[2];
    }
    {}
  }

  void _httpClientCreateCallback(Client httpClient) {
    HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
  }
}

class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
