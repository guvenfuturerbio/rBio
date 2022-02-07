import 'dart:async';

import 'package:atom/atom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/shared_preferences_keys.dart';
import '../../../core/locator.dart';
import '../../../core/manager/shared_preferences_manager.dart';
import '../../../core/navigation/app_paths.dart';
import '../../../core/utils/jwt_token_parser.dart';
import '../../../core/widgets/gradient_dialog_for_payment_dialog.dart';
import '../../../generated/l10n.dart';

class IyzicoResponseVm with ChangeNotifier {
  // Properties
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> stream;
  late String code;
  late String errorText;
  late String videoId;
  late String? uid;

  IyzicoResponseVm(this.uid) {
    listenFirestore();
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  void listenFirestore() {
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
          Atom.show(
            GradientDialogForPaymentDialog(
              errorText: LocaleProvider.current.payment_successful,
              videoId: videoId,
              code: code,
              name: userName,
            ),
          );
        } else {
          Atom.show(
            GradientDialogForPaymentDialog(
              errorText: LocaleProvider.current.payment_not_successful,
              videoId: videoId,
              code: code,
              name: userName,
            ),
          );
        }
      }
    });
  }
}
