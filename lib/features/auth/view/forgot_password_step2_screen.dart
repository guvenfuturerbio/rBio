import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../auth.dart';
import '../viewmodel/forgot_password_step2_vm.dart';

class ForgotPasswordStep2Screen extends StatefulWidget {
  String identityNumber;

  ForgotPasswordStep2Screen({
    Key key,
    this.identityNumber,
  }) : super(key: key);

  @override
  _ForgotPasswordStep2ScreenState createState() =>
      _ForgotPasswordStep2ScreenState();
}

class _ForgotPasswordStep2ScreenState extends State<ForgotPasswordStep2Screen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.identityNumber = Atom.queryParameters['identityNumber'];
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<ForgotPasswordStep2ScreenVm>(
      create: (context) => ForgotPasswordStep2ScreenVm(context: context),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 40),
              child: RbioTextFormField(
                controller: value.temporaryController,
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
                controller: value.passwordController,
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
                controller: value.passwordAgainController,
                textInputAction: TextInputAction.done,
                obscureText: value.passwordVisibility ? false : true,
                hintText: LocaleProvider.of(context).new_password_again,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.checkNumeric,
                    onChanged: (value) {},
                    activeColor:
                        getIt<ITheme>().mainColor, //// <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_digit,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.checkUpperCase,
                    onChanged: (value) {},
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_uppercase,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.checkLowerCase,
                    onChanged: (value) {},
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_lowercase,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.checkSpecial,
                    onChanged: (value) {},
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_special,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: value.checkLength,
                    onChanged: (value) {},
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),
                Text(
                  LocaleProvider.of(context).password_must_8_char,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              ],
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: RbioElevatedButton(
                title: LocaleProvider.of(context).btn_done.toUpperCase(),
                onTap: () {
                  ChangePasswordModel changePasswordModel =
                      ChangePasswordModel();
                  changePasswordModel.identificationNumber =
                      widget.identityNumber;
                  changePasswordModel.newPasswordConfirmation =
                      value.passwordAgainController.text;
                  changePasswordModel.newPassword =
                      value.passwordController.text;
                  changePasswordModel.oldPassword =
                      value.temporaryController.text;

                  if (value.temporaryController.text.length > 0 &&
                      value.passwordController.text.length > 0 &&
                      value.passwordAgainController.text.length > 0) {
                    value.forgotPassStep2(changePasswordModel);
                  } else {
                    value.showGradientDialog(
                      context,
                      LocaleProvider.of(context).warning,
                      LocaleProvider.of(context).fill_all_field,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
