import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/health_information_vm.dart';
import '../widget/range_selection_slider.dart';

class HealthInformationScreen extends StatefulWidget {
  const HealthInformationScreen({Key key}) : super(key: key);

  @override
  _HealthInformationScreenState createState() =>
      _HealthInformationScreenState();
}

class _HealthInformationScreenState extends State<HealthInformationScreen> {
  TextEditingController diabetTypeController;
  TextEditingController weightController;
  TextEditingController normalRangeController;
  TextEditingController heightController;
  TextEditingController maxRangeController;
  TextEditingController minRangeController;
  TextEditingController smokerController;
  TextEditingController yearofDiagnosisController;

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
    return ChangeNotifierProvider<HealthInformationVm>(
      create: (context) => HealthInformationVm(context: context),
      child: Consumer<HealthInformationVm>(
        builder: (
          BuildContext context,
          HealthInformationVm vm,
          Widget child,
        ) {
          vm.changeTextFiels(
            diabetTypeController: diabetTypeController,
            heightController: heightController,
            maxRangeController: maxRangeController,
            minRangeController: minRangeController,
            normalRangeController: normalRangeController,
            smokerController: smokerController,
            weightController: weightController,
            yearofDiagnosisController: yearofDiagnosisController,
          );

          return KeyboardDismissOnTap(
            child: RbioLoadingOverlay(
              isLoading: false,
              progressIndicator: RbioLoading(),
              opacity: 0,
              child: RbioScaffold(
                appbar: RbioAppBar(
                  title: RbioAppBar.textTitle(
                    context,
                    LocaleProvider.current.health_information,
                  ),
                ),
                body: RbioLoadingOverlay(
                  isLoading: vm.showProgressOverlay,
                  progressIndicator: RbioLoading.progressIndicator(),
                  opacity: 0,
                  child: _buildBody(vm),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(HealthInformationVm vm) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Diabet Type
                _buildTitle(LocaleProvider.current.diabet_type),
                _buildTextField(
                  vm,
                  diabetTypeController,
                  HealthInformationType.DiabetType,
                ),

                // Height
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.height),
                _buildTextField(
                  vm,
                  heightController,
                  HealthInformationType.Height,
                ),

                // Weight
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.weight),
                _buildTextField(
                  vm,
                  weightController,
                  HealthInformationType.Weight,
                ),

                // Normal Range
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.normal_range),
                _buildTextField(
                  vm,
                  normalRangeController,
                  HealthInformationType.NormalRange,
                ),

                // Max Range
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.max_range),
                _buildTextField(
                  vm,
                  maxRangeController,
                  HealthInformationType.MaxRange,
                ),

                // Min Range
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.min_range),
                _buildTextField(
                  vm,
                  minRangeController,
                  HealthInformationType.MinRange,
                ),

                // Smoke
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.do_you_smoke),
                _buildTextField(
                  vm,
                  smokerController,
                  HealthInformationType.Smoker,
                ),

                // Year of Diagnosis
                _buildSpacer(),
                _buildTitle(LocaleProvider.current.year_of_diagnosis),
                _buildTextField(
                  vm,
                  yearofDiagnosisController,
                  HealthInformationType.YearofDiagnosis,
                ),

                //
                SizedBox(
                  height: Atom.safeBottom + 60,
                ),
              ],
            ),
          ),
        ),

        //
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: Atom.safeBottom + Atom.height * 0.05,
            ),
            child: RbioElevatedButton(
              title: LocaleProvider.current.update_information,
              onTap: () {
                vm.updateInformation(vm.selection);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSpacer() => SizedBox(height: 8);

  Widget _buildTitle(String title) => Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: context.xHeadline4,
        ),
      );

  Widget _buildTextField(
    HealthInformationVm vm,
    TextEditingController controller,
    HealthInformationType type,
  ) =>
      GestureDetector(
        onTap: () async {
          switch (type) {
            case HealthInformationType.DiabetType:
              vm.showDiabetsSheet();
              break;

            case HealthInformationType.Weight:
              vm.showWeightSheet();
              break;

            case HealthInformationType.NormalRange:
              {
                final result = await Atom.show(
                  RangeSelectionSlider(
                    id: vm.selection.id,
                    lowerValue: vm.selection.rangeMin.toDouble(),
                    upperValue: vm.selection.rangeMax.toDouble(),
                  ),
                );
                if (result != null) {
                  if (result is Map) {
                    vm.changeNormalRange(result);
                  }
                }
                break;
              }

            case HealthInformationType.Height:
              vm.showHeightSheet();
              break;

            case HealthInformationType.MaxRange:
              vm.showMaxRangeSheet();
              break;

            case HealthInformationType.MinRange:
              vm.showMinRangeSheet();
              break;

            case HealthInformationType.Smoker:
              vm.showSmokerSheet();
              break;

            case HealthInformationType.YearofDiagnosis:
              vm.showDiagnosisSheet();
              break;
          }
        },
        child: AbsorbPointer(
          absorbing: true,
          child: RbioTextFormField(
            controller: controller,
            border: RbioTextFormField.activeBorder(),
          ),
        ),
      );
}
