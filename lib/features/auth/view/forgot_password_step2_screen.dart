import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../auth.dart';
import '../viewmodel/forgot_password_step2_vm.dart';

class ForgotPasswordStep2Screen extends StatefulWidget {
  ForgotPasswordStep2Screen({Key key}) : super(key: key);

  @override
  _ForgotPasswordStep2ScreenState createState() =>
      _ForgotPasswordStep2ScreenState();
}

class _ForgotPasswordStep2ScreenState extends State<ForgotPasswordStep2Screen> {
  String identityNumber;

  TextEditingController _temporaryController;
  TextEditingController _passwordController;
  TextEditingController _passwordAgainController;

  FocusNode _temporaryFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _passwordAgainFocusNode;

  @override
  void initState() {
    _temporaryFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();

    _temporaryController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    try {
      identityNumber = Atom.queryParameters['identityNumber'];
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<ForgotPasswordStep2ScreenVm>(
      create: (context) => ForgotPasswordStep2ScreenVm(context),
      child: Consumer<ForgotPasswordStep2ScreenVm>(
        builder: (
          BuildContext context,
          ForgotPasswordStep2ScreenVm value,
          Widget child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioScaffold(
              resizeToAvoidBottomInset: true,
              appbar: RbioAppBarLogin(),
              body: _buildBody(value),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForgotPasswordStep2ScreenVm value) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
              //
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 40),
                child: RbioTextFormField(
                  focusNode: _temporaryFocusNode,
                  controller: _temporaryController,
                  textInputAction: TextInputAction.next,
                  obscureText: value.passwordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).temporary_pass,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                ),
              ),

              //
              Container(
                margin: EdgeInsets.only(bottom: 20),
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
                margin: EdgeInsets.only(bottom: 20),
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
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: RbioElevatedButton(
                    title: LocaleProvider.of(context).btn_done.toUpperCase(),
                    onTap: () {
                      if (_passwordController.text.trim() !=
                          _passwordAgainController.text.trim()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              LocaleProvider.current.passwords_not_match,
                            ),
                          ),
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

                      if (_temporaryController.text.length > 0 &&
                          _passwordController.text.length > 0 &&
                          _passwordAgainController.text.length > 0) {
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          child: Checkbox(
            value: checkboxValue,
            onChanged: (value) {},
            activeColor: getIt<ITheme>().mainColor,
            side: BorderSide(
              color: Colors.grey,
            ),
            shape: CircleBorder(), //// <-- leading Checkbox
          ),
        ),

        //
        Expanded(
          child: Text(
            text,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColorSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
