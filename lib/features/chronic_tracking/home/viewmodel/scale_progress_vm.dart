import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../bottom_actions_of_graph.dart';
import '../view/widgets/widgets.dart';

class ScaleProgressVm extends ChangeNotifier
    with IBaseBottomActionsOfGraph
    implements IProgressScreen {
  @override
  void changeGraphType() {}

  @override
  Widget largeWidget() => Container();

  @override
  void manuelEntry(BuildContext context) {}

  @override
  Widget smallWidget(Function() callBack) {
    final scaleEntity = getIt<ScaleRepository>().getLatestMeasurement(
      Utils.instance.getAge(),
      Utils.instance.getGender(),
      Utils.instance.getHeight(),
    );

    return SmallChronicComponent(
      callback: callBack,
      lastMeasurement: scaleEntity == null
          ? LocaleProvider.current.no_measurement
          : '${(scaleEntity.weight ?? 0).xGetFriendyString} ${scaleEntity.getUnit}',
      lastMeasurementDate: scaleEntity?.dateTime ?? DateTime.now(),
      imageUrl: R.image.bodyScale,
    );
  }

  @override
  void changeChartShowStatus() {}

  @override
  void showFilter(BuildContext context) {}
}
