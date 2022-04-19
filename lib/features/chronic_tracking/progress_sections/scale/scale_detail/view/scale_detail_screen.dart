import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../scale_detail.dart';
import 'widget/scale_chart.dart';

class ScaleDetailScreen extends StatelessWidget {
  const ScaleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScaleDetailCubit>(
      create: (ctx) => ScaleDetailCubit()..fetchAll(),
      child: const _ScaleDetailView(),
    );
  }
}

class _ScaleDetailView extends StatefulWidget {
  const _ScaleDetailView({Key? key}) : super(key: key);

  @override
  __ScaleDetailViewState createState() => __ScaleDetailViewState();
}

class __ScaleDetailViewState extends State<_ScaleDetailView> {
  final ValueNotifier<ScaleEntity?> _pointTapNotifier = ValueNotifier(null);
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      enableSelectionZooming: true,
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      bodyPadding: EdgeInsets.zero,
      appbar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.weight_tracking,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody() {
    return BlocConsumer<ScaleDetailCubit, ScaleDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            _pointTapNotifier.value ??= result.filterList.first;

            if (result.filterType == ScaleChartFilterType.weekly) {
              if (result.filterList.length < 10) {
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () {
                    _zoomPanBehavior.zoomByFactor(1);
                  },
                );
              }
            } else {
              _zoomPanBehavior.reset();
              _zoomPanBehavior.panToDirection('right');
            }
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioWhiteLoading(),
          success: (result) => _buildSuccess(result),
          failure: () => const RbioBodyError(),
        );
      },
    );
  }
  // #endregion

  // #region _buildSuccess
  Widget _buildSuccess(ScaleDetailSuccessResult result) {
    if (result.allList.isEmpty) {
      return RbioEmptyText(
        title: LocaleProvider.current.no_measurement,
        textColor: getIt<IAppConfig>().theme.textColor,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          flex: 30,
          child: Stack(
            fit: StackFit.expand,
            children: [
              //
              ScaleChart(
                list: result.filterList,
                maximum: result.maximumWeight,
                minimum: result.minimumWeight,
                zoomPanBehavior: _zoomPanBehavior,
                pointTapNotifier: _pointTapNotifier,
              ),

              //
              Align(
                alignment: Alignment.topCenter,
                child: _buildCurrentWeight(),
              ),
            ],
          ),
        ),

        //
        Expanded(
          flex: 70,
          child: _buildBottomBody(result),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildCurrentWeight
  Widget _buildCurrentWeight() {
    return ValueListenableBuilder<ScaleEntity?>(
      valueListenable: _pointTapNotifier,
      builder: (
        BuildContext context,
        ScaleEntity? selectedItem,
        Widget? child,
      ) {
        if (selectedItem == null) {
          return const SizedBox();
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              ((selectedItem.weight ?? 0.0).xGetFriendyString)
                  .replaceAll(".", ","),
              style: context.xHeadline1.copyWith(
                fontSize: context.xHeadline1.fontSize! * 1.5,
                color: getIt<IAppConfig>().theme.textColor,
              ),
            ),
          );
        }
      },
    );
  }
  // #endregion

  // #region _buildBottomBody
  Widget _buildBottomBody(ScaleDetailSuccessResult result) {
    return Container(
      width: double.infinity,
      padding: R.sizes.screenPaddingOnlyHorizontal(context),
      color: getIt<IAppConfig>().theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          //
          const ChartFilterComponent(),

          //
          Expanded(
            child: ValueListenableBuilder<ScaleEntity?>(
              valueListenable: _pointTapNotifier,
              builder: (
                BuildContext context,
                ScaleEntity? selectedItem,
                Widget? child,
              ) {
                if (selectedItem == null) {
                  return const SizedBox();
                } else {
                  return ScaleValuesScrollView(
                    scaleEntity: selectedItem,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildFAB
  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
      onPressed: () async {
        Atom.to(PagePaths.scaleManuelAdd);
        // final isAdded = await Atom.show(
        //   const ScaleTaggerPopUp(),
        //   barrierDismissible: false,
        //   barrierColor: Colors.transparent,
        // );

        // if (isAdded != null) {
        //   if (isAdded == true) {
        //     await context.read<ScaleDetailCubit>().fetchAll();
        //   }
        // }
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset(
          R.image.add,
          color: R.color.white,
        ),
      ),
    );
  }
  // #endregion
}

class ScaleCard extends StatelessWidget {
  final ScaleEntity entity;
  final bool isSelected;

  const ScaleCard({
    Key? key,
    required this.entity,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
      ),
      child: Slidable(
        key: ValueKey(entity.dateTime.millisecondsSinceEpoch),
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: LocaleProvider.current.delete,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _deleteItem(context),
          ),
        ],
        child: GestureDetector(
          onTap: () async {
            // Atom.show(
            //   ScaleTaggerPopUp(
            //     scaleModel: entity,
            //     isUpdate: true,
            //   ),
            //   barrierDismissible: false,
            //   barrierColor: Colors.transparent,
            // );
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Text(
                          entity.dateTime.xFormatTime7(),
                          style: context.xHeadline5.copyWith(
                            color: getIt<IAppConfig>().theme.grey,
                          ),
                        ),

                        //
                        Text(
                          entity.dateTime.xFormatTime8(),
                          style: context.xHeadline5.copyWith(
                            color: getIt<IAppConfig>().theme.grey,
                          ),
                        ),
                      ],
                    ),

                    //
                    R.sizes.wSizer4,

                    //
                    Expanded(
                      flex: 40,
                      child: AnimatedContainer(
                        duration: kThemeChangeDuration,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? getIt<IAppConfig>().theme.mainColor
                              : getIt<IAppConfig>().theme.grayColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: _buildColumn(
                          context,
                          entity.weight == null
                              ? ''
                              : entity.weight!.xGetFriendyString,
                          entity.getUnit,
                          textColor: isSelected
                              ? null
                              : getIt<IAppConfig>().theme.textColorSecondary,
                        ),
                      ),
                    ),

                    //
                    Expanded(
                      flex: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: getIt<IAppConfig>().theme.grayColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //
                            Expanded(
                              child: _buildColumn(
                                context,
                                entity.bmi == null
                                    ? "0"
                                    : entity.bmi!.xGetFriendyString,
                                "BMI",
                                textColor: getIt<IAppConfig>()
                                    .theme
                                    .textColorSecondary,
                              ),
                            ),

                            //
                            Expanded(
                              child: _buildColumn(
                                context,
                                entity.bmh == null
                                    ? "0"
                                    : entity.bmh!.xGetFriendyString,
                                "BMH",
                                textColor: getIt<IAppConfig>()
                                    .theme
                                    .textColorSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context) async {
    final isOk = await _showConfirmationAlertDialog(context);
    if (isOk == true) {
      try {
        final isDeleted = await getIt<ScaleRepository>().deleteScaleMeasurement(
          DeleteScaleMasurementBody(
            entegrationId: entity.entegrationId,
            measurementId: entity.measurementId,
          ),
          entity.dateTime,
        );
        if (isDeleted) {
          context.read<ScaleDetailCubit>().deleteItem(entity);
        }
      } catch (e) {
        LoggerUtils.instance.e(e);
      }
    }
  }

  Future<dynamic> _showConfirmationAlertDialog(BuildContext context) async {
    return await Atom.show(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: getIt<IAppConfig>().theme.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        title: Text(
          LocaleProvider.current.warning,
          style: context.xHeadline1.copyWith(
            color: getIt<IAppConfig>().theme.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            LocaleProvider.current.measurement_delete_question,
            style: context.xHeadline3.copyWith(
              color: getIt<IAppConfig>().theme.textColor,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: getIt<IAppConfig>().theme.cardBackgroundColor,
            ),
            child: Text(LocaleProvider.current.Ok),
            onPressed: () {
              Atom.dismiss(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(
    BuildContext context,
    String topTitle,
    String bottomTitle, {
    Color? textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Text(
          topTitle,
          style: context.xHeadline3.copyWith(
            color: textColor ?? getIt<IAppConfig>().theme.textColor,
          ),
        ),

        //
        Text(
          bottomTitle,
          style: context.xHeadline4.copyWith(
            color: textColor ?? getIt<IAppConfig>().theme.textColor,
          ),
        ),
      ],
    );
  }
}
