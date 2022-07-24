part of '../reminder_detail_screen.dart';

class _AddMedicineDialog extends StatefulWidget {
  const _AddMedicineDialog({Key? key}) : super(key: key);

  @override
  __AddMedicineDialogState createState() => __AddMedicineDialogState();
}

class __AddMedicineDialogState extends State<_AddMedicineDialog> {
  late TextEditingController _valueEditingController;
  late FocusNode _valueFocusNode;

  @override
  void initState() {
    _valueEditingController = TextEditingController();
    _valueFocusNode = FocusNode();

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
            color: context.xCardColor,
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
                  R.widgets.hSizer8,

                  //
                  Text(
                    LocaleProvider.current.add_medicine,
                    style: context.xHeadline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //
                  R.widgets.hSizer8,

                  //
                  RbioTextFormField(
                    focusNode: _valueFocusNode,
                    backColor: context.xMyCustomTheme.gallery,
                    controller: _valueEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
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

  Widget _buildConfirmButton({
    required bool infinityWidth,
  }) {
    return RbioElevatedButton(
      title: LocaleProvider.current.save,
      onTap: () {
        final inputValue = _valueEditingController.text.trim();
        if (inputValue.isNotEmpty) {
          Atom.dismiss(int.parse(inputValue));
        }
      },
      fontWeight: FontWeight.bold,
      infinityWidth: infinityWidth,
    );
  }

  Widget _buildCancelButton({
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
