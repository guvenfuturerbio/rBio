import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../../../../../../../core/core.dart';

class ScaleMeasurementPopup extends StatelessWidget {
  const ScaleMeasurementPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioDarkStatusBar(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MiScaleOpsCubit, MiScaleOpsState>(
      builder: (context, miScaleState) {
        return miScaleState.whenOrNull(
              showLoading: (scaleEntity) {
                return SafeArea(
                  child: Padding(
                    padding: R.sizes.screenPadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        R.sizes.hSizer28,
                        _buildTitle(context),
                        R.sizes.hSizer8,
                        R.sizes.hSizer28,
                        _buildWeight(scaleEntity, context),
                        Center(
                          child: MirrorAnimation(
                            duration: const Duration(seconds: 1),
                            tween: Tween<double>(begin: 0, end: 10),
                            builder: (context, child, double value) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: SvgPicture.asset(
                                  R.image.arrowDown,
                                  width: R.sizes.iconSize3,
                                ),
                              );
                            },
                          ),
                        ),
                        R.sizes.hSizer8,
                        Container(
                          color: Colors.transparent,
                          height: 45,
                          child: RiveAnimation.asset(
                            R.image.scaleLoadingLines,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        R.sizes.hSizer28,
                        R.sizes.hSizer28,
                        R.sizes.hSizer28,
                        _buildDescription(context),
                      ],
                    ),
                  ),
                );
              },
            ) ??
            const RbioLoading();
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            LocaleProvider.current.weighing,
            style: context.xHeadline3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        R.sizes.wSizer8,
        RbioJumpingDots(
          fontSize: 16,
          dotSpacing: 5,
        ),
      ],
    );
  }

  Widget _buildWeight(ScaleEntity scaleEntity, BuildContext context) {
    return Center(
      child: Text(
        scaleEntity.weight == null ? '0.0' : scaleEntity.weight.toString(),
        textAlign: TextAlign.center,
        style: context.xHeadline1.copyWith(
          fontSize: context.xHeadline1.fontSize! * 2,
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Center(
      child: Text(
        LocaleProvider.current.weighing_completed,
        textAlign: TextAlign.center,
        style: context.xHeadline4.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _LoadingBar extends StatefulWidget {
  const _LoadingBar({Key? key}) : super(key: key);

  @override
  State<_LoadingBar> createState() => __LoadingBarState();
}

class __LoadingBarState extends State<_LoadingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        horizontal: Atom.width * 0.1,
      ),
      child: Column(
        children: [
          //
          MirrorAnimation(
            duration: const Duration(seconds: 1),
            tween: Tween<double>(begin: 0, end: 5),
            builder: (context, child, double value) {
              return Transform.translate(
                offset: Offset(0, value),
                child: SvgPicture.asset(
                  R.image.arrowDown,
                  width: R.sizes.iconSize3,
                ),
              );
            },
          ),

          //
          SizedBox(
            height: 65,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: _buildStickRow()),
                  Expanded(child: _buildStickRow()),
                  Expanded(child: _buildStickRow()),
                  Expanded(child: _buildStickRow()),
                  Expanded(child: _buildStickRow()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLongStick(),
          const Spacer(),
          _buildShortStick(),
          const Spacer(),
          _buildShortStick(),
          const Spacer(),
          _buildShortStick(),
          const Spacer(),
          _buildShortStick(),
          const Spacer(),
        ],
      );

  Widget _buildLongStick() => Container(
        width: 2.0,
        height: 65.0,
        color: Colors.green,
      );

  Widget _buildShortStick() => Container(
        width: 2.0,
        height: 40.0,
        color: Colors.green,
      );
}
