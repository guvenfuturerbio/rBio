part of '../hba1c_reminder_add_edit_screen.dart';

class _LastTestDialog extends StatefulWidget {
  final String initValue;

  const _LastTestDialog({
    Key? key,
    this.initValue = '',
  }) : super(key: key);

  @override
  State<_LastTestDialog> createState() => _LastTestDialogState();
}

class _LastTestDialogState extends State<_LastTestDialog> {
  late TextEditingController _valueEditingController;
  late FocusNode _valueFocusNode;

  @override
  void initState() {
    _valueEditingController = TextEditingController();
    _valueFocusNode = FocusNode();
    _valueEditingController.text = widget.initValue.replaceAll(".", ",");

    super.initState();
  }

  @override
  void dispose() {
    _valueEditingController.dispose();
    _valueFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: SafeArea(
        child: Container(
          width: Atom.width > 350 ? 350 : Atom.width,
          decoration: BoxDecoration(
            color: getIt<ITheme>().cardBackgroundColor,
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: RbioKeyboardActions(
              isDialog: true,
              focusList: [
                _valueFocusNode,
              ],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  R.sizes.hSizer8,

                  //
                  Text(
                    LocaleProvider.current.test_result,
                    style: context.xHeadline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //
                  R.sizes.hSizer8,

                  //
                  RbioTextFormField(
                    focusNode: _valueFocusNode,
                    backColor: getIt<ITheme>().grayColor,
                    controller: _valueEditingController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                  ),

                  //
                  R.sizes.hSizer16,

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
                        R.sizes.wSizer8,

                        //
                        Expanded(
                          child: _buildConfirmButton(infinityWidth: false),
                        ),
                      ],
                    ),
                  ] else ...[
                    _buildCancelButton(infinityWidth: true),
                    R.sizes.hSizer12,
                    _buildConfirmButton(infinityWidth: true),
                  ],

                  //
                  R.sizes.hSizer4,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RbioElevatedButton _buildConfirmButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      title: LocaleProvider.current.btn_confirm,
      onTap: () {
        final inputValue = _valueEditingController.text.trim();
        if (inputValue.isNotEmpty) {
          Atom.dismiss(inputValue.replaceAll(",", "."));
        }
      },
      showElevation: false,
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }

  RbioElevatedButton _buildCancelButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      backColor: getIt<ITheme>().grayColor,
      textColor: getIt<ITheme>().textColorSecondary,
      title: LocaleProvider.current.btn_cancel,
      onTap: () {
        Atom.dismiss();
      },
      showElevation: false,
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }
}
