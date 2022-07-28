import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/core.dart';
import '../scale_detail.dart';

class ScaleManuelAddScreen extends StatelessWidget {
  const ScaleManuelAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScaleManuelAddCubit>(
      create: (context) => ScaleManuelAddCubit(getIt(), getIt()),
      child: Builder(
        builder: (context) {
          return BlocListener<ScaleManuelAddCubit, ScaleManuelAddState>(
            listener: (context, state) {
              state.whenOrNull(
                showWarningDialog: (description) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return GradientDialog(
                        title: LocaleProvider.current.warning,
                        text: description,
                      );
                    },
                  );
                },
                failure: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return RbioMessageDialog(
                        description:
                            LocaleProvider.current.sorry_dont_transaction,
                        isAtom: false,
                      );
                    },
                  );
                },
                successAdded: () {
                  Utils.instance.showSuccessSnackbar(
                    context,
                    LocaleProvider.current.measurement_saved,
                  );
                  Atom.to(
                    PagePaths.patientScaleDetail,
                    isReplacement: true,
                  );
                },
              );
            },
            child: const _ScaleManuelAddView(),
          );
        },
      ),
    );
  }
}

class _ScaleManuelAddView extends StatefulWidget {
  const _ScaleManuelAddView({Key? key}) : super(key: key);

  @override
  State<_ScaleManuelAddView> createState() => _ScaleManuelAddViewState();
}

class _ScaleManuelAddViewState extends State<_ScaleManuelAddView> {
  List<double> weightList = [];

  @override
  void initState() {
    for (int i = 0; i < 255; i++) {
      for (int f = 0; f < 10; f++) {
        weightList.add(i + (double.tryParse('0.$f') ?? 0));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //
        RbioStackedScaffold(
          appbar: RbioAppBar(
            context: context,
          ),
          body: _buildBody(context),
        ),

        //
        Positioned.fill(
          child: BlocBuilder<ScaleManuelAddCubit, ScaleManuelAddState>(
            builder: (context, state) {
              return state.whenOrNull(
                    loadInProgress: () => Container(
                      color: Colors.black26,
                      child: const RbioLoading(),
                    ),
                  ) ??
                  const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ScaleManuelAddCubit, ScaleManuelAddState>(
      buildWhen: (previous, current) =>
          current.whenOrNull(initial: (_) => true) ?? false,
      builder: (context, state) {
        return state.whenOrNull(
              initial: (result) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    //
                    Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //
                                  R.widgets.stackedTopPadding(context),
                                  R.widgets.hSizer8,

                                  //
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      LocaleProvider.current.enter_weight,
                                      textAlign: TextAlign.left,
                                      style: context.xHeadline2.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  //
                                  _buildGap(),

                                  //
                                  _buildBoldTitle(context,
                                      LocaleProvider.current.weight_text),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      //
                                      Expanded(
                                        flex: 80,
                                        child: _buildWeight(result),
                                      ),

                                      //
                                      R.widgets.wSizer8,

                                      //
                                      Expanded(
                                        flex: 20,
                                        child: _buildScaleUnit(result),
                                      ),
                                    ],
                                  ),

                                  //
                                  _buildGap(),

                                  //
                                  _buildBoldTitle(context,
                                      LocaleProvider.current.time_text),
                                  _buildDateTime(result),
                                ],
                              ),
                            ),
                          ),

                          //
                          _buildButtons(result),

                          //
                          R.widgets.defaultBottomPadding,
                        ],
                      ),
                    ),
                  ],
                );
              },
            ) ??
            const SizedBox();
      },
    );
  }

  // #region _buildWeight
  Widget _buildWeight(ScaleManuelAddResult result) {
    return GestureDetector(
      onTap: () async {
        final pickerResult = await showRbioSelectBottomSheet(
          context,
          title: LocaleProvider.current.weight_text,
          initialItem: result.weight == null
              ? 70 * 10
              : weightList.indexOf(result.weight!),
          children: weightList
              .map(
                (e) => Center(
                  child: Text(
                    '$e ${result.scaleUnit.toStr}',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .dateTimePickerTextStyle
                        .copyWith(
                          color: context.xTextInverseColor,
                        ),
                  ),
                ),
              )
              .toList(),
        );

        if (pickerResult != null) {
          final selectedWeight = weightList[pickerResult];
          context.read<ScaleManuelAddCubit>().changeWeight(selectedWeight);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.xCardColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Text(
          result.weight == null ? '' : result.weight.toString(),
          style: context.xHeadline3,
        ),
      ),
    );
  }

  // #region _buildScaleUnit
  Widget _buildScaleUnit(ScaleManuelAddResult result) {
    return GestureDetector(
      onTap: () async {
        final pickerResult = await showRbioSelectBottomSheet(
          context,
          title: LocaleProvider.current.mass_unit,
          initialItem: result.scaleUnit.index,
          children: ScaleUnit.values
              .map(
                (e) => Center(
                  child: Text(
                    e.toStr,
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .dateTimePickerTextStyle
                        .copyWith(
                          color: context.xTextInverseColor,
                        ),
                  ),
                ),
              )
              .toList(),
        );

        if (pickerResult != null) {
          if (pickerResult == 0) {
            context.read<ScaleManuelAddCubit>().changeScaleUnit(ScaleUnit.kg);
          } else {
            context.read<ScaleManuelAddCubit>().changeScaleUnit(ScaleUnit.lbs);
          }
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.xCardColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Text(
          result.scaleUnit.toStr,
          style: context.xHeadline3,
        ),
      ),
    );
  }

  // #endregion
  Widget _buildDateTime(ScaleManuelAddResult result) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showRbioDatePicker(
          context,
          title: LocaleProvider.of(context).date,
          initialDateTime: result.dateTime,
          maximumDate: DateTime.now(),
          minimumDate: DateTime(2000),
          mode: CupertinoDatePickerMode.dateAndTime,
        );

        if (pickedDate != null) {
          context.read<ScaleManuelAddCubit>().changeDateTime(pickedDate);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.xCardColor,
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Text(
          DateFormat("d MMMM yyyy EEEE, HH:mm",
                  context.watch<LocaleNotifier>().current.languageCode)
              .format(result.dateTime),
          style: context.xHeadline3,
        ),
      ),
    );
  }

  // #endregion
  Widget _buildBoldTitle(
    BuildContext context,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // #endregion
  Widget _buildButtons(ScaleManuelAddResult result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: RbioWhiteButton(
            title: LocaleProvider.current.btn_cancel,
            onTap: () {
              Atom.historyBack();
            },
          ),
        ),

        //
        R.widgets.wSizer12,

        //
        Expanded(
          child: RbioElevatedButton(
            title: LocaleProvider.current.save,
            onTap: result.isHeightNull
                ? null
                : () async {
                    await context.read<ScaleManuelAddCubit>().save();
                  },
          ),
        ),
      ],
    );
  }

  // #endregion
  Widget _buildGap() => R.widgets.hSizer8;
}
