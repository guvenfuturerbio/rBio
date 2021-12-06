import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/ble_operators/ble_operators.dart';
import '../../../../../core/core.dart';
import '../../../../../core/navigation/app_paths.dart';
import '../../../../../generated/l10n.dart';
import 'loading/progress_circle.dart';
import 'scale_measurements/scale_measurement_vm.dart';

class MiScalePopUp extends StatelessWidget {
  final bool hasAlreadyPair;
  const MiScalePopUp({Key key, this.hasAlreadyPair = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: getIt<ITheme>().mainColor,
          height: context.HEIGHT,
          width: context.WIDTH,
          child: Consumer<BleReactorOps>(builder: (_, _bleReactor, __) {
            ScaleMeasurementViewModel data = _bleReactor.scaleDevice.scaleData;
            return hasAlreadyPair
                ? _scaleStep(_bleReactor, context, data)
                : _pairingStep(_bleReactor, context);
          })),
    );
  }

  Column _scaleStep(BleReactorOps _bleReactor, BuildContext context,
      ScaleMeasurementViewModel data) {
    return _bleReactor.scaleDevice != null ||
            _bleReactor.scaleDevice.scaleData != null
        ? Column(
            children: [
              Expanded(
                child: Center(
                    child: getMeasurementStatus(context, data.scaleModel)),
              ),
              if (data.scaleModel.measurementComplete &&
                  data.scaleModel.impedance != 0)
                Expanded(
                    child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5,
                    crossAxisCount: 2,
                  ),
                  children: [
                    textItem(
                        '${LocaleProvider.current.scale_data_bmi}: ${data.bmi.toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_body_fat}: ${data.bodyFat.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_bone_mass}: ${data.boneMass.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_muscle}: ${data.muscle.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_visceral_fat}: ${data.visceralFat.toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_water}: ${data.water.toStringAsFixed(2)}%')
                  ],
                )),
              Text(
                data.scaleModel.weightStabilized
                    ? data.scaleModel.measurementComplete
                        ? '${LocaleProvider.current.ble_scale_weight_info}'
                        : '${LocaleProvider.current.ble_scale_stabilizing_info}'
                    : '${LocaleProvider.current.ble_scale_weight_calculating_info}',
                style: TextStyle(color: R.color.white),
              ),
              SizedBox(
                height: context.HEIGHT * 0.1,
                child: _bleReactor
                        .scaleDevice.scaleData.scaleModel.measurementComplete
                    ? Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: R.color.white),
                                onPressed: () {
                                  _bleReactor.scaleDevice.scaleData = null;
                                  Atom.dismiss();
                                },
                                child: Text(
                                    '${LocaleProvider.current.close.toUpperCase()}')),
                          ),
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: R.color.white),
                                onPressed: () async {
                                  print(_bleReactor
                                      .scaleDevice.scaleData.scaleModel
                                      .toMap()
                                      .toString());
                                  // TODO Will Be handle
                                  /* await ScaleRepository().addNewScaleData(
                                      _bleReactor.scaleDevice.scaleData, false); */
                                  _bleReactor.scaleDevice.scaleData = null;
                                  Atom.dismiss();
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
                _bleReactor.scaleDevice.scaleData.scaleModel.measurementComplete
                    ? SizedBox()
                    : ProgressCircle(
                        size: context.HEIGHT * .5, color: R.color.white),
                Text(
                    _bleReactor.scaleDevice.scaleData.scaleModel
                            .measurementComplete
                        ? LocaleProvider.current.pair_successful
                        : LocaleProvider.current.pairing,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: R.color.white,
                        fontSize: _bleReactor.scaleDevice.scaleData.scaleModel
                                .measurementComplete
                            ? context.TEXTSCALE * 25
                            : null)),
              ],
            )),
        _bleReactor.scaleDevice.scaleData.scaleModel.measurementComplete
            ? Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          style: TextButton.styleFrom(primary: R.color.white),
                          onPressed: () {
                            _bleReactor.scaleDevice.scaleData = null;
                            _bleReactor.scaleDevice.scaleData = null;
                            getIt<BleReactorOps>().clearControlPointResponse();
                            Atom.dismiss();
                            Atom.historyBack();
                            Atom.to(PagePaths.DEVICES, isReplacement: true);
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
