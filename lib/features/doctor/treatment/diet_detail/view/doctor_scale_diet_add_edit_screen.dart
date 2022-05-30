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
    } catch (_) {
      return const RbioRouteError();
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
            child: const DoctorScaleDietAddEditView(),
          );
        },
      ),
    );
  }
}

class DoctorScaleDietAddEditView extends StatefulWidget {
  const DoctorScaleDietAddEditView({Key? key}) : super(key: key);

  @override
  State<DoctorScaleDietAddEditView> createState() =>
      _DoctorScaleDietAddEditViewState();
}

class _DoctorScaleDietAddEditViewState
    extends State<DoctorScaleDietAddEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleEditingController;
  late TextEditingController _breakfastEditingController;
  late TextEditingController _refreshmentEditingController;
  late TextEditingController _lunchEditingController;
  late TextEditingController _dinnerEditingController;

  late FocusNode _titleFocusNode;
  late FocusNode _breakfastFocusNode;
  late FocusNode _refreshmentFocusNode;
  late FocusNode _lunchFocusNode;
  late FocusNode _dinnerFocusNode;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController();
    _breakfastEditingController = TextEditingController();
    _refreshmentEditingController = TextEditingController();
    _lunchEditingController = TextEditingController();
    _dinnerEditingController = TextEditingController();
    _titleFocusNode = FocusNode();
    _breakfastFocusNode = FocusNode();
    _refreshmentFocusNode = FocusNode();
    _lunchFocusNode = FocusNode();
    _dinnerFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _breakfastEditingController.dispose();
    _refreshmentEditingController.dispose();
    _lunchEditingController.dispose();
    _dinnerEditingController.dispose();
    _titleFocusNode.dispose();
    _breakfastFocusNode.dispose();
    _refreshmentFocusNode.dispose();
    _lunchFocusNode.dispose();
    _dinnerFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorScaleDietAddEditCubit,
        DoctorScaleDietAddEditState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            if (!result.isLoading) {
              if (!result.isCreated && result.response != null) {
                _titleEditingController.text = result.response!.dietTitle ?? '';
                _breakfastEditingController.text =
                    result.response!.dietBreakfast ?? '';
                _refreshmentEditingController.text =
                    result.response!.dietRefreshment ?? '';
                _lunchEditingController.text = result.response!.dietLunch ?? '';
                _dinnerEditingController.text =
                    result.response!.dietDinner ?? '';
              }
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

  RbioAppBar _buildAppBar(DoctorScaleDietAddEditState state) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          state.whenOrNull(
                  success: (result) =>
                      result.screenMode.xGetDietTitle(context)) ??
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
                  _breakfastFocusNode,
                  _refreshmentFocusNode,
                  _lunchFocusNode,
                  _dinnerFocusNode,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    R.sizes.hSizer8,

                    //
                    if (result.screenMode ==
                        ScaleTreatmentScreenMode.readOnly) ...[
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

                    R.sizes.hSizer8,
                    R.sizes.hSizer8,

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
                    R.sizes.hSizer8,

                    //
                    _buildTitle(
                      context,
                      LocaleProvider.of(context).refreshment,
                    ),
                    _buildTextFormField(
                      result,
                      _refreshmentFocusNode,
                      _refreshmentEditingController,
                      R.image.clockRefreshment,
                    ),

                    //
                    R.sizes.hSizer8,

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
                    R.sizes.hSizer8,

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
        if (result.screenMode == ScaleTreatmentScreenMode.readOnly) ...[
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

    if (result.isCreated) {
      return [];
    } else {
      return result.screenMode == ScaleTreatmentScreenMode.readOnly
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
                        if (_formKey.currentState?.validate() ?? false) {
                          context
                              .read<DoctorScaleDietAddEditCubit>()
                              .saveDietList(
                                title: _titleEditingController.text.trim(),
                                breakfast:
                                    _breakfastEditingController.text.trim(),
                                refreshment:
                                    _refreshmentEditingController.text.trim(),
                                lunch: _lunchEditingController.text.trim(),
                                dinner: _dinnerEditingController.text.trim(),
                              );
                        }
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
}
