import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/progress_pages/progress_page_model.dart';
import 'package:provider/provider.dart';

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
        return FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 200), () => true),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? value.largeWidget(deActivateCallBack)
                  : SizedBox();
            });
      },
    );
    smallChild = Consumer<K>(
      builder: (_, value, __) {
        return value.smallWidget(() => activateCallBack(key));
      },
    );
  }
}
