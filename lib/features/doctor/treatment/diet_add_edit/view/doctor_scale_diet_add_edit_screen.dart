import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/core.dart';
import '../../../../chronic_tracking/scale/scale.dart';
import '../cubit/doctor_scale_diet_add_edit_cubit.dart';

class DoctorScaleDietAddEditScreen extends StatelessWidget {
  const DoctorScaleDietAddEditScreen({Key? key}) : super(key: key);

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
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider<DoctorScaleDietAddEditCubit>(
      create: (context) => DoctorScaleDietAddEditCubit(
        patientId,
        itemId,
        getIt(),
      )..setInitState(),
      child: Builder(
        builder: (context) {
          return BlocListener<DoctorScaleDietAddEditCubit,
              DoctorScaleDietAddEditState>(
            listener: (context, state) {
              state.whenOrNull(
                openListScreen: () {
                  Atom.historyBack();
                },
              );
            },
            child: DoctorScaleDietAddEditView(isCreated: itemId == null),
          );
        },
      ),
    );
  }
}

class DoctorScaleDietAddEditView extends StatefulWidget {
  final bool isCreated;

  const DoctorScaleDietAddEditView({
    Key? key,
    required this.isCreated,
  }) : super(key: key);

  @override
  State<DoctorScaleDietAddEditView> createState() =>
      _DoctorScaleDietAddEditViewState();
}

