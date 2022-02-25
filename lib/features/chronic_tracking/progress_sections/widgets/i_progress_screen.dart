import 'package:flutter/widgets.dart';

abstract class IProgressScreen extends ChangeNotifier {
  Widget smallWidget(Function() callBack);
  Widget largeWidget();
  manuelEntry(BuildContext ctx);
}
