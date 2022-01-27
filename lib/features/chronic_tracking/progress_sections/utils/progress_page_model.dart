import 'package:flutter/widgets.dart';

abstract class ProgressPage extends ChangeNotifier {
  Widget smallWidget(Function() callBack);
  Widget largeWidget();
  manuelEntry(BuildContext ctx);
}