class _DoctorScaleDietAddEditViewState
    extends State<DoctorScaleDietAddEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleEditingController;
  late TextEditingController _breakfastEditingController;
  late TextEditingController _breakfastRefreshmentEditingController;
  late TextEditingController _lunchEditingController;
  late TextEditingController _lunchRefreshmentEditingController;
  late TextEditingController _dinnerEditingController;
  late TextEditingController _dinnerRefreshmentEditingController;

  late FocusNode _titleFocusNode;
  late FocusNode _breakfastFocusNode;
  late FocusNode _breakfastRefreshmentFocusNode;
  late FocusNode _lunchFocusNode;
  late FocusNode _lunchRefreshmentFocusNode;
  late FocusNode _dinnerFocusNode;
  late FocusNode _dinnerRefreshmentFocusNode;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController();
    _breakfastEditingController = TextEditingController();
    _breakfastRefreshmentEditingController = TextEditingController();
    _lunchEditingController = TextEditingController();
    _lunchRefreshmentEditingController = TextEditingController();
    _dinnerEditingController = TextEditingController();
    _dinnerRefreshmentEditingController = TextEditingController();
    _titleFocusNode = FocusNode();
    _breakfastFocusNode = FocusNode();
    _breakfastRefreshmentFocusNode = FocusNode();
    _lunchFocusNode = FocusNode();
    _lunchRefreshmentFocusNode = FocusNode();
    _dinnerFocusNode = FocusNode();
    _dinnerRefreshmentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _breakfastEditingController.dispose();
    _breakfastRefreshmentEditingController.dispose();
    _lunchEditingController.dispose();
    _lunchRefreshmentEditingController.dispose();
    _dinnerEditingController.dispose();
    _dinnerRefreshmentEditingController.dispose();
    _titleFocusNode.dispose();
    _breakfastFocusNode.dispose();
    _breakfastRefreshmentFocusNode.dispose();
    _lunchFocusNode.dispose();
    _lunchRefreshmentFocusNode.dispose();
    _dinnerFocusNode.dispose();
    _dinnerRefreshmentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorScaleDietAddEditCubit,
        DoctorScaleDietAddEditState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if ((!result.status.xIsLoadInProgress) &&
                !widget.isCreated &&
                result.response != null) {
              _titleEditingController.text = result.response!.dietTitle ?? '';
              _breakfastEditingController.text =
                  result.response!.dietBreakfast ?? '';
              _breakfastRefreshmentEditingController.text =
                  result.response!.dietRefreshmentBreakfast ?? '';
              _lunchEditingController.text = result.response!.dietLunch ?? '';
              _lunchRefreshmentEditingController.text =
                  result.response!.dietRefreshmentLunch ?? '';
              _dinnerEditingController.text = result.response!.dietDinner ?? '';
              _dinnerRefreshmentEditingController.text =
                  result.response!.dietRefreshmentDinner ?? '';
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

  RbioAppBar _buildAppBar(DoctorScaleDietAddEditState state) => RbioAppBar(
        context: context,
        title: RbioAppBar.textTitle(
          context,
          widget.isCreated
              ? LocaleProvider.of(context).add_diet_list
              : state.whenOrNull(
                      success: (result) =>
                          result.editMode.xGetDietTitle(context)) ??
                  LocaleProvider.of(context).diet_list,
        ),
      );

  Widget _buildBody(DoctorScaleDietAddEditState state) {
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
    DoctorScaleDietAddEditResult result,
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
                  _titleFocusNode,
                  _breakfastFocusNode,
                  _breakfastRefreshmentFocusNode,
                  _lunchFocusNode,
                  _lunchRefreshmentFocusNode,
                  _dinnerFocusNode,
                  _dinnerRefreshmentFocusNode,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    R.widgets.hSizer8,

                    //
                    if (result.editMode ==
                        ScaleTreatmentScreenEditMode.readOnly) ...[
                      AbsorbPointer(
                        absorbing: true,
                        child: RbioTextFormField(
                          focusNode: _titleFocusNode,
                          controller: _titleEditingController,
                          hintText: LocaleProvider.of(context).title,
                        ),
                      ),
                    ] else ...[
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
                    ],

                    //
                    R.widgets.hSizer8,
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).breakfast,
                    ),
                    _buildTextFormField(
                      result,
                      _breakfastFocusNode,
                      _breakfastEditingController,
                      R.image.clockBreakfast,
                    ),

                    //
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).refreshment,
                    ),
                    _buildTextFormField(
                      result,
                      _breakfastRefreshmentFocusNode,
                      _breakfastRefreshmentEditingController,
                      R.image.clockRefreshment,
                    ),

                    //
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).lunch,
                    ),
                    _buildTextFormField(
                      result,
                      _lunchFocusNode,
                      _lunchEditingController,
                      R.image.clockLunch,
                    ),

                    //
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).refreshment,
                    ),
                    _buildTextFormField(
                      result,
                      _lunchRefreshmentFocusNode,
                      _lunchRefreshmentEditingController,
                      R.image.clockRefreshment,
                    ),

                    //
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).dinner,
                    ),
                    _buildTextFormField(
                      result,
                      _dinnerFocusNode,
                      _dinnerEditingController,
                      R.image.clockDinner,
                    ),

                    //
                    R.widgets.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).dinner,
                    ),
                    _buildTextFormField(
                      result,
                      _dinnerRefreshmentFocusNode,
                      _dinnerRefreshmentEditingController,
                      R.image.clockDinner,
                    ),
                  ],
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

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    DoctorScaleDietAddEditResult result,
    FocusNode focusNode,
    TextEditingController controller,
    String imagePath,
  ) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        //
        if (result.editMode == ScaleTreatmentScreenEditMode.readOnly) ...[
          AbsorbPointer(
            absorbing: true,
            child: RbioTextFormField(
              focusNode: focusNode,
              minLines: 1,
              maxLines: null,
              controller: controller,
              contentPadding: const EdgeInsets.all(12),
              textInputAction: TextInputAction.newline,
            ),
          ),
        ] else ...[
          RbioTextFormField(
            focusNode: focusNode,
            minLines: 1,
            maxLines: null,
            controller: controller,
            contentPadding: const EdgeInsets.all(12),
            textInputAction: TextInputAction.newline,
          ),
        ],

        //
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            imagePath,
            height: R.sizes.iconSize2,
            width: R.sizes.iconSize2,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBottomButtons(
    DoctorScaleDietAddEditResult result,
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
                      .read<DoctorScaleDietAddEditCubit>()
                      .changeScreenMode();
                  _saveDietList();
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
        )
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
                            .read<DoctorScaleDietAddEditCubit>()
                            .changeScreenMode();
                      },
                    ),
                  ),

                  //
                  R.widgets.wSizer8,

                  //
                  Expanded(
                    child: RbioRedButton(
                      infinityWidth: true,
                      title: LocaleProvider.current.delete,
                      onTap: () {
                        Atom.show(
                          RbioDeleteConfirmationDialog(
                            description:
                                LocaleProvider.of(context).delete_diet_list,
                            deleteConfirm: () {
                              context
                                  .read<DoctorScaleDietAddEditCubit>()
                                  .deleteDietList();
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
                        _saveDietList();
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
  }

  void _saveDietList() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<DoctorScaleDietAddEditCubit>().saveDietList(
            title: _titleEditingController.text.trim(),
            breakfast: _breakfastEditingController.text.trim(),
            breakfastRefreshment:
                _breakfastRefreshmentEditingController.text.trim(),
            lunch: _lunchEditingController.text.trim(),
            lunchRefreshment: _lunchRefreshmentEditingController.text.trim(),
            dinner: _dinnerEditingController.text.trim(),
            dinnerRefreshment: _dinnerRefreshmentEditingController.text.trim(),
          );
    }
  }
}
