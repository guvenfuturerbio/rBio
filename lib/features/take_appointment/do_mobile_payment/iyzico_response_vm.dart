import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

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
        String userName = Utils.instance.parseJwtPayLoad(
            getIt<ISharedPreferencesManager>()
                .get(SharedPreferencesKeys.jwtToken))['name'];
        code = event.data()?['code'];
        Atom.to(PagePaths.main, isReplacement: true);

        if (code == "13") {
          getIt<FirebaseAnalyticsManager>().logEvent(BasariliOdemeEvent());
          Atom.show(
            GradientDialogForPaymentDialog(
              errorText: LocaleProvider.current.payment_successful,
              code: code,
              name: userName,
            ),
          );
        } else {
          Atom.show(
            GradientDialogForPaymentDialog(
              errorText: LocaleProvider.current.payment_not_successful,
              code: code,
              name: userName,
            ),
          );
        }
      }
    });
  }
}
