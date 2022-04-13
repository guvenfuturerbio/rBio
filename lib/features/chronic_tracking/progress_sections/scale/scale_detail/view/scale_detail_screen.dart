import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scale_repository/scale_repository.dart';
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
      child: const ScaleDetailView(),
    );
  }
}

class ScaleDetailView extends StatefulWidget {
  const ScaleDetailView({Key? key}) : super(key: key);

  @override
  _ScaleDetailViewState createState() => _ScaleDetailViewState();
}

class _ScaleDetailViewState extends State<ScaleDetailView> {
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
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      backgroundColor: getIt<ITheme>().mainColor,
      bodyPadding: EdgeInsets.zero,
      appbar: _buildAppBar(),
      body: BlocBuilder<ScaleDetailCubit, ScaleDetailState>(
        builder: (context, state) {
          return _buildBody(state);
        },
      ),
      floatingActionButton: _buildFAB(context),
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.weight_tracking,
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<ScaleDetailCubit>().fetchAll();
          },
          icon: const Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ScaleDetailState state) {
    return state.when(
      initial: () => const SizedBox(),
      loadInProgress: () => const RbioLoading(color: Colors.white),
      success: (result) {
        if (result.list.isNotEmpty) {
          _pointTapNotifier.value ??= result.list.first;
          if (result.list.length < 10) {
            Future.delayed(
              const Duration(milliseconds: 10),
              () {
                _zoomPanBehavior.zoomByFactor(1);
              },
            );
          }
        }

        return _buildSuccess(result);
      },
      failure: () => const RbioBodyError(),
    );
  }

  Widget _buildSuccess(ScaleDetailSuccessResult result) {
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
                list: result.list,
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
                return _buildBottomList(result, selectedItem);
              }
            },
          ),
        ),
      ],
    );
  }

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
                color: getIt<ITheme>().textColor,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildBottomList(
    ScaleDetailSuccessResult result,
    ScaleEntity selectedItem,
  ) {
    return Container(
      width: double.infinity,
      padding: R.sizes.screenPaddingOnlyHorizontal(context),
      color: getIt<ITheme>().scaffoldBackgroundColor,
      child: Column(
        children: [
          //
          const ChartFilterComponent(),

          //
          Expanded(
            child: ScaleDetailScrollView(
              scaleEntity: selectedItem,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
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
                            color: getIt<ITheme>().grey,
                          ),
                        ),

                        //
                        Text(
                          entity.dateTime.xFormatTime8(),
                          style: context.xHeadline5.copyWith(
                            color: getIt<ITheme>().grey,
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
                              ? getIt<ITheme>().mainColor
                              : getIt<ITheme>().grayColor,
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
                              : getIt<ITheme>().textColorSecondary,
                        ),
                      ),
                    ),

                    //
                    Expanded(
                      flex: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: getIt<ITheme>().grayColor,
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
                                textColor: getIt<ITheme>().textColorSecondary,
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
                                textColor: getIt<ITheme>().textColorSecondary,
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
        backgroundColor: getIt<ITheme>().mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        title: Text(
          LocaleProvider.current.warning,
          style: context.xHeadline1.copyWith(
            color: getIt<ITheme>().textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            LocaleProvider.current.measurement_delete_question,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColor,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: getIt<ITheme>().cardBackgroundColor,
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
            color: textColor ?? getIt<ITheme>().textColor,
          ),
        ),

        //
        Text(
          bottomTitle,
          style: context.xHeadline4.copyWith(
            color: textColor ?? getIt<ITheme>().textColor,
          ),
        ),
      ],
    );
  }
}
