import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../viewmodel/change_password_vm.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _passwordController;
  TextEditingController _passwordAgainController;
  TextEditingController _oldPasswordController;

  FocusNode _oldPasswordFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _passwordAgainFocusNode;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    _oldPasswordController = TextEditingController();

    _oldPasswordFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordAgainController.dispose();
    _oldPasswordController.dispose();

    _oldPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordAgainFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordScreenVm>(
      create: (context) => ChangePasswordScreenVm(context),
      child: DefaultTabController(
        length: 2,
        child: KeyboardDismissOnTap(
          child: _buildScreen(),
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return Consumer<ChangePasswordScreenVm>(
      builder: (
        BuildContext context,
        ChangePasswordScreenVm vm,
        Widget child,
      ) {
        return RbioStackedScaffold(
          resizeToAvoidBottomInset: true,
          isLoading: vm.showProgressOverlay,
          appbar: _buildAppBar(),
          body: _buildBody(vm),
        );
      },
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).change_password,
      ),
    );
  }

  Widget _buildBody(ChangePasswordScreenVm value) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          _oldPasswordFocusNode,
          _passwordFocusNode,
          _passwordAgainFocusNode,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            R.sizes.stackedTopPadding(context),

            //
            R.sizes.hSizer16,

            //
            Text(
              LocaleProvider.current.password_security,
              textAlign: TextAlign.center,
              style: context.xHeadline4.copyWith(
                color: getIt<ITheme>().mainColor,
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 20),
              child: RbioTextFormField(
                focusNode: _oldPasswordFocusNode,
                controller: _oldPasswordController,
                textInputAction: TextInputAction.next,
                obscureText: value.oldPasswordVisibility ? false : true,
                hintText: LocaleProvider.of(context).hint_input_old_password,
                prefixIcon: SvgPicture.asset(
                  R.image.ic_password_small,
                  fit: BoxFit.none,
                ),
                suffixIcon: RbioVisibilitySuffixIcon(
                  eyesOpen: value.oldPasswordVisibility,
                  onTap: () {
                    value.toggleOldPasswordVisibility();
                  },
                ),
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    _oldPasswordFocusNode,
                    _passwordFocusNode,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    _oldPasswordFocusNode,
                    _passwordFocusNode,
                  );
                },
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
                hintText: LocaleProvider.of(context).hint_input_password,
                prefixIcon: SvgPicture.asset(
                  R.image.ic_password_again,
                  fit: BoxFit.none,
                ),
                suffixIcon: RbioVisibilitySuffixIcon(
                  onTap: () {
                    value.togglePasswordVisibility();
                  },
                  eyesOpen: value.passwordVisibility,
                ),
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    _passwordFocusNode,
                    _passwordAgainFocusNode,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    _passwordFocusNode,
                    _passwordAgainFocusNode,
                  );
                },
                onChanged: (text) {
                  value.checkPasswordCapability(text);
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: RbioTextFormField(
                focusNode: _passwordAgainFocusNode,
                controller: _passwordAgainController,
                textInputAction: TextInputAction.done,
                obscureText: value.passwordAgainVisibility ? false : true,
                hintText: LocaleProvider.of(context).password_again,
                prefixIcon: SvgPicture.asset(
                  R.image.ic_password_again,
                  fit: BoxFit.none,
                ),
                suffixIcon: RbioVisibilitySuffixIcon(
                  onTap: () {
                    value.togglePasswordAgainVisibility();
                  },
                  eyesOpen: value.passwordAgainVisibility,
                ),
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    _passwordAgainFocusNode,
                    null,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    _passwordAgainFocusNode,
                    null,
                  );
                },
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
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: RbioElevatedButton(
                infinityWidth: true,
                title: LocaleProvider.of(context).btn_done.toUpperCase(),
                onTap: () {
                  value.changePassword(
                    oldPassword: _oldPasswordController.text.trim(),
                    password: _passwordController.text.trim(),
                    passwordAgain: _passwordAgainController.text.trim(),
                  );
                },
              ),
            ),

            //
            R.sizes.defaultBottomPadding,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    bool checkboxValue,
    String text,
  ) {
    final child = Padding(
      padding: EdgeInsets.symmetric(
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
                color: getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),

          //
          Checkbox(
            value: checkboxValue,
            onChanged: (value) {},
            activeColor: getIt<ITheme>().mainColor,
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
