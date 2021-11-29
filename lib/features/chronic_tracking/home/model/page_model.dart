import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../lib/pages/progress_pages/progress_page_model.dart';

class HomePageModel<K extends ProgressPage> {
  final String title;
  final Color color;
  final Key key;
  Widget largeChild;
  Widget smallChild;
  final Function(Key key) activateCallBack;
  final Function() deActivateCallBack;
  Function() manuelEntry;

  HomePageModel({
    this.title,
    this.key,
    this.color,
    this.activateCallBack,
    this.deActivateCallBack,
  }) {
    largeChild = Consumer<K>(
      builder: (ctx, value, __) {
        manuelEntry = () => value.manuelEntry(ctx);
        return value.largeWidget(deActivateCallBack);
      },
    );
    smallChild = Consumer<K>(
      builder: (_, value, __) {
        return value.smallWidget(() => activateCallBack(key));
      },
    );
  }
}
