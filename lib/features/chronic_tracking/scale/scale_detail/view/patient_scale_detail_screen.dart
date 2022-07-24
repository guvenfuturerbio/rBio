import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/core.dart';
import '../scale_detail.dart';

class PatientScaleDetailScreen extends StatelessWidget {
  const PatientScaleDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientScaleDetailCubit>(
      create: (ctx) => PatientScaleDetailCubit()..fetchAll(),
      child: const PatientScaleDetailView(),
    );
  }
}

class PatientScaleDetailView extends StatefulWidget {
  const PatientScaleDetailView({Key? key}) : super(key: key);

  @override
  _PatientScaleDetailViewState createState() => _PatientScaleDetailViewState();
}

class _PatientScaleDetailViewState extends State<PatientScaleDetailView> {
  final ValueNotifier<ScaleEntity?> _pointTapNotifier = ValueNotifier(null);
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      enableSelectionZooming: true,
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      backgroundColor: context.xPrimaryColor,
      bodyPadding: EdgeInsets.zero,
      appbar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(context),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.weight_tracking,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody() {
    return BlocConsumer<PatientScaleDetailCubit, ScaleDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if (result.filterList.isNotEmpty) {
              _pointTapNotifier.value ??= result.filterList.first;
            }

            if (result.filterType == ScaleChartFilterType.weekly) {
              if (result.filterList.length < 10 &&
                  result.filterList.isNotEmpty) {
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
        textColor: context.xTextColor,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        RbioUserAndTreatmentTile(
          onTap: () {
            Atom.to(PagePaths.patientScaleTreatmentList);
          },
        ),

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
                child: _buildCurrentWeight(result),
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
  Widget _buildCurrentWeight(ScaleDetailSuccessResult result) {
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
              result.filterList.isEmpty
                  ? ""
                  : ((selectedItem.weight ?? 0.0).xGetFriendyString)
                      .replaceAll(".", ","),
              style: context.xHeadline1.copyWith(
                fontSize: context.xHeadline1.fontSize! * 1.5,
                color: context.xTextColor,
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
      padding: R.utils.screenPaddingOnlyHorizontal(context),
      color: getIt<IAppConfig>().theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          //
          const ChartFilterComponent(),

          //
          Expanded(
            child: result.filterList.isEmpty
                ? RbioEmptyText(
                    title: LocaleProvider.current.no_measurement,
                    textColor: context.xTextInverseColor,
                  )
                : ValueListenableBuilder<ScaleEntity?>(
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
    return RbioSVGFAB.primaryColor(
      context,
      imagePath: R.image.add,
      onPressed: () async {
        Atom.to(PagePaths.scaleManuelAdd);
      },
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
                            color: context.xMyCustomTheme.grey,
                          ),
                        ),

                        //
                        Text(
                          entity.dateTime.xFormatTime8(),
                          style: context.xHeadline5.copyWith(
                            color: context.xMyCustomTheme.grey,
                          ),
                        ),
                      ],
                    ),

                    //
                    R.widgets.wSizer4,

                    //
                    Expanded(
                      flex: 40,
                      child: AnimatedContainer(
                        duration: kThemeChangeDuration,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.xPrimaryColor
                              : context.xMyCustomTheme.gallery,
                          borderRadius: BorderRadius.only(
                            topLeft: R.sizes.radiusCircular,
                            bottomLeft: R.sizes.radiusCircular,
                          ),
                        ),
                        child: _buildColumn(
                          context,
                          entity.weight == null
                              ? ''
                              : entity.weight!.xGetFriendyString,
                          entity.getUnit,
                          textColor:
                              isSelected ? null : context.xTextInverseColor,
                        ),
                      ),
                    ),

                    //
                    Expanded(
                      flex: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: context.xMyCustomTheme.gallery,
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
                                textColor: context.xTextInverseColor,
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
                                textColor: context.xTextInverseColor,
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
          context.read<PatientScaleDetailCubit>().deleteItem(entity);
        }
      } catch (e, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(e, stackTrace: stackTrace);
        LoggerUtils.instance.e(e);
      }
    }
  }

  Future<dynamic> _showConfirmationAlertDialog(BuildContext context) async {
    return await Atom.show(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: context.xPrimaryColor,
        shape: R.sizes.defaultShape,
        title: Text(
          LocaleProvider.current.warning,
          style: context.xHeadline1.copyWith(
            color: context.xTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            LocaleProvider.current.measurement_delete_question,
            style: context.xHeadline3.copyWith(
              color: context.xTextColor,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: context.xCardColor,
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
            color: textColor ?? context.xTextColor,
          ),
        ),

        //
        Text(
          bottomTitle,
          style: context.xHeadline4.copyWith(
            color: textColor ?? context.xTextColor,
          ),
        ),
      ],
    );
  }
}
