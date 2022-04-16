import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../progress_sections/widgets/i_progress_screen.dart';

class HomePageModel<K extends IProgressScreen> {
  final String? title;
  final Color? color;
  final Key? key;
  Widget? smallChild;
  final Function(Key key)? activateCallBack;
  final Function()? deActivateCallBack;
  Function()? manuelEntry;

  HomePageModel({
    this.activateCallBack,
    this.key,
    this.title,
    this.color,
    this.deActivateCallBack,
  }) {
    smallChild = Consumer<K>(
      builder: (_, value, __) {
        return value.smallWidget(() => activateCallBack!(key!));
      },
    );
  }
}
