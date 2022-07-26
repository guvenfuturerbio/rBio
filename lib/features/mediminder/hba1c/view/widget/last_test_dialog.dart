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
    super.initState();

    _valueEditingController = TextEditingController();
    _valueFocusNode = FocusNode();
    _valueEditingController.text = widget.initValue.replaceAll(".", ",");
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
                  style: context.xCurrentTheme.dialogTheme.title(context),
                ),
              ),

              //
              R.widgets.hSizer40,

              Center(
                child: Text(
                  getIt<UserFacade>().getNameAndSurname(),
                  style: context.xCurrentTheme.dialogTheme.description(context),
                ),
              ),

              //
              R.widgets.hSizer8,

              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: RbioTextFormField(
                  focusNode: _valueFocusNode,
                  backColor: context.xDialogTheme.backgroundColor,
                  controller: _valueEditingController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    R.regExp.filterText,
                  ],
                ),
              ),

              //
              R.widgets.hSizer40,

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
                        context,
                        title: LocaleProvider.current.btn_cancel,
                        onPressed: () {
                          Atom.dismiss(false);
                        },
                      ),
                    ),

                    //
                    R.widgets.wSizer8,

                    //
                    Expanded(
                      child: RbioSmallDialogButton.main(
                        context: context,
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
                R.widgets.hSizer12,
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
}
