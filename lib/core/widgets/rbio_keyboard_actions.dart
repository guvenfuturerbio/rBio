import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../core.dart';

class RbioKeyboardActions extends StatelessWidget {
  final Widget child;
  final List<FocusNode> focusList;
  final bool isDialog;

  const RbioKeyboardActions({
    Key? key,
    required this.child,
    required this.focusList,
    this.isDialog = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      autoScroll: false,
      tapOutsideBehavior: TapOutsideBehavior.none,
      isDialog: isDialog,
      config: KeyboardActionsConfig(
        child: _buildMyDoneWidget(context),
        keyboardSeparatorColor: getIt<IAppConfig>().theme.mainColor,
        actions:
            focusList.map((e) => KeyboardActionsItem(focusNode: e)).toList(),
      ),
      child: child,
    );
  }

  Widget _buildMyDoneWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () {
            Utils.instance.hideKeyboard(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 12.0,
            ),
            child: Text(
              LocaleProvider.current.close_lbl,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
