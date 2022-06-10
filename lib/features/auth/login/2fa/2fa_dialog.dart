// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '2fa_dialog_vm.dart';

class TwoFaDialog extends StatefulWidget {
  final int userId;

  const TwoFaDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<TwoFaDialog> createState() => _TwoFaDialogState();
}

class _TwoFaDialogState extends State<TwoFaDialog> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TwoFaVm>(
      create: (context) => TwoFaVm(context),
      child: Consumer<TwoFaVm>(
        builder: (context, vm, child) {
          return RbioBaseDialog(
            child: SingleChildScrollView(
              child: RbioKeyboardActions(
                isDialog: true,
                focusList: [
                  _focusNode,
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    R.sizes.hSizer8,

                    //
                    Center(
                      child: Text(
                        LocaleProvider.of(context).sms_verification_code,
                        style: getIt<IAppConfig>()
                            .theme
                            .dialogTheme
                            .title(context),
                      ),
                    ),

                    R.sizes.hSizer32,

                    //

                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: RbioTextFormField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        hintText: LocaleProvider.of(context).verification_code,
                      ),
                    ),

                    //

                    if (!vm.resendButtonEnabled) ...[
                      R.sizes.hSizer40,
                      Center(
                        child: RbioSmallDialogButton.green(
                          title: LocaleProvider.current.save,
                          onPressed: () async {
                            await vm.verifyCode(
                              _textEditingController.text.trim(),
                              widget.userId,
                            );
                          },
                        ),
                      ),
                    ],

                    if (vm.resendButtonEnabled) ...[
                      R.sizes.hSizer24,
                      Center(
                        child: RbioSmallDialogButton.white(
                          title: LocaleProvider.current.resend,
                          onPressed: () async {
                            await vm.resendCode();
                          },
                        ),
                      ),
                      R.sizes.hSizer8,
                      Center(
                          child: RbioSmallDialogButton.green(
                        title: LocaleProvider.current.save,
                        onPressed: () async {
                          await vm.verifyCode(
                            _textEditingController.text.trim(),
                            widget.userId,
                          );
                        },
                      )),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
