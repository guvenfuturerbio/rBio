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
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> stream;
  String? code;
  String? errorText;
  String? videoId;
  String ?uid;
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
    _logMessagesSub.cancel();
    super.dispose();
  }

  String listenFirestore() {
    stream = FirebaseFirestore.instance
        .collection("/iyzico")
        .doc(uid)
        .snapshots()
        .listen((event) {
      if (event.data() != null && event.data()?['code'] != "99") {
        String userName = parseJwtPayLoad(getIt<ISharedPreferencesManager>()
            .get(SharedPreferencesKeys.jwtToken))['name'];
        errorText = event.data()?['errorText'];
        videoId = event.data()?['videoId'];
        code = event.data()?['code'];
        Atom.to(PagePaths.main, isReplacement: true);

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
      code = args[0] as String;
      errorText = args[1] as String;
      videoId = args[2] as String;
    }
    {}
  }

  void _httpClientCreateCallback(Client httpClient) {
    HttpOverrides.global = HttpOverrideCertificateVerificationInDev();
  }
}

class HttpOverrideCertificateVerificationInDev extends HttpOverrides {
  @override
  Future<HttpClient> createHttpClient(SecurityContext context) async => super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
}
