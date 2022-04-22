import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/treatment_model/treatment_model.dart';
import '../view_model/patient_treatment_vm.dart';

class PatientTreatmentEditView extends StatefulWidget {
  const PatientTreatmentEditView({Key? key}) : super(key: key);

  @override
  State<PatientTreatmentEditView> createState() =>
      _PatientTreatmentEditViewState();
}

class _PatientTreatmentEditViewState extends State<PatientTreatmentEditView> {
  late TextEditingController textEditingController;
  late TreatmentModel _treatmentModel;
  late bool newModel;

  @override
  void initState() {
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      newModel = Atom.queryParameters['newModel'] == 'true';
      _treatmentModel = TreatmentModel.fromJson(
          jsonDecode(Atom.queryParameters['treatment_model']!));
      textEditingController.text = _treatmentModel.treatment!;
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      LoggerUtils.instance.e(e.toString());
      return const RbioRouteError();
    }

    return KeyboardDismissOnTap(
      child: ChangeNotifierProvider<PatientTreatmentEditVm>(
        create: (_) => PatientTreatmentEditVm(_treatmentModel),
        child: Consumer<PatientTreatmentEditVm>(
          builder: (ctx, vm, __) {
            return RbioScaffold(
              appbar: _buildAppBar(),
              body: _buildBody(ctx),
            );
          },
        ),
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
        actions: [
          Center(
            child: RbioBadge(
              image: R.image.chat,
              isDark: false,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      );

  Widget _buildBody(BuildContext ctx) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildUserCard(ctx),

          //
          _buildTimeRow(ctx),

          //
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              LocaleProvider.current.notes,
              textAlign: TextAlign.start,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: getIt<IAppConfig>().theme.cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: RbioTextFormField(
                controller: textEditingController,
                maxLines: null,
                enabled: newModel,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                border: RbioTextFormField.noneBorder(),
              ),
            ),
          ),

          //
          const SizedBox(
            height: 16,
          ),

          //
          if (newModel) _buildButtons(ctx),

          //
          SizedBox(
            height: Atom.safeBottom + 12,
          ),
        ],
      );

  Widget _buildButtons(BuildContext ctx) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (!isKeyboardVisible) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.current.save,
                  onTap: () => ctx
                      .read<PatientTreatmentEditVm>()
                      .save(textEditingController.text),
                  showElevation: false,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildUserCard(BuildContext ctx) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getIt<IAppConfig>().theme.cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(R.image.circlevatar),
            backgroundColor: getIt<IAppConfig>().theme.cardBackgroundColor,
          ),

          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                ctx.watch<PatientTreatmentEditVm>().patientName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTimeRow(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              ctx
                      .read<PatientTreatmentEditVm>()
                      .selectedModel
                      .createDate
                      ?.xFormatTime9() ??
                  DateTime.now().xFormatTime9(),
              textAlign: TextAlign.end,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
