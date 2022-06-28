import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class ForgotPasswordStep2Screen extends StatefulWidget {
  const ForgotPasswordStep2Screen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordStep2ScreenState createState() =>
      _ForgotPasswordStep2ScreenState();
}

class _ForgotPasswordStep2ScreenState extends State<ForgotPasswordStep2Screen> {
  late String identityNumber;

  late TextEditingController _temporaryController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordAgainController;

  late FocusNode _temporaryFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordAgainFocusNode;

  @override
  void initState() {
    _temporaryFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();

    _temporaryController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();

    listenForCode();
    super.initState();
  }

  @override
  void dispose() {
    _temporaryFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordAgainFocusNode.dispose();

    _temporaryController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();

    super.dispose();
  }

  listenForCode() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      await SmsAutoFill().listenForCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      identityNumber = Atom.queryParameters['identityNumber']!;
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return ChangeNotifierProvider<ForgotPasswordStep2ScreenVm>(
      create: (context) => ForgotPasswordStep2ScreenVm(context),
      child: Consumer<ForgotPasswordStep2ScreenVm>(
        builder: (
          BuildContext context,
          ForgotPasswordStep2ScreenVm value,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioScaffold(
              resizeToAvoidBottomInset: true,
              appbar: RbioAppBar(),
              body: _buildBody(value),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForgotPasswordStep2ScreenVm value) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: KeyboardAvoider(
        autoScroll: true,
        child: RbioKeyboardActions(
          focusList: [
            _temporaryFocusNode,
            _passwordFocusNode,
            _passwordAgainFocusNode,
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 40),
                child: RbioTextFormField(
                  isForSms: true,
                  focusNode: _temporaryFocusNode,
                  controller: _temporaryController,
                  textInputAction: TextInputAction.next,
                  obscureText: value.passwordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).temporary_pass,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  onChanged: (val) {
                    _temporaryController.text = val;
                  },
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: RbioTextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: value.passwordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).new_password,
                  onChanged: (text) {
                    value.checkPasswordCapability(text);
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: RbioTextFormField(
                  focusNode: _passwordAgainFocusNode,
                  controller: _passwordAgainController,
                  textInputAction: TextInputAction.done,
                  obscureText: value.passwordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).new_password_again,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
              ),

              //
              _buildRow(
                value.checkNumeric,
                LocaleProvider.of(context).must_contain_digit,
              ),

              //
              _buildRow(
                value.checkUpperCase,
                LocaleProvider.of(context).must_contain_uppercase,
              ),

              //
              _buildRow(
                value.checkLowerCase,
                LocaleProvider.of(context).must_contain_lowercase,
              ),

              //
              _buildRow(
                value.checkSpecial,
                LocaleProvider.of(context).must_contain_special,
              ),

              //
              _buildRow(
                value.checkLength,
                LocaleProvider.of(context).password_must_8_char,
              ),

              //
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: RbioElevatedButton(
                    title: LocaleProvider.of(context).btn_done.toUpperCase(),
                    onTap: () {
                      if (_passwordController.text.trim() !=
                          _passwordAgainController.text.trim()) {
                        Utils.instance.showSnackbar(
                          context,
                          LocaleProvider.current.passwords_not_match,
                        );
                        return;
                      }

                      ChangePasswordModel changePasswordModel =
                          ChangePasswordModel();
                      changePasswordModel.identificationNumber = identityNumber;
                      changePasswordModel.newPasswordConfirmation =
                          _passwordAgainController.text;
                      changePasswordModel.newPassword =
                          _passwordController.text;
                      changePasswordModel.oldPassword =
                          _temporaryController.text;

                      if (_temporaryController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _passwordAgainController.text.isNotEmpty) {
                        value.forgotPassStep2(changePasswordModel);
                      } else {
                        value.showInfoDialog(
                          LocaleProvider.of(context).warning,
                          LocaleProvider.of(context).fill_all_field,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    bool checkboxValue,
    String text,
  ) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                color: getIt<IAppConfig>().theme.textColorSecondary,
              ),
            ),
          ),

          //
          Checkbox(
            value: checkboxValue,
            onChanged: (value) {},
            activeColor: getIt<IAppConfig>().theme.mainColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );

    if (checkboxValue) {
      return child;
    } else {
      return IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: 0.3,
          child: child,
        ),
      );
    }
  }
}
