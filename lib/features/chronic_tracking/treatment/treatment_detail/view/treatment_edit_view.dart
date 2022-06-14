import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../../core/core.dart';
import '../model/treatment_model.dart';
import '../view_model/treatment_edit_vm.dart';

class TreatmentEditView extends StatefulWidget {
  const TreatmentEditView({Key? key}) : super(key: key);

  @override
  State<TreatmentEditView> createState() => _TreatmentEditViewState();
}

class _TreatmentEditViewState extends State<TreatmentEditView> {
  late TextEditingController textEditingController;
  TreatmentModel? _treatmentModel;
  bool? newModel;
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
      if (Atom.queryParameters['newModel'] != null) {
        newModel = Atom.queryParameters['newModel'] == 'true';
      } else {
        throw Exception('newModel argument does not exist');
      }

      if (Atom.queryParameters['treatment_model'] != null) {
        _treatmentModel = TreatmentModel.fromJson(
            jsonDecode(Atom.queryParameters['treatment_model']!));
      } else {
        _treatmentModel = null;
        throw Exception('treatment_model argument does not exist');
      }
      textEditingController.text = _treatmentModel!.treatment!;
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return const RbioRouteError();
    }

    return KeyboardDismissOnTap(
      child: ChangeNotifierProvider<TreatmentEditVm>(
        create: (_) => TreatmentEditVm(_treatmentModel!),
        child: Consumer<TreatmentEditVm>(builder: (ctx, vm, __) {
          return RbioScaffold(
            appbar: _buildAppBar(),
            body: _buildBody(ctx, vm),
          );
        }),
      ),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.treatment_process,
        ),
      );

  Widget _buildBody(BuildContext ctx, TreatmentEditVm vm) => Column(
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
            child: Form(
              key: vm.formKey,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.cardBackgroundColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: RbioTextFormField(
                  autovalidateMode: vm.autovalidateMode,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    } else {
                      return LocaleProvider.current.validation;
                    }
                  },
                  controller: textEditingController,
                  maxLines: null,
                  enabled: newModel,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  border: RbioTextFormField.noneBorder(),
                ),
              ),
            ),
          ),

          //
          const SizedBox(
            height: 16,
          ),

          //
          if (newModel!) _buildButtons(ctx, vm),

          //
          SizedBox(
            height: Atom.safeBottom + 12,
          ),
        ],
      );

  Widget _buildButtons(BuildContext ctx, TreatmentEditVm vm) {
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
                  onTap: () {
                    if (vm.formKey?.currentState?.validate() ?? false) {
                      ctx
                          .read<TreatmentEditVm>()
                          .save(textEditingController.text);
                    } else {
                      LocaleProvider.current.validation;
                    }
                  },
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
                ctx.watch<TreatmentEditVm>().patientName,
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
                      .read<TreatmentEditVm>()
                      .selectedModel
                      .createDate
                      ?.toString()
                      .xGetUTCLocalDateTimeTwo() ??
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
