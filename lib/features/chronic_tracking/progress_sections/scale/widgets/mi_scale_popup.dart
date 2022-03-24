import 'package:flutter/material.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../../../core/core.dart';
import 'loading/scale_progress_circle.dart';

class MiScalePopUp extends StatelessWidget {
  const MiScalePopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: getIt<ITheme>().mainColor,
        height: context.height,
        width: context.width,
        child: BlocBuilder<MiScaleCubit, MiScaleState>(
          builder: (context, miScaleState) {
            Widget? child = const RbioLoading();
            miScaleState.whenOrNull(
              showLoading: (scaleEntity) {
                child = _scaleStep(context, scaleEntity);
                // return scaleEntity.measurementComplete == true
                //     ? _scaleStep(context, scaleEntity)
                //     : _pairingStep(context, scaleEntity);
              },
            );

            return child!;
          },
        ),
      ),
    );
  }

  Widget _scaleStep(
    BuildContext context,
    ScaleEntity? entity,
  ) {
    return entity != null
        ? Column(
            children: [
              //
              Expanded(
                child: Center(
                  child: getMeasurementStatus(
                    context,
                    entity,
                  ),
                ),
              ),

              //
              if (entity.measurementComplete ??
                  true && entity.impedance != 0) ...[
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.5,
                      crossAxisCount: 2,
                    ),
                    children: [
                      textItem(
                        '${LocaleProvider.current.scale_data_bmi}: ${entity.bmi?.toStringAsFixed(2)}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_body_fat}: ${entity.bodyFat?.toStringAsFixed(2)} ${entity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_bone_mass}: ${entity.boneMass?.toStringAsFixed(2)} ${entity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_muscle}: ${entity.muscle?.toStringAsFixed(2)} ${entity.unit}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_visceral_fat}: ${entity.visceralFat?.toStringAsFixed(2)}',
                      ),
                      textItem(
                        '${LocaleProvider.current.scale_data_water}: ${entity.water?.toStringAsFixed(2)}%',
                      )
                    ],
                  ),
                ),
              ],

              //
              Text(
                entity.weightStabilized ?? false
                    ? entity.measurementComplete ?? false
                        ? LocaleProvider.current.ble_scale_weight_info
                        : LocaleProvider.current.ble_scale_stabilizing_info
                    : LocaleProvider.current.ble_scale_weight_calculating_info,
                style: TextStyle(color: R.color.white),
              ),

              //
              SizedBox(
                height: context.height * 0.1,
                child: entity.measurementComplete ?? false
                    ? Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(primary: R.color.white),
                              onPressed: () {
                                Atom.dismiss();
                              },
                              child: Text(
                                LocaleProvider.current.close.toUpperCase(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(primary: R.color.white),
                              onPressed: () async {
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

  Widget getMeasurementStatus(BuildContext context, ScaleEntity data) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        //
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

        //
        ScaleProgressCircle(
          size: context.height * .5,
          color: R.color.white,
        ),
      ],
    );
  }

  Widget _pairingStep(BuildContext context, ScaleEntity entity) {
    return Column(
      children: [
        //
        Expanded(
          flex: 3,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              entity.measurementComplete ?? false
                  ? const SizedBox()
                  : ScaleProgressCircle(
                      size: context.height * .5,
                      color: R.color.white,
                    ),
              Text(
                entity.measurementComplete ?? false
                    ? LocaleProvider.current.pair_successful
                    : LocaleProvider.current.pairing,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: R.color.white,
                    fontSize: entity.measurementComplete ?? false
                        ? context.textScale * 25
                        : null),
              ),
            ],
          ),
        ),

        //
        entity.measurementComplete ?? false
            ? Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: R.color.white),
                        onPressed: () {
                          getIt<BleReactorOps>().clearControlPointResponse();
                          Atom.dismiss();
                          Atom.historyBack();
                          Atom.to(PagePaths.devices, isReplacement: true);
                        },
                        child: Text(
                          LocaleProvider.current.done.toUpperCase(),
                        ),
                      ),
                    ),
                  ],
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
