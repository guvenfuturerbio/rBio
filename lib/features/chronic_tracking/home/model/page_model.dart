import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../progress_sections/utils/progress_page_model.dart';

class HomePageModel<K extends ProgressPage> {
  final String? title;
  final Color? color;
  final Key key;
  Widget? largeChild;
  Widget? smallChild;
  final Function(Key key) activateCallBack;
  final Function()? deActivateCallBack;
  Function()? manuelEntry;

  HomePageModel(
    this.key,
    this.activateCallBack, {
    this.title,
    this.color,
    this.deActivateCallBack,
  }) {
    largeChild = Consumer<K>(
      builder: (ctx, value, __) {
        manuelEntry = () => value.manuelEntry(ctx);
        return value.largeWidget();
      },
    );
    smallChild = Consumer<K>(
      builder: (_, value, __) {
        return value.smallWidget(() => activateCallBack(key));
      },
    );
  }
}
