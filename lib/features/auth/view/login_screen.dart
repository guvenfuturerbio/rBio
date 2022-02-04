import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../../core/core.dart';
import '../viewmodel/login_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userNameEditingController;
  late TextEditingController _passwordEditingController;
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _userNameEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _userNameEditingController.dispose();
    _passwordEditingController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenVm(context),
      child: Consumer<LoginScreenVm>(
        builder: (
          BuildContext context,
          LoginScreenVm value,
          Widget? child,
        ) {
          _userNameEditingController.text = value.userId;
          _userNameEditingController.selection =
              TextSelection.collapsed(offset: value.userId.length);
          _passwordEditingController.text = value.password;
          _passwordEditingController.selection =
              TextSelection.collapsed(offset: value.password.length);

          return _buildScreen(value);
        },
      ),
    );
  }

  Widget _buildScreen(LoginScreenVm value) {
    return KeyboardDismissOnTap(
      child: RbioScaffold(
        resizeToAvoidBottomInset: true,
        appbar: _buildAppBar(),
        body: _buildBody(value),
      ),
    );
  }

  RbioAppBarLogin _buildAppBar() {
    return RbioAppBarLogin(
      leading: const SizedBox(),
    );
  }

  Widget _buildBody(LoginScreenVm value) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          _usernameFocusNode,
          _passwordFocusNode,
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
            const RbioLocaleDropdown(),

            //
            _buildHeader(),

            //
            _buildEmail(value),

            //
            _buildPassword(value),

            //
            _buildRememberMe(value),

            //
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
              child: Column(
                children: [
                  //
                  _buildApplicationContest(value),

                  //
                  _buildKVKK(value),

                  //
                  _buildSignIn(value),
                ],
              ),
            ),

            //
            //   _buildSeperator(),

            //
            //    _buildSocialLogin(),

            //
            _buildVersion(),

            //
            SizedBox(height: Atom.safeBottom),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              LocaleProvider.current.login,
              style: context.xHeadline1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Text(
            LocaleProvider.current.login_page_text,
            style: context.xHeadline3,
          ),
        ],
      ),
    );
  }

  Widget _buildEmail(LoginScreenVm value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            LocaleProvider.current.sign_in_keys,
            style: context.xHeadline3,
          ),
        ),

        //
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: RbioTextFormField(
            obscureText: false,
            autocorrect: false,
            focusNode: _usernameFocusNode,
            controller: _userNameEditingController,
            textInputAction: TextInputAction.next,
            hintText: '', // LocaleProvider.of(context).email_or_identity,
            inputFormatters: <TextInputFormatter>[
              TabToNextFieldTextInputFormatter(
                context,
                _usernameFocusNode,
                _passwordFocusNode,
              ),
            ],
            onChanged: (valueText) {
              value.setUserIdText(valueText);
            },
            onFieldSubmitted: (term) {
              UtilityManager().fieldFocusChange(
                context,
                _usernameFocusNode,
                _passwordFocusNode,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPassword(LoginScreenVm value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5),
          child: Text(
            LocaleProvider.current.password,
            style: context.xHeadline3,
          ),
        ),

        //
        RbioTextFormField(
          autocorrect: false,
          enableSuggestions: false,
          focusNode: _passwordFocusNode,
          controller: _passwordEditingController,
          textInputAction: TextInputAction.done,
          obscureText: value.passwordVisibility ? false : true,
          hintText: '', // LocaleProvider.of(context).hint_input_password,
          suffixIcon: RbioVisibilitySuffixIcon(
            eyesOpen: value.passwordVisibility,
            onTap: () {
              value.togglePasswordVisibility();
            },
          ),
          inputFormatters: <TextInputFormatter>[
            TabToNextFieldTextInputFormatter(
              context,
              _passwordFocusNode,
              null,
            ),
          ],
          onChanged: (valueText) {
            value.setPasswordText(valueText);
          },
          onFieldSubmitted: (term) {
            UtilityManager().fieldFocusChange(
              context,
              _passwordFocusNode,
              null,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRememberMe(LoginScreenVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 35,
                height: 35,
                child: Checkbox(
                  value: value.rememberMeChecked,
                  onChanged: (newValue) {
                    value.toggleRememberMeChecked();
                  },
                  activeColor: getIt<ITheme>().mainColor,
                ),
              ),
              Expanded(
                child: Text(
                  LocaleProvider.current.btn_remember_me,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline5.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
              )
            ],
          ),
        ),

        //
        TextButton(
          child: Text(
            LocaleProvider.of(context).lbl_forgot_password,
            style: context.xHeadline5.copyWith(
              color: getIt<ITheme>().mainColor,
            ),
          ),
          onPressed: () {
            Atom.to(PagePaths.forgotPasswordStep1);
          },
        ),
      ],
    );
  }

  Widget _buildApplicationContest(LoginScreenVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 35,
            height: 35,
            child: Checkbox(
              value: value.clickedGeneralForm,
              onChanged: (newValue) {
                if (newValue != null) {
                  value.clickedGeneralForm = newValue;
                }
              },
              activeColor: getIt<ITheme>().mainColor,
            ),
          ),
        ),

        //
        Expanded(
          child: TextButton(
            onPressed: () => value.showApplicationContestForm(),
            child: Text(
              LocaleProvider.of(context).accept_application_consent_form,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKVKK(LoginScreenVm value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Container(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 35,
            height: 35,
            child: Checkbox(
              value: value.checkedKvkkForm,
              onChanged: (newValue) {
                if (newValue != null) {
                  value.checkedKvkkForm = newValue;
                }
              },
              activeColor: getIt<ITheme>().mainColor,
            ),
          ),
        ),

        //
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () => {value.showKvkkInfo()},
              child: Text(
                LocaleProvider.of(context).read_understood_kvkk,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline5.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignIn(LoginScreenVm value) {
    return kIsWeb
        ? SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  child:
                      value.versionCheckProgress == VersionCheckProgress.loading
                          ? Column(
                              children: <Widget>[
                                LoadingDialog(),
                                Text(
                                  LocaleProvider.of(context).check_for_updates,
                                ),
                              ],
                            )
                          : Utils.instance.button(
                              text: LocaleProvider.of(context).btn_sign_in,
                              onPressed: () {
                                value.login(
                                  _userNameEditingController.text,
                                  _passwordEditingController.text,
                                );
                              },
                            ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LocaleProvider.of(context).lbl_dont_have_account,
                      style: context.xHeadline3.copyWith(
                        color: getIt<ITheme>().textColorSecondary,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        LocaleProvider.of(context).btn_sign_up,
                        style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>().mainColor,
                        ),
                      ),
                      onTap: () {
                        context.vRouter.to(PagePaths.registerStep1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: value.versionCheckProgress ==
                          VersionCheckProgress.loading
                      ? Column(
                          children: <Widget>[
                            LoadingDialog(),
                            Text(
                              LocaleProvider.of(context).check_for_updates,
                            ),
                          ],
                        )
                      : value.versionCheckProgress ==
                                  VersionCheckProgress.done &&
                              value.needForceUpdate == false
                          ? Utils.instance.button(
                              text: LocaleProvider.of(context).btn_sign_in,
                              onPressed: () {
                                value.login(
                                  _userNameEditingController.text,
                                  _passwordEditingController.text,
                                );
                              },
                            )
                          : value.needForceUpdate == true &&
                                  value.versionCheckProgress !=
                                      VersionCheckProgress.error
                              ? Utils.instance.button(
                                  onPressed: () {
                                    value.startAppVersionOperation();
                                  },
                                  text: LocaleProvider.of(context).update_now,
                                )
                              : Utils.instance.button(
                                  text: LocaleProvider.of(context).try_again,
                                  onPressed: () {
                                    value.startAppVersionOperation();
                                  },
                                ),
                ),

                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        LocaleProvider.of(context).lbl_dont_have_account,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.xHeadline5.copyWith(
                          color: getIt<ITheme>().textColorSecondary,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        LocaleProvider.of(context).btn_sign_up,
                        style: context.xHeadline5.copyWith(
                          color: getIt<ITheme>().mainColor,
                        ),
                      ),
                      onTap: () {
                        context.vRouter.to(PagePaths.registerStep1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget _buildVersion() {
    return Center(
      child: Text(
        "v" + getIt<GuvenSettings>().version,
        textAlign: TextAlign.center,
        style: context.xCaption,
      ),
    );
  }
}
