import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/core.dart';
import '../../mediminder.dart';

part 'widget/strip_counter_dialog.dart';

class StripReminderAddEditScreen extends StatelessWidget {
  const StripReminderAddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StripReminderAddEditCubitCubit>(
      create: (context) => StripReminderAddEditCubitCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..setInitState(),
      child: const StripReminderAddEditView(),
    );
  }
}

class StripReminderAddEditView extends StatefulWidget {
  const StripReminderAddEditView({Key? key}) : super(key: key);

  @override
  _StripReminderAddEditViewState createState() =>
      _StripReminderAddEditViewState();
}

class _StripReminderAddEditViewState extends State<StripReminderAddEditView> {
  late TextEditingController _stripCountController;
  late TextEditingController _alarmController;

  var _modeOfStrip = StripMode.none;

  @override
  void initState() {
    super.initState();
    _stripCountController = TextEditingController();
    _alarmController = TextEditingController();
  }

  @override
  void dispose() {
    _stripCountController.dispose();
    _alarmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioScaffold(
        extendBodyBehindAppBar: true,
        appbar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.strip_tracker,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody() {
    return BlocConsumer<StripReminderAddEditCubitCubit,
        StripReminderAddEditCubitState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        state.whenOrNull(
          success: (result) {
            _alarmController.text = result.alarmCount.toString();
            _stripCountController.text = result.stripCount.toString();
            _stripCountController.selection = TextSelection.collapsed(
              offset: result.stripCount.toString().length,
            );
            _alarmController.selection = TextSelection.collapsed(
              offset: result.alarmCount.toString().length,
            );
          },
          showSuccessMessage: () {
            Utils.instance.showSuccessSnackbar(
              context,
              LocaleProvider.of(context).successfully_updated,
            );
          },
        );
      },
      buildWhen: (previous, current) =>
          current.whenOrNull(showSuccessMessage: () => false) ?? true,
      builder: (context, state) {
        return state.whenOrNull(
              initial: () => const SizedBox(),
              loadInProgress: () => const RbioLoading(),
              success: (result) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: _buildScrollBody(result),
                    ),

                    //
                    _buildButtons(),

                    //
                    SizedBox(
                      height: context.xIsKeyBoardOpen
                          ? 4
                          : R.sizes.defaultBottomValue,
                    ),
                  ],
                );
              },
              failure: () => const RbioBodyError(),
            ) ??
            const SizedBox();
      },
    );
  }
  // #endregion

  // #region _buildScrollBody
  Widget _buildScrollBody(StripReminderAddEditResult result) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildInformationCard(result),

          //
          _buildGap(),

          //
          _buildCircleCount(result),

          //
          _buildGap(),

          //
          _buildIncrementDecrement(result),

          //
          _buildGap(),

          //
          _buildDescription(context),

          //
          _buildGap(),

          //
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              LocaleProvider.current.when_to_be_notified,
              style: context.xHeadline3,
            ),
          ),

          //
          R.widgets.hSizer8,

          //
          _buildAlarmTextField(),

          //
          R.widgets.hSizer4,
        ],
      ),
    );
  }
  // #endregion

  // #region _buildButtons
  Widget _buildButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: RbioElevatedButton(
            backColor: context.xCardColor,
            textColor: context.xTextInverseColor,
            title: LocaleProvider.current.btn_cancel,
            onTap: () {
              Atom.historyBack();
            },
          ),
        ),

        //
        R.widgets.wSizer12,

        //
        Expanded(
          child: RbioElevatedButton(
            title: LocaleProvider.current.btn_create,
            onTap: () {
              context
                  .read<StripReminderAddEditCubitCubit>()
                  .saveData(int.parse(_alarmController.text.trim()));
            },
          ),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildInformationCard
  Widget _buildInformationCard(StripReminderAddEditResult result) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.xCardColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //
          SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset(
              R.image.warning,
            ),
          ),

          //
          R.widgets.wSizer8,

          //
          Expanded(
            child: Text(
              result.usedStripCount == 0
                  ? LocaleProvider.current.never_used_strip
                  : LocaleProvider.current.strips_used
                      .format([result.usedStripCount.toString()]),
              textAlign: TextAlign.left,
              style: context.xHeadline3,
            ),
          ),
        ],
      ),
    );
  }
  // #endregion

  // #region _buildCircleCount
  Widget _buildCircleCount(StripReminderAddEditResult result) {
    return Center(
      child: RbioCircleAvatar(
        radius: 90,
        backgroundColor: context.xPrimaryColor,
        child: RbioCircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              SizedBox(
                width: 70,
                child: Theme(
                  data: ThemeData(primaryColor: Colors.black),
                  child: TextFormField(
                    controller: _stripCountController,
                    maxLength: 3,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: context.xHeadline1.copyWith(
                      height: 1,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      if (value != '') {
                        context
                            .read<StripReminderAddEditCubitCubit>()
                            .changeTo(int.parse(value));
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      counterText: '',
                    ),
                    validator: (input) {
                      if (input?.isNotEmpty ?? false) {
                        return null;
                      } else {
                        return "";
                      }
                    },
                  ),
                ),
              ),

              //
              Text(
                LocaleProvider.current.strips.toLowerCase(),
                style: context.xHeadline3.copyWith(
                  height: 1,
                  fontSize: 35,
                  color: context.xTextInverseColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _buildIncrementDecrement
  Widget _buildIncrementDecrement(StripReminderAddEditResult result) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        const Spacer(flex: 10),

        //
        Expanded(
          flex: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //
              _buildCircleAction(
                onTap: () {
                  _modeOfStrip = StripMode.subtract;
                  showCounterDialog();
                },
                icon: R.image.minus,
              ),

              //
              _buildCircleAction(
                onTap: () {
                  _modeOfStrip = StripMode.add;
                  showCounterDialog();
                },
                icon: R.image.add,
              ),
            ],
          ),
        ),

        //
        const Spacer(flex: 10),
      ],
    );
  }
  // #endregion

  // #region _buildCircleAction
  Widget _buildCircleAction({
    required void Function()? onTap,
    required String icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.xPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          width: 40,
        ),
      ),
    );
  }
  // #endregion

  // #region _buildDescription
  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 0.0,
      ),
      child: Center(
        child: Text(
          LocaleProvider.current.strip_page_info_message,
          style: context.xHeadline4.copyWith(
            fontWeight: FontWeight.w100,
            color: context.xAppColors.textDisabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  // #endregion

  // #region _buildAlarmTextField
  Widget _buildAlarmTextField() {
    return RbioTextFormField(
      controller: _alarmController,
      keyboardType: TextInputType.number,
      obscureText: false,
      hintText: LocaleProvider.current.strip_number,
    );
  }
  // #endregion

  // #region showCounterDialog
  Future<void> showCounterDialog() async {
    final dialogResult = await Atom.show(
      _StripCounterDialog(
        title: _modeOfStrip.xGetTitle,
      ),
    );
    if (dialogResult != null) {
      if (dialogResult is String) {
        final newCount = int.parse(dialogResult);
        if (_modeOfStrip == StripMode.add) {
          context.read<StripReminderAddEditCubitCubit>().incrementBy(newCount);
        } else {
          context.read<StripReminderAddEditCubitCubit>().decrementBy(newCount);
        }
      }
    }
  }
  // #endregion

  Widget _buildGap() => R.widgets.hSizer24;
}
