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
          return GuvenAlert(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: SafeArea(
              child: Container(
                width: Atom.width > 350 ? 350 : Atom.width,
                decoration: BoxDecoration(
                  color: getIt<IAppConfig>().theme.scaffoldBackgroundColor,
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
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
                        Text(
                          LocaleProvider.of(context).sms_verification_code,
                          style: context.xHeadline1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        //
                        _buildGap(),

                        //
                        RbioTextFormField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          hintText:
                              LocaleProvider.of(context).sms_verification_code,
                        ),

                        //
                        _buildGap(),

                        //
                        RbioElevatedButton(
                          title: LocaleProvider.current.save,
                          onTap: () async {
                            await vm.verifyCode(
                              _textEditingController.text.trim(),
                              widget.userId,
                            );
                          },
                          fontWeight: FontWeight.bold,
                          infinityWidth: true,
                        ),

                        //
                        if (vm.resendButtonEnabled) ...[
                          R.sizes.hSizer8,
                          Center(
                            child: RbioWhiteButton(
                              infinityWidth: true,
                              title: LocaleProvider.of(context).resend,
                              onTap: () async {
                                await vm.resendCode();
                              },
                            ),
                          ),
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
        },
      ),
    );
  }

  Widget _buildGap() => R.sizes.hSizer16;
}
