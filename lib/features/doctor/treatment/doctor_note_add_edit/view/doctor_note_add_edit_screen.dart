import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../cubit/doctor_note_add_edit_cubit.dart';

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
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider<DoctorNoteAddEditCubit>(
      create: (context) => DoctorNoteAddEditCubit(
        patientId,
        itemId,
        getIt(),
      )..setInitState(),
      child: Builder(builder: (context) {
        return BlocListener<DoctorNoteAddEditCubit, DoctorNoteAddEditState>(
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
    return BlocConsumer<DoctorNoteAddEditCubit, DoctorNoteAddEditState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if (!result.isLoading &&
                !widget.isCreated &&
                result.response != null) {
              _descriptionEditingController.text =
                  result.response!.treatmentNoteText ?? '';
              _titleEditingController.text =
                  result.response!.treatmentNoteTitle ?? '';
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

  RbioAppBar _buildAppBar(DoctorNoteAddEditState state) {
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

  Widget _buildBody(DoctorNoteAddEditState state) {
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
    DoctorNoteAddEditResult result,
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
                        ),
                      ),

                      //
                      R.sizes.hSizer8,

                      //
                      AbsorbPointer(
                        absorbing: true,
                        child: RbioTextFormField(
                          minLines: 1,
                          maxLines: null,
                          focusNode: _descriptionFocusNode,
                          controller: _descriptionEditingController,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          isDense: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ] else ...[
                      //
                      RbioTextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: _titleFocusNode,
                        controller: _titleEditingController,
                        hintText: LocaleProvider.of(context).title,
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
                        maxLines: null,
                        focusNode: _descriptionFocusNode,
                        controller: _descriptionEditingController,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        isDense: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
    DoctorNoteAddEditResult result,
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
                  context.read<DoctorNoteAddEditCubit>().changeScreenMode();
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
                            .read<DoctorNoteAddEditCubit>()
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
                                  .read<DoctorNoteAddEditCubit>()
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
      context.read<DoctorNoteAddEditCubit>().saveTreatmentNote(
            _titleEditingController.text.trim(),
            _descriptionEditingController.text.trim(),
          );
    }
  }
}
