import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../cubit/doctor_scale_doctor_note_add_edit_cubit.dart';

class DoctorScaleDoctorNoteAddEditScreen extends StatelessWidget {
  const DoctorScaleDoctorNoteAddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemId;
    late int patientId;

    try {
      final routeParam = Atom.queryParameters['itemId'];
      if (routeParam != null) {
        itemId = int.tryParse(routeParam);
      }
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return const RbioRouteError();
    }

    return BlocProvider<DoctorScaleDoctorNoteAddEditCubit>(
      create: (context) => DoctorScaleDoctorNoteAddEditCubit(
        patientId,
        itemId,
        getIt(),
      )..setInitState(),
      child: Builder(builder: (context) {
        return BlocListener<DoctorScaleDoctorNoteAddEditCubit,
            DoctorScaleDoctorNoteAddEditState>(
          listener: (context, state) {
            state.whenOrNull(
              openListScreen: () {
                Atom.historyBack();
              },
            );
          },
          child: DoctorScaleDoctorNoteAddEditView(isCreated: itemId == null),
        );
      }),
    );
  }
}

class DoctorScaleDoctorNoteAddEditView extends StatefulWidget {
  final bool isCreated;

  const DoctorScaleDoctorNoteAddEditView({
    Key? key,
    required this.isCreated,
  }) : super(key: key);

  @override
  State<DoctorScaleDoctorNoteAddEditView> createState() =>
      _DoctorScaleDoctorNoteAddEditViewState();
}

class _DoctorScaleDoctorNoteAddEditViewState
    extends State<DoctorScaleDoctorNoteAddEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleEditingController;
  late TextEditingController _descriptionEditingController;

  late FocusNode _titleFocusNode;
  late FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController();
    _descriptionEditingController = TextEditingController();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorScaleDoctorNoteAddEditCubit,
        DoctorScaleDoctorNoteAddEditState>(
      listener:
          (BuildContext context, DoctorScaleDoctorNoteAddEditState state) {
        state.whenOrNull(
          success: (result) {
            if (!result.status.xIsLoadInProgress &&
                !widget.isCreated &&
                result.response != null) {
              _descriptionEditingController.text =
                  result.response!.treatmentNoteText ?? '';
              _titleEditingController.text =
                  result.response!.treatmentNoteTitle ?? '';
            }

            if (result.status.xIsFailure) {
              Utils.instance.showErrorSnackbar(
                context,
                LocaleProvider.of(context).something_went_wrong,
              );
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
          isLoading: state.whenOrNull(
                  success: (result) => result.status.xIsLoadInProgress) ??
              false,
          appbar: _buildAppBar(state),
          body: _buildBody(state),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(DoctorScaleDoctorNoteAddEditState state) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        widget.isCreated
            ? LocaleProvider.of(context).add_special_note
            : state.whenOrNull(
                    success: (result) =>
                        result.editMode.xGetDoctorNoteTitle(context)) ??
                LocaleProvider.of(context).special_note,
      ),
    );
  }

  Widget _buildBody(DoctorScaleDoctorNoteAddEditState state) {
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
    DoctorScaleDoctorNoteAddEditResult result,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: RbioKeyboardActions(
                focusList: [
                  _titleFocusNode,
                  _descriptionFocusNode,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    R.sizes.hSizer8,

                    //
                    if (result.editMode ==
                        ScaleTreatmentScreenEditMode.readOnly) ...[
                      //
                      AbsorbPointer(
                        absorbing: true,
                        child: RbioTextFormField(
                          focusNode: _titleFocusNode,
                          controller: _titleEditingController,
                          hintText: LocaleProvider.of(context).title,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),

                      //
                      R.sizes.hSizer8,

                      //
                      AbsorbPointer(
                        absorbing: true,
                        child: RbioTextFormField(
                          minLines: 1,
                          isDense: true,
                          maxLines: null,
                          focusNode: _descriptionFocusNode,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          controller: _descriptionEditingController,
                          hintText: LocaleProvider.of(context).description,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ] else ...[
                      //
                      RbioTextFormField(
                        focusNode: _titleFocusNode,
                        controller: _titleEditingController,
                        hintText: LocaleProvider.of(context).title,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return LocaleProvider.current.validation;
                          }
                        },
                      ),

                      //
                      R.sizes.hSizer8,

                      //
                      RbioTextFormField(
                        minLines: 1,
                        isDense: true,
                        maxLines: null,
                        focusNode: _descriptionFocusNode,
                        keyboardType: TextInputType.multiline,
                        controller: _descriptionEditingController,
                        textInputAction: TextInputAction.newline,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: LocaleProvider.of(context).description,
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
      ),
    );
  }

  List<Widget> _buildBottomButtons(
    DoctorScaleDoctorNoteAddEditResult result,
    bool isKeyboardVisible,
  ) {
    if (isKeyboardVisible) return [];

    if (widget.isCreated) {
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: RbioElevatedButton(
                infinityWidth: true,
                title: LocaleProvider.current.save,
                onTap: () {
                  context
                      .read<DoctorScaleDoctorNoteAddEditCubit>()
                      .changeScreenMode();
                  _saveTreatmentNote();
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
    } else {
      return result.editMode == ScaleTreatmentScreenEditMode.readOnly
          ? [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Expanded(
                    child: RbioElevatedButton(
                      infinityWidth: true,
                      title: LocaleProvider.current.update,
                      onTap: () {
                        context
                            .read<DoctorScaleDoctorNoteAddEditCubit>()
                            .changeScreenMode();
                      },
                    ),
                  ),

                  //
                  R.sizes.wSizer8,

                  //
                  Expanded(
                    child: RbioRedButton(
                      infinityWidth: true,
                      title: LocaleProvider.current.delete,
                      onTap: () {
                        Atom.show(
                          RbioDeleteConfirmationDialog(
                            description:
                                LocaleProvider.of(context).delete_special_note,
                            deleteConfirm: () {
                              context
                                  .read<DoctorScaleDoctorNoteAddEditCubit>()
                                  .deleteTreatmentNote();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
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

  void _saveTreatmentNote() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<DoctorScaleDoctorNoteAddEditCubit>().saveTreatmentNote(
            _titleEditingController.text.trim(),
            _descriptionEditingController.text.trim(),
          );
    }
  }
}
