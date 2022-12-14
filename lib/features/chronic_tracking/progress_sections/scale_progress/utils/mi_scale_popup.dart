import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import 'loading/progress_circle.dart';
import 'scale_measurements/scale_measurement_vm.dart';

class MiScalePopUp extends StatelessWidget {
  final bool hasAlreadyPair;
  const MiScalePopUp({Key? key, this.hasAlreadyPair = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: getIt<ITheme>().mainColor,
          height: context.height,
          width: context.width,
          child: Consumer<BleReactorOps>(builder: (_, _bleReactor, __) {
            ScaleMeasurementViewModel? data = _bleReactor.scaleDevice.scaleData;
            return hasAlreadyPair
                ? _scaleStep(_bleReactor, context, data)
                : _pairingStep(_bleReactor, context);
          })),
    );
  }

  Column _scaleStep(BleReactorOps _bleReactor, BuildContext context,
      ScaleMeasurementViewModel? data) {
    return data != null && _bleReactor.scaleDevice.scaleData != null
        ? Column(
            children: [
              Expanded(
                child: Center(
                    child: getMeasurementStatus(context, data.scaleModel)),
              ),
              if (data.scaleModel.measurementComplete ??
                  true && data.scaleModel.impedance != 0)
                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5,
                    crossAxisCount: 2,
                  ),
                  children: [
                    textItem(
                        '${LocaleProvider.current.scale_data_bmi}: ${data.bmi?.toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_body_fat}: ${data.bodyFat?.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_bone_mass}: ${data.boneMass?.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_muscle}: ${data.muscle?.toStringAsFixed(2)} ${data.unit}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_visceral_fat}: ${data.visceralFat?.toStringAsFixed(2)}'),
                    textItem(
                        '${LocaleProvider.current.scale_data_water}: ${data.water?.toStringAsFixed(2)}%')
                  ],
                )),
              Text(
                data.scaleModel.weightStabilized ?? false
                    ? data.scaleModel.measurementComplete ?? false
                        ? LocaleProvider.current.ble_scale_weight_info
                        : LocaleProvider.current.ble_scale_stabilizing_info
                    : LocaleProvider.current.ble_scale_weight_calculating_info,
                style: TextStyle(color: R.color.white),
              ),
              SizedBox(
                height: context.height * 0.1,
                child: _bleReactor.scaleDevice.scaleData?.scaleModel
                            .measurementComplete ??
                        false
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
                                child: Text(LocaleProvider.current.close
                                    .toUpperCase())),
                          ),
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: R.color.white),
                                onPressed: () async {
                                  _bleReactor.scaleDevice.scaleData = null;
                                  Atom.dismiss();
                                },
                                child: Text(
                                    LocaleProvider.current.save.toUpperCase())),
                          ),
                        ],
                      )
                    : const SizedBox(),
              )
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Text(LocaleProvider.current.ble_scale_scaling_info),
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
                  color: R.color.white, fontSize: context.textScale * 32),
            ),
            Text(
              data.getUnit,
              style: TextStyle(
                  color: R.color.white, fontSize: context.textScale * 32),
            )
          ],
        ),
        ProgressCircle(
          size: context.height * .5,
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
                _bleReactor.scaleDevice.scaleData?.scaleModel
                            .measurementComplete ??
                        false
                    ? const SizedBox()
                    : ProgressCircle(
                        size: context.height * .5, color: R.color.white),
                Text(
                    _bleReactor.scaleDevice.scaleData?.scaleModel
                                .measurementComplete ??
                            false
                        ? LocaleProvider.current.pair_successful
                        : LocaleProvider.current.pairing,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: R.color.white,
                        fontSize: _bleReactor.scaleDevice.scaleData?.scaleModel
                                    .measurementComplete ??
                                false
                            ? context.textScale * 25
                            : null)),
              ],
            )),
        _bleReactor.scaleDevice.scaleData?.scaleModel.measurementComplete ??
                false
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
                            Atom.to(PagePaths.devices, isReplacement: true);
                          },
                          child:
                              Text(LocaleProvider.current.done.toUpperCase())),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
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
