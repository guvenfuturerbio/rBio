import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:onedosehealth/features/profile/health_information/cubit/health_information_cubit.dart';
import '../../../../core/core.dart';
import '../widget/range_selection_slider.dart';

class HealthInformationScreen extends StatelessWidget {
  const HealthInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthInformationCubit(),
      child: const HealthInformationView(),
    );
  }
}

class HealthInformationView extends StatefulWidget {
  const HealthInformationView({Key? key}) : super(key: key);

  @override
  _HealthInformationViewState createState() => _HealthInformationViewState();
}

class _HealthInformationViewState extends State<HealthInformationView> {
  late TextEditingController diabetTypeController;
  late TextEditingController weightController;
  late TextEditingController normalRangeController;
  late TextEditingController heightController;
  late TextEditingController maxRangeController;
  late TextEditingController minRangeController;
  late TextEditingController smokerController;
  late TextEditingController yearofDiagnosisController;

  @override
  void initState() {
    diabetTypeController = TextEditingController();
    weightController = TextEditingController();
    normalRangeController = TextEditingController();
    heightController = TextEditingController();
    maxRangeController = TextEditingController();
    minRangeController = TextEditingController();
    smokerController = TextEditingController();
    yearofDiagnosisController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    diabetTypeController.dispose();
    weightController.dispose();
    normalRangeController.dispose();
    heightController.dispose();
    maxRangeController.dispose();
    minRangeController.dispose();
    smokerController.dispose();
    yearofDiagnosisController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HealthInformationCubit, HealthInformationState>(
      listener: (context, state) {
        if (state.status == RbioLoadingProgress.success) {
          Utils.instance.showSuccessSnackbar(
            context,
            LocaleProvider.of(context).personal_update_success,
          );
        } else if (state.status == RbioLoadingProgress.failure) {
          Utils.instance.showErrorSnackbar(
            context,
            LocaleProvider.of(context).something_went_wrong,
          );
        }
      },
      builder: (context, state) {
        context.read<HealthInformationCubit>().changeTextFiels(
              diabetTypeController: diabetTypeController,
              weightController: weightController,
              heightController: heightController,
              normalRangeController: normalRangeController,
              maxRangeController: maxRangeController,
              minRangeController: minRangeController,
              smokerController: smokerController,
              yearofDiagnosisController: yearofDiagnosisController,
            );
        return KeyboardDismissOnTap(
          child: RbioStackedScaffold(
            isLoading: state.showProgressOverlay,
            appbar: _buildAppBar(context),
            body: _buildBody(state),
          ),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.health_information,
      ),
    );
  }

  Widget _buildBody(HealthInformationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: false,
            removeBottom: true,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    R.widgets.stackedTopPadding(context),
                    R.widgets.hSizer16,

                    // Diabet Type
                    _buildTitle(LocaleProvider.current.diabet_type),
                    _buildTextField(
                      state,
                      diabetTypeController,
                      HealthInformationType.diabetType,
                    ),

                    // Height
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.height),
                    _buildTextField(
                      state,
                      heightController,
                      HealthInformationType.height,
                    ),

                    // Weight
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.weight),
                    _buildTextField(
                      state,
                      weightController,
                      HealthInformationType.weight,
                    ),

