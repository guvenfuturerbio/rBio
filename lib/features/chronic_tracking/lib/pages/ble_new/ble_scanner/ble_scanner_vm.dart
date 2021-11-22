import 'package:flutter/material.dart';
import 'package:get/get.dart' as dialog;

import '../../../../../../core/core.dart';
import '../../../../../../generated/l10n.dart';
import '../../../helper/progress_state_dialog.dart';
import '../../../locator.dart';
import '../../../notifiers/ble_operators/ble_connector.dart';
import '../../../notifiers/ble_operators/ble_reactor.dart';

class BleScannerVm extends ChangeNotifier {
  BuildContext mContext;
  bool _disposed = false;
  bool _connectIsActive = true;
  bool _isDialogActive = false;
  BleScannerVm({BuildContext context}) {
    this.mContext = context;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!_disposed) {
        locator<BleReactorOps>().addListener(() {
          if (locator<BleReactorOps>().controlPointResponse.isNotEmpty) {
            if (!dialog.Get.isDialogOpen) {
              showLoadingDialog();
            }
            locator<BleConnectorOps>()
                .disconnect(locator<BleConnectorOps>().device.id);
          }
        });
      }
    });
  }

  connectClicked() async {
    this._connectIsActive = false;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    this._connectIsActive = true;
    notifyListeners();
  }

  bool get connectIsActive => this._connectIsActive;

  showLoadingDialog() {
    showDialog(
            context: mContext,
            barrierDismissible: false,
            builder: (BuildContext context) => ProgressStateDialog(
                  image: R.image.guven_logo,
                  text: LocaleProvider.current.pair_successful,
                ))
        .then((value) => locator<BleReactorOps>().clearControlPointResponse());
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
