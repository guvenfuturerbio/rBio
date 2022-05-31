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
    } catch (_) {
      return const RbioRouteError();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        R.sizes.stackedTopPadding(context),
        R.sizes.hSizer8,

        //
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: getIt<IAppConfig>().theme.cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: RbioKeyboardActions(
                focusList: [
                  _treatmentNoteFocusNode,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
                          contentPadding: EdgeInsets.zero,
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
                          ),
                        ),
                      ),
                    ] else ...[
                      RbioTextFormField(
                        minLines: 1,
                        maxLines: null,
                        contentPadding: EdgeInsets.zero,
                        focusNode: _treatmentNoteFocusNode,
                        controller: _treatmentNoteEditingController,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        isDense: true,
                        decoration: RbioTextFormField.defaultDecoration(
                          context,
                        ).copyWith(
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),

        //
        R.sizes.hSizer8,

        //
        KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) => Column(
            children: _buildBottomButtons(result, isKeyboardVisible),
          ),
        ),

        //
        R.sizes.defaultBottomPadding,
      ],
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
                      context
                          .read<PatientScaleTreatmentDetailCubit>()
                          .saveTreatmentNote(
                              _treatmentNoteEditingController.text.trim());
                    },
                  ),
                ),

                //
                R.sizes.wSizer8,

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
}
