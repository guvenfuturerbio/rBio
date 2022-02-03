import 'package:flutter/material.dart';

import '../core.dart';

class LoadingDialog extends StatefulWidget {
  LoadingDialogState? state;

  bool isShowing() {
    if (state != null) {
      if (state!.mounted) {
        return true;
      }
    }

    return false;
  }

  @override
  createState() => state = LoadingDialogState();
}

class LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: RbioLoading(),
    );
  }
}
