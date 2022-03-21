import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        child: Consumer<BleReactorOps>(
          builder: (_, _bleReactor, __) {
            return const RbioLoading();
            ScaleEntity? data = _bleReactor.scaleEntity;
            // return hasAlreadyPair
            //     ? _scaleStep(_bleReactor, context, data)
            //     : _pairingStep(_bleReactor, context);
          },
        ),
      ),
    );
  }

  // Widget _scaleStep(
  //   BleReactorOps _bleReactor,
  //   BuildContext context,
  //   ScaleEntity? data,
  // ) {
  //   return data != null && _bleReactor.scaleDevice.scaleData != null
  //       ? Column(
  //           children: [
  //             //
  //             Expanded(
  //               child: Center(
  //                 child: getMeasurementStatus(
  //                   context,
  //                   data,
  //                 ),
  //               ),
  //             ),

  //             //
  //             if (data.measurementComplete ?? true && data.impedance != 0) ...[
  //               Expanded(
  //                 child: GridView(
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                     childAspectRatio: 2.5,
  //                     crossAxisCount: 2,
  //                   ),
  //                   children: [
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_bmi}: ${data.bmi?.toStringAsFixed(2)}',
  //                     ),
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_body_fat}: ${data.bodyFat?.toStringAsFixed(2)} ${data.unit}',
  //                     ),
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_bone_mass}: ${data.boneMass?.toStringAsFixed(2)} ${data.unit}',
  //                     ),
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_muscle}: ${data.muscle?.toStringAsFixed(2)} ${data.unit}',
  //                     ),
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_visceral_fat}: ${data.visceralFat?.toStringAsFixed(2)}',
  //                     ),
  //                     textItem(
  //                       '${LocaleProvider.current.scale_data_water}: ${data.water?.toStringAsFixed(2)}%',
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],

  //             //
  //             Text(
  //               data.weightStabilized ?? false
  //                   ? data.measurementComplete ?? false
  //                       ? LocaleProvider.current.ble_scale_weight_info
  //                       : LocaleProvider.current.ble_scale_stabilizing_info
  //                   : LocaleProvider.current.ble_scale_weight_calculating_info,
  //               style: TextStyle(color: R.color.white),
  //             ),

  //             //
  //             SizedBox(
  //               height: context.height * 0.1,
  //               child: _bleReactor.scaleEntity!.measurementComplete ?? false
  //                   ? Row(
  //                       children: [
  //                         Expanded(
  //                           child: TextButton(
  //                             style:
  //                                 TextButton.styleFrom(primary: R.color.white),
  //                             onPressed: () {
  //                               _bleReactor.scaleDevice.scaleData = null;
  //                               Atom.dismiss();
  //                             },
  //                             child: Text(
  //                               LocaleProvider.current.close.toUpperCase(),
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: TextButton(
  //                             style:
  //                                 TextButton.styleFrom(primary: R.color.white),
  //                             onPressed: () async {
  //                               _bleReactor.scaleDevice.scaleData = null;
  //                               Atom.dismiss();
  //                             },
  //                             child: Text(
  //                               LocaleProvider.current.save.toUpperCase(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   : const SizedBox(),
  //             )
  //           ],
  //         )
  //       : Column(
  //           children: [
  //             Expanded(
  //               child: Text(LocaleProvider.current.ble_scale_scaling_info),
  //             ),
  //           ],
  //         );
  // }

  // Widget getMeasurementStatus(BuildContext context, ScaleEntity data) {
  //   return Stack(
  //     alignment: AlignmentDirectional.center,
  //     children: [
  //       //
  //       Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             data.weight.toString(),
  //             style: TextStyle(
  //                 color: R.color.white, fontSize: context.textScale * 32),
  //           ),
  //           Text(
  //             data.getUnit,
  //             style: TextStyle(
  //                 color: R.color.white, fontSize: context.textScale * 32),
  //           )
  //         ],
  //       ),

  //       //
  //       ScaleProgressCircle(
  //         size: context.height * .5,
  //         color: R.color.white,
  //       ),
  //     ],
  //   );
  // }

  // Widget _pairingStep(BleReactorOps _bleReactor, BuildContext context) {
  //   return Column(
  //     children: [
  //       //
  //       Expanded(
  //         flex: 3,
  //         child: Stack(
  //           alignment: AlignmentDirectional.center,
  //           children: [
  //             _bleReactor.scaleEntity!.measurementComplete ?? false
  //                 ? const SizedBox()
  //                 : ScaleProgressCircle(
  //                     size: context.height * .5,
  //                     color: R.color.white,
  //                   ),
  //             Text(
  //               _bleReactor.scaleEntity!.measurementComplete ?? false
  //                   ? LocaleProvider.current.pair_successful
  //                   : LocaleProvider.current.pairing,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   color: R.color.white,
  //                   fontSize:
  //                       _bleReactor.scaleEntity!.measurementComplete ?? false
  //                           ? context.textScale * 25
  //                           : null),
  //             ),
  //           ],
  //         ),
  //       ),

  //       //
  //       _bleReactor.scaleEntity!.measurementComplete ?? false
  //           ? Expanded(
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: TextButton(
  //                       style: TextButton.styleFrom(primary: R.color.white),
  //                       onPressed: () {
  //                         _bleReactor.scaleDevice.scaleData = null;
  //                         _bleReactor.scaleDevice.scaleData = null;
  //                         getIt<BleReactorOps>().clearControlPointResponse();
  //                         Atom.dismiss();
  //                         Atom.historyBack();
  //                         Atom.to(PagePaths.devices, isReplacement: true);
  //                       },
  //                       child: Text(
  //                         LocaleProvider.current.done.toUpperCase(),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           : const SizedBox(),
  //     ],
  //   );
  // }

  // Widget textItem(String data) {
  //   return Text(
  //     data,
  //     textAlign: TextAlign.center,
  //     style: TextStyle(color: R.color.white),
  //   );
  // }
}
