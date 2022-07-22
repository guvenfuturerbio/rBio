import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../../../core/core.dart';
import '../../scale.dart';

class PatientScaleTreatmentDetailScreen extends StatelessWidget {
  const PatientScaleTreatmentDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemId;

    try {
      final routeParam = Atom.queryParameters['itemId'];
      itemId = int.tryParse(routeParam!);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider<PatientScaleTreatmentDetailCubit>(
      create: (context) =>
          PatientScaleTreatmentDetailCubit(getIt(), getIt())..fetchAll(itemId!),
      child: Builder(builder: (context) {
        return BlocListener<PatientScaleTreatmentDetailCubit,
            PatientScaleTreatmentDetailState>(
          listener: (context, state) {
            state.whenOrNull(
              openListScreen: () {
                Atom.historyBack();
              },
            );
          },
          child: const PatientScaleTreatmentDetailView(),
        );
      }),
    );
  }
}

class PatientScaleTreatmentDetailView extends StatefulWidget {
  const PatientScaleTreatmentDetailView({Key? key}) : super(key: key);

  @override
  State<PatientScaleTreatmentDetailView> createState() =>
      _PatientScaleTreatmentDetailViewState();
}

class _PatientScaleTreatmentDetailViewState
    extends State<PatientScaleTreatmentDetailView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _treatmentNoteEditingController;
  late FocusNode _treatmentNoteFocusNode;

  @override
  void initState() {
    super.initState();
    _treatmentNoteEditingController = TextEditingController();
    _treatmentNoteFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _treatmentNoteEditingController.dispose();
    _treatmentNoteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientScaleTreatmentDetailCubit,
        PatientScaleTreatmentDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if (!result.isLoading) {
              _treatmentNoteEditingController.text =
                  result.response.treatmentNoteText ?? '';
            }
          },
        );
      },
      buildWhen: (previous, current) =>
          current.whenOrNull(
            openListScreen: () => false,
          ) ??
          true,
      builder: (context, state) {
        return RbioStackedScaffold(
          resizeToAvoidBottomInset: false,
          isLoading:
              state.whenOrNull(success: (result) => result.isLoading) ?? false,
          appbar: _buildAppBar(state),
          body: _buildBody(state),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(PatientScaleTreatmentDetailState state) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        state.whenOrNull(
                success: (result) =>
                    result.editMode.xGetTreatmentTitle(context)) ??
            LocaleProvider.of(context).diet_list,
      ),
    );
  }

  Widget _buildBody(PatientScaleTreatmentDetailState state) {
    return state.whenOrNull(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (result) => _buildSuccess(context, result),
          failure: () => const RbioBodyError(),
        ) ??
        const SizedBox();
  }

  Widget _buildSuccess(
    BuildContext context,
    PatientScaleTreatmentDetailResult result,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          R.widgets.stackedTopPadding(context),
          R.widgets.hSizer8,

          //
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: RbioKeyboardActions(
                focusList: [
                  _treatmentNoteFocusNode,
                ],
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    right: 8,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.xCardColor,
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //
                      R.widgets.hSizer8,

                      //
                      if (result.editMode ==
                          ScaleTreatmentScreenEditMode.readOnly) ...[
                        Text(
                          result.response.createdByName ?? '',
                          style: context.xHeadline4.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //
                        const Divider(),

                        //
                        AbsorbPointer(
                          absorbing: true,
                          child: RbioTextFormField(
                            minLines: 1,
                            maxLines: null,
                            focusNode: _treatmentNoteFocusNode,
                            controller: _treatmentNoteEditingController,
                            textInputAction: TextInputAction.newline,
                            decoration: RbioTextFormField.defaultDecoration(
                              context,
                            ).copyWith(
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintText:
                                  LocaleProvider.of(context).add_treatment_note,
                            ),
                          ),
                        ),
                      ] else ...[
                        RbioTextFormField(
                          minLines: 1,
                          maxLines: null,
                          focusNode: _treatmentNoteFocusNode,
                          controller: _treatmentNoteEditingController,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          isDense: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: RbioTextFormField.defaultDecoration(
                            context,
                          ).copyWith(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            hintText:
                                LocaleProvider.of(context).add_treatment_note,
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else {
                              return LocaleProvider.current.validation;
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          //
          R.widgets.hSizer8,

          //
          KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) => Column(
              children: _buildBottomButtons(result, isKeyboardVisible),
            ),
          ),

          //
          R.widgets.defaultBottomPadding,
        ],
      ),
    );
  }

  List<Widget> _buildBottomButtons(
    PatientScaleTreatmentDetailResult result,
    bool isKeyboardVisible,
  ) {
    if (isKeyboardVisible) return [];

    return result.editMode == ScaleTreatmentScreenEditMode.readOnly
        ? [
            RbioElevatedButton(
              infinityWidth: true,
              title: LocaleProvider.current.update,
              onTap: () {
                context
                    .read<PatientScaleTreatmentDetailCubit>()
                    .changeScreenMode();
              },
            ),
          ]
        : [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  child: RbioElevatedButton(
                    title: LocaleProvider.current.save,
                    onTap: () {
                      _saveTreatmentNote();
                    },
                  ),
                ),

                //
                R.widgets.wSizer8,

                //
                Expanded(
                  child: RbioWhiteButton(
                    title: LocaleProvider.current.btn_cancel,
                    onTap: () {
                      Atom.historyBack();
                    },
                  ),
                ),
              ],
            ),
          ];
  }

  void _saveTreatmentNote() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<PatientScaleTreatmentDetailCubit>()
          .saveTreatmentNote(_treatmentNoteEditingController.text.trim());
    }
  }
}
