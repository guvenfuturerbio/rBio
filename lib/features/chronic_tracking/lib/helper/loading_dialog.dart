import 'package:flutter/material.dart';

import 'resources.dart';

class LoadingDialog extends StatefulWidget {
  static _LoadingDialogState state;

  bool isShowing() {
    return state != null && state.mounted;
  }

  @override
  createState() => state = _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(R.color.dark_blue),
      ),
    );
  }
}
