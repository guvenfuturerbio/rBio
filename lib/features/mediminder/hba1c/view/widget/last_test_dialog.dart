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
    return RbioBaseDialog(
      child: SingleChildScrollView(
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
              Center(
                child: Text(
                  LocaleProvider.current.test_result,
                  style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                ),
              ),

              //
              R.sizes.hSizer40,

              Center(
                child: Text(
                  getIt<UserNotifier>().getCurrentUserNameAndSurname(),
                  style: getIt<IAppConfig>()
                      .theme
                      .dialogTheme
                      .description(context),
                ),
              ),

              R.sizes.hSizer8,

              //
              RbioTextFormField(
                contentPadding: const EdgeInsets.only(left: 140),
                focusNode: _valueFocusNode,
                backColor:
                    getIt<IAppConfig>().theme.dialogTheme.backgroundColor,
                controller: _valueEditingController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
              ),

              //
              R.sizes.hSizer40,

              //
              if (context.xTextScaleType == TextScaleType.small) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: RbioSmallDialogButton.red(
                        title: LocaleProvider.current.btn_cancel,
                        onPressed: () {
                          Atom.dismiss(false);
                        },
                      ),
                    ),

                    //
                    R.sizes.wSizer8,

                    //
                    Expanded(
                      child: RbioSmallDialogButton.green(
                        title: LocaleProvider.current.save,
                        onPressed: () {
                          final inputValue =
                              _valueEditingController.text.trim();
                          if (inputValue.isNotEmpty) {
                            Atom.dismiss(inputValue.replaceAll(",", "."));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ] else ...[
                _buildCancelButton(infinityWidth: true),
                R.sizes.hSizer12,
                _buildConfirmButton(infinityWidth: true),
              ],

              //
            ],
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
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }

  RbioElevatedButton _buildCancelButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      backColor: getIt<IAppConfig>().theme.grayColor,
      textColor: getIt<IAppConfig>().theme.textColorSecondary,
      title: LocaleProvider.current.btn_cancel,
      onTap: () {
        Atom.dismiss();
      },
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }
}
