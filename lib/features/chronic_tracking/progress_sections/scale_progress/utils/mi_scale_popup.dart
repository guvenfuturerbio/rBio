import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../../lib/core/utils/loading/progress_circle.dart';
import '../../../lib/database/datamodels/scale_data.dart';
import '../../../lib/database/repository/scale_repository.dart';
import '../../../lib/helper/resources.dart';
import '../../../lib/locator.dart';
import '../../../lib/notifiers/ble_operators/ble_reactor.dart';

class MiScalePopUp extends StatelessWidget {
  final bool hasAlreadyPair;
  const MiScalePopUp({Key key, this.hasAlreadyPair = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: R.color.dark_blue,
          height: context.HEIGHT,
          width: context.WIDTH,
          child: Consumer<BleReactorOps>(builder: (_, _bleReactor, __) {
            ScaleModel data = _bleReactor.scaleDevice.scaleData;
            return hasAlreadyPair
                ? _scaleStep(_bleReactor, context, data)
                : _pairingStep(_bleReactor, context);
          })),
    );
  }

  Column _scaleStep(
      BleReactorOps _bleReactor, BuildContext context, ScaleModel data) {
    return _bleReactor.scaleDevice != null ||
            _bleReactor.scaleDevice.scaleData != null
        ? Column(
            children: [
              Expanded(
                child: Center(child: getMeasurementStatus(context, data)),
              ),
              if (data.measurementComplete && data.impedance != 0)
                Expanded(
                    child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5,
                    crossAxisCount: 2,
                  ),
                  children: [
                    textItem(
                        '${LocaleProvider.current.scale_data_bmi}: ${data.getBMI().toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_body_fat}: ${data.getBodyFat().toStringAsFixed(2)} ${data.getUnit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_bone_mass}: ${data.getBoneMass().toStringAsFixed(2)} ${data.getUnit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_muscle}: ${data.getMuscle().toStringAsFixed(2)} ${data.getUnit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_visceral_fat}: ${data.getVisceralFat().toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_water}: ${data.getWater().toStringAsFixed(2)}%')
                  ],
                )),
              Text(
                data.weightStabilized
                    ? data.measurementComplete
                        ? '${LocaleProvider.current.ble_scale_weight_info}'
                        : '${LocaleProvider.current.ble_scale_stabilizing_info}'
                    : '${LocaleProvider.current.ble_scale_weight_calculating_info}',
                style: TextStyle(color: R.color.white),
              ),
              SizedBox(
                height: context.HEIGHT * 0.1,
                child: _bleReactor.scaleDevice.scaleData.measurementComplete
                    ? Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: R.color.white),
                                onPressed: () {
                                  _bleReactor.scaleDevice.scaleData = null;
                                  Navigator.pop(context, 'dialog');
                                },
                                child: Text(
                                    '${LocaleProvider.current.close.toUpperCase()}')),
                          ),
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: R.color.white),
                                onPressed: () async {
                                  print(_bleReactor.scaleDevice.scaleData
                                      .toMap()
                                      .toString());
                                  await ScaleRepository().addNewScaleData(
                                      _bleReactor.scaleDevice.scaleData, false);
                                  _bleReactor.scaleDevice.scaleData = null;
                                  Navigator.pop(context, 'dialog');
                                },
                                child: Text(
                                    '${LocaleProvider.current.save.toUpperCase()}')),
                          ),
                        ],
                      )
                    : SizedBox(),
              )
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Container(
                  child:
                      Text('${LocaleProvider.current.ble_scale_scaling_info}'),
                ),
              ),
            ],
          );
  }

  Stack getMeasurementStatus(BuildContext context, ScaleModel data) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.weight.toString(),
              style: TextStyle(
                  color: R.color.white, fontSize: context.TEXTSCALE * 32),
            ),
            Text(
              data.getUnit,
              style: TextStyle(
                  color: R.color.white, fontSize: context.TEXTSCALE * 32),
            )
          ],
        ),
        ProgressCircle(
          size: context.HEIGHT * .5,
          color: R.color.white,
        ),
      ],
    );
  }

  Column _pairingStep(BleReactorOps _bleReactor, BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                _bleReactor.scaleDevice.scaleData.measurementComplete
                    ? SizedBox()
                    : ProgressCircle(
                        size: context.HEIGHT * .5, color: R.color.white),
                Text(
                    _bleReactor.scaleDevice.scaleData.measurementComplete
                        ? LocaleProvider.current.pair_successful
                        : LocaleProvider.current.pairing,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: R.color.white,
                        fontSize: _bleReactor
                                .scaleDevice.scaleData.measurementComplete
                            ? context.TEXTSCALE * 25
                            : null)),
              ],
            )),
        _bleReactor.scaleDevice.scaleData.measurementComplete
            ? Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(primary: R.color.white),
                          onPressed: () {
                            _bleReactor.scaleDevice.scaleData = null;
                            _bleReactor.scaleDevice.scaleData = null;
                            locator<BleReactorOps>()
                                .clearControlPointResponse();
                            Navigator.pop(context, 'dialog');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.HOME_PAGE,
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                              '${LocaleProvider.current.done.toUpperCase()}')),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Text textItem(String data) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(color: R.color.white),
    );
  }
}