                    // Max Range
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.max_range),
                    _buildTextField(
                      state,
                      maxRangeController,
                      HealthInformationType.maxRange,
                    ),

                    if (state.selection!.hyper! >= state.selection!.rangeMax! &&
                        state.selection!.hyper != 0) ...[
                      // Normal Range
                      _buildSpacer(),
                      _buildTitle(LocaleProvider.current.normal_range),
                      _buildTextField(
                        state,
                        normalRangeController,
                        HealthInformationType.normalRange,
                      ),
                    ],

                    // Min Range
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.min_range),
                    _buildTextField(
                      state,
                      minRangeController,
                      HealthInformationType.minRange,
                    ),

                    // Smoke
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.do_you_smoke),
                    _buildTextField(
                      state,
                      smokerController,
                      HealthInformationType.smoker,
                    ),

                    // Year of Diagnosis
                    _buildSpacer(),
                    _buildTitle(LocaleProvider.current.year_of_diagnosis),
                    _buildTextField(
                      state,
                      yearofDiagnosisController,
                      HealthInformationType.yearofDiagnosis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        //
        Container(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Center(
            child: RbioElevatedButton(
              infinityWidth: true,
              title: LocaleProvider.current.update_information,
              onTap: () async {
                await context
                    .read<HealthInformationCubit>()
                    .updateInformation(state.selection!);
              },
            ),
          ),
        ),

        //
        R.widgets.defaultBottomPadding,
      ],
    );
  }

  Widget _buildSpacer() => R.widgets.hSizer8;

  Widget _buildTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: context.xHeadline4,
        ),
      );

  Widget _buildTextField(
    HealthInformationState state,
    TextEditingController controller,
    HealthInformationType type,
  ) =>
      GestureDetector(
        onTap: () async {
          switch (type) {
            case HealthInformationType.diabetType:
              showDiabetsSheet(state);
              break;

            case HealthInformationType.weight:
              showWeightSheet(state);
              break;

            case HealthInformationType.normalRange:
              {
                getIt<ProfileStorageImpl>().getFirst().hyper =
                    state.selection!.hyper;
                final result = await Atom.show(
                  RangeSelectionSlider(
                    id: state.selection!.id!,
                    lowerValue: state.selection!.rangeMin!.toDouble(),
                    upperValue: state.selection!.rangeMax!.toDouble(),
                  ),
                );
                if (result != null) {
                  if (result is Map) {
                    context
                        .read<HealthInformationCubit>()
                        .changeNormalRange(result);
                  }
                }
                break;
              }

            case HealthInformationType.height:
              showHeightSheet(state);
              break;

            case HealthInformationType.maxRange:
              showMaxRangeSheet(state);
              break;

            case HealthInformationType.minRange:
              showMinRangeSheet(state);
              break;

            case HealthInformationType.smoker:
              showSmokerSheet(state);
              break;

            case HealthInformationType.yearofDiagnosis:
              showDiagnosisSheet(state);
              break;
          }
        },
        child: AbsorbPointer(
          absorbing: true,
          child: RbioTextFormField(
            controller: controller,
          ),
        ),
      );
  // #region showDiabetsSheet
  Future<void> showDiabetsSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.diabet_type,
      children: _getChildren(HealthInformationType.diabetType, state),
      initialItem: _getInitialItem(HealthInformationType.diabetType, state),
    );

    if (result != null) {
      switch (result) {
        case 1:
          context
              .read<HealthInformationCubit>()
              .changeDiabetsType(LocaleProvider.current.diabetes_type_1);
          break;

        case 2:
          context
              .read<HealthInformationCubit>()
              .changeDiabetsType(LocaleProvider.current.diabetes_type_2);
          break;

        default:
          context
              .read<HealthInformationCubit>()
              .changeDiabetsType(LocaleProvider.current.non_diabetes);
      }
    }
  }

  // #region showHeightSheet
  Future<void> showHeightSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.height,
      children: _getChildren(HealthInformationType.height, state),
      initialItem: _getInitialItem(HealthInformationType.height, state),
    );

    if (result != null) {
      final selectedHeight = result;
      context.read<HealthInformationCubit>().changeHeight(selectedHeight);
    }
  }

  // #endregion
  // #region showWeightSheet
  Future<void> showWeightSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.weight,
      children: _getChildren(HealthInformationType.weight, state),
      initialItem: _getInitialItem(HealthInformationType.weight, state),
    );

    if (result != null) {
      final selectedWeight = result;
      context.read<HealthInformationCubit>().changeWeight(selectedWeight);
    }
  }

  // #endregion
  // #region showMaxRangeSheet
  Future<void> showMaxRangeSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.max_range,
      children: _getChildren(HealthInformationType.maxRange, state),
      initialItem: _getInitialItem(HealthInformationType.maxRange, state),
    );

    if (result != null) {
      final _selectedMaxRange =
          context.read<HealthInformationCubit>().getMaxRangeList()[result];
      context.read<HealthInformationCubit>().changeMaxRange(_selectedMaxRange);
      state.selection!.hyper = _selectedMaxRange;
    }
  }

  // #endregion
  // #region showMinRangeSheet
  Future<void> showMinRangeSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.min_range,
      children: _getChildren(HealthInformationType.minRange, state),
      initialItem: _getInitialItem(HealthInformationType.minRange, state),
    );

    if (result != null) {
      final _selectedMinRange = result;
      context.read<HealthInformationCubit>().changeMinRange(_selectedMinRange);
    }
  }
  // #endregion

  // #region showDiagnosisSheet
  Future<void> showDiagnosisSheet(HealthInformationState state) async {
    {
      final result = await showRbioSelectBottomSheet(
        context,
        title: LocaleProvider.current.year_of_diagnosis,
        children: _getChildren(HealthInformationType.yearofDiagnosis, state),
        initialItem:
            _getInitialItem(HealthInformationType.yearofDiagnosis, state),
      );

      if (result != null) {
        final selectedYear = (DateTime.now().year - result).toInt();
        context.read<HealthInformationCubit>().changeDiagnosis(selectedYear);
      }
    }
  }

  // #endregion
  // #region _getChildren
  List<Widget> _getChildren(
      HealthInformationType type, HealthInformationState state) {
    TextStyle _bottomTextStyle =
        CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle;

    switch (type) {
      case HealthInformationType.diabetType:
        {
          return [
            Center(
              child: Text(
                LocaleProvider.current.non_diabetes,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.current.diabetes_type_1,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.current.diabetes_type_2,
                style: _bottomTextStyle,
              ),
            ),
          ];
        }

      case HealthInformationType.height:
        {
          return List.generate(
            250,
            (index) => Center(
              child: Text(
                '$index cm',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.weight:
        {
          return List.generate(
            250,
            (index) => Center(
              child: Text(
                '$index kg',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.smoker:
        {
          return [
            Center(
              child: Text(
                LocaleProvider.current.non_smoker,
                style: _bottomTextStyle,
              ),
            ),
            Center(
              child: Text(
                LocaleProvider.current.smoker,
                style: _bottomTextStyle,
              ),
            ),
          ];
        }

      case HealthInformationType.yearofDiagnosis:
        {
          return List.generate(
            100,
            (index) => Center(
              child: Text(
                '${DateTime.now().year - index}',
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      case HealthInformationType.maxRange:
        {
          return context
              .read<HealthInformationCubit>()
              .getMaxRangeList()
              .map(
                (e) => Center(
                  child: Text(
                    (e).toString() + " mg/dL.",
                    style: _bottomTextStyle,
                  ),
                ),
              )
              .toList();
        }

      case HealthInformationType.minRange:
        {
          return List.generate(
            (state.selection?.rangeMin ?? 50 + 10) ~/ 10,
            (index) => Center(
              child: Text(
                (index * 10).toString() + " mg/dL.",
                style: _bottomTextStyle,
              ),
            ),
          );
        }

      default:
        throw Exception('Undefined type.');
    }
  }
  // #endregion

  // #region _getInitialItem
  int _getInitialItem(
      HealthInformationType type, HealthInformationState state) {
    switch (type) {
      case HealthInformationType.diabetType:
        {
          return (state.selection?.diabetesType == "Type 1" ||
                  state.selection?.diabetesType == "Tip 1")
              ? 1
              : ((state.selection!.diabetesType == "Type 2" ||
                      state.selection!.diabetesType == "Tip 2")
                  ? 2
                  : 0);
        }

      case HealthInformationType.height:
        {
          return int.tryParse(state.selection?.height ?? '170') ?? 150;
        }

      case HealthInformationType.weight:
        return state.selection?.weight == 'null'
            ? 0
            : int.tryParse(state.selection?.weight ?? '70') ?? 50;

      case HealthInformationType.smoker:
        {
          return state.selection?.smoker == null
              ? 0
              : state.selection?.smoker ?? false
                  ? 1
                  : 0;
        }

      case HealthInformationType.yearofDiagnosis:
        {
          return state.selection?.yearOfDiagnosis != null
              ? DateTime.now().year - (state.selection?.yearOfDiagnosis ?? 2001)
              : 0;
        }

      case HealthInformationType.maxRange:
        {
          return context
              .read<HealthInformationCubit>()
              .getMaxRangeList()
              .indexOf(state.selection!.hyper!);
        }

      case HealthInformationType.minRange:
        {
          return state.selection!.hypo! ~/ 10;
        }

      default:
        throw Exception('Undefined type.');
    }
  }

  // #endregion
  // #region showSmokerSheet
  Future<void> showSmokerSheet(HealthInformationState state) async {
    final result = await showRbioSelectBottomSheet(
      context,
      title: LocaleProvider.current.do_you_smoke,
      children: _getChildren(HealthInformationType.smoker, state),
      initialItem: _getInitialItem(HealthInformationType.smoker, state),
    );

    if (result != null) {
      switch (result) {
        case 0:
          context.read<HealthInformationCubit>().changeSmokerType(false);
          break;

        default:
          context.read<HealthInformationCubit>().changeSmokerType(true);
      }
    }
  }
  // #endregion

}
