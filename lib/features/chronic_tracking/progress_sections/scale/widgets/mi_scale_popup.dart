import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../core/core.dart';
import 'loading/scale_progress_circle.dart';

class MiScalePopUp extends StatelessWidget {
  final bool hasAlreadyPair;

  const MiScalePopUp({
    Key? key,
    this.hasAlreadyPair = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: getIt<ITheme>().mainColor,
        height: context.height,
        width: context.width,
        child: BlocBuilder<BluetoothBloc, BluetoothState>(
          builder: (context, bluetoothState) {
            ScaleEntity? data = bluetoothState.scaleEntity;
            return hasAlreadyPair
                ? _scaleStep(data, context)
                : _pairingStep(data, context);
          },
        ),
      ),
    );
  }

  Widget _scaleStep(
    ScaleEntity? scaleEntity,
    BuildContext context,
  ) {
    return scaleEntity != null
        ? Column(
            children: [
              //
              Expanded(
                child: Center(
                  child: getMeasurementStatus(
                    context,
                    scaleEntity,
                  ),
                ),
              ),

              //
              if (scaleEntity.measurementComplete ??
                  true && scaleEntity.impedance != 0) ...[
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.5,
                      crossAxisCount: 2,
                    ),
                    children: [
                      textItem(
                        '${LocaleProvider.current.scale_data_bmi}: ${scaleEntity.bmi?.toStringAsFixed(2)}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_body_fat}: ${scaleEntity.bodyFat?.toStringAsFixed(2)} ${scaleEntity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_bone_mass}: ${scaleEntity.boneMass?.toStringAsFixed(2)} ${scaleEntity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_muscle}: ${scaleEntity.muscle?.toStringAsFixed(2)} ${scaleEntity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_visceral_fat}: ${scaleEntity.visceralFat?.toStringAsFixed(2)}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_water}: ${scaleEntity.water?.toStringAsFixed(2)}%',
                      )
                    ],
                  ),
                ),
              ],

              //
              Text(
                scaleEntity.weightStabilized ?? false
                    ? scaleEntity.measurementComplete ?? false
                        ? LocaleProvider.current.ble_scale_weight_info
                        : LocaleProvider.current.ble_scale_stabilizing_info
                    : LocaleProvider.current.ble_scale_weight_calculating_info,
                style: TextStyle(color: R.color.white),
              ),

              //
              SizedBox(
                height: context.height * 0.1,
                child: scaleEntity.measurementComplete ?? false
                    ? Row(
                        children: [
                          //
                          Expanded(
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(primary: R.color.white),
                              onPressed: () {
                                Atom.context
                                    .read<BluetoothBloc>()
                                    .add(const BluetoothEvent.miScaleCleared());
                                Atom.dismiss();
                              },
                              child: Text(
                                LocaleProvider.current.close.toUpperCase(),
                              ),
                            ),
                          ),

                          //
                          Expanded(
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(primary: R.color.white),
                              onPressed: () async {
                                Atom.context
                                    .read<BluetoothBloc>()
                                    .add(const BluetoothEvent.miScaleCleared());
                                Atom.dismiss();
                              },
                              child: Text(
                                LocaleProvider.current.save.toUpperCase(),
                              ),
                            ),
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

  Widget getMeasurementStatus(BuildContext context, ScaleEntity? data) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        //
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              (data?.weight ?? 0).toString(),
              style: TextStyle(
                  color: R.color.white, fontSize: context.textScale * 32),
            ),
            Text(
              data!.getUnit,
              style: TextStyle(
                  color: R.color.white, fontSize: context.textScale * 32),
            )
          ],
        ),

        //
        ScaleProgressCircle(
          size: context.height * .5,
          color: R.color.white,
        ),
      ],
    );
  }

  Widget _pairingStep(ScaleEntity? scaleEntity, BuildContext context) {
    return Column(
      children: [
        //
        Expanded(
          flex: 3,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              scaleEntity?.measurementComplete ?? false
                  ? const SizedBox()
                  : ScaleProgressCircle(
                      size: context.height * .5,
                      color: R.color.white,
                    ),
              Text(
                scaleEntity?.measurementComplete ?? false
                    ? LocaleProvider.current.pair_successful
                    : LocaleProvider.current.pairing,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: R.color.white,
                    fontSize: scaleEntity?.measurementComplete ?? false
                        ? context.textScale * 25
                        : null),
              ),
            ],
          ),
        ),

        //
        scaleEntity?.measurementComplete ?? false
            ? Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(primary: R.color.white),
                  onPressed: () {
                    Atom.context
                        .read<BluetoothBloc>()
                        .add(const BluetoothEvent.miScaleCleared());
                    Atom.context
                        .read<BluetoothBloc>()
                        .add(const BluetoothEvent.scanStopped());
                    Atom.context.read<BluetoothBloc>().add(
                        const BluetoothEvent.clearedControlPointResponse());
                    Atom.dismiss();
                    Atom.historyBack();
                    Atom.to(PagePaths.devices, isReplacement: true);
                  },
                  child: Text(
                    LocaleProvider.current.done.toUpperCase(),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget textItem(String data) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(color: R.color.white),
    );
  }
}
