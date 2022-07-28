part of '../strip_reminder_add_edit_screen.dart';

class _StripCounterDialog extends StatefulWidget {
  final String title;

  const _StripCounterDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  __StripCounterDialogState createState() => __StripCounterDialogState();
}

class __StripCounterDialogState extends State<_StripCounterDialog> {
  late TextEditingController _stripController;
  late FocusNode _stripFocusNode;

  @override
  void initState() {
    super.initState();
    _stripController = TextEditingController();
    _stripFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _stripController.dispose();
    _stripFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: SafeArea(
        child: Container(
          width: Atom.width > 350 ? 350 : Atom.width,
          decoration: BoxDecoration(
            color: context.xCardColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: RbioKeyboardActions(
              isDialog: true,
              focusList: [
                _stripFocusNode,
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //
                  R.widgets.hSizer8,

                  //
                  Text(
                    widget.title,
                    style: context.xHeadline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //
                  R.widgets.hSizer8,

                  //
                  RbioTextFormField(
                    focusNode: _stripFocusNode,
                    backColor: context.xMyCustomTheme.gallery,
                    controller: _stripController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      R.regExp.filterText3,
                    ],
                  ),

                  //
                  R.widgets.hSizer16,

                  //
                  if (context.xTextScaleType == TextScaleType.small) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        Expanded(
                          child: _buildCancelButton(infinityWidth: false),
                        ),

                        //
                        R.widgets.wSizer8,

                        //
                        Expanded(
                          child: _buildConfirmButton(infinityWidth: false),
                        ),
                      ],
                    ),
                  ] else ...[
                    _buildCancelButton(infinityWidth: true),
                    R.widgets.hSizer12,
                    _buildConfirmButton(infinityWidth: true),
                  ],

                  //
                  R.widgets.hSizer4,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // #region _buildConfirmButton
  RbioElevatedButton _buildConfirmButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      title: LocaleProvider.current.btn_confirm,
      onTap: () {
        final inputValue = _stripController.text.trim();
        if (inputValue.isNotEmpty) {
          Atom.dismiss(inputValue.replaceAll(",", "."));
        }
      },
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }
  // #endregion

  // #region _buildCancelButton
  RbioElevatedButton _buildCancelButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      backColor: context.xMyCustomTheme.gallery,
      textColor: context.xTextInverseColor,
      title: LocaleProvider.current.btn_cancel,
      onTap: () {
        Atom.dismiss();
      },
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }
  // #endregion
}
