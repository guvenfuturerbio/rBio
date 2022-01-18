import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../auth.dart';
import '../../../core/core.dart';
import '../viewmodel/register_step2_vm.dart';

class RegisterStep2Screen extends StatefulWidget {
  RegisterStep2Screen({Key key}) : super(key: key);

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  // #region vRouter Params
  String registerName;
  String registerSurname;
  String registerGender;
  String registerDateOfBirth;
  String registerPhoneNumber;
  // #endregion

  List genderList = ["E", "K"];

  TextEditingController _identityEditingController;
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;
  TextEditingController _passwordAgainEditingController;

  FocusNode _identityFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _passwordAgainFocusNode;

  bool checkedValueForFn = false;
  bool checkedValueForTc = true;

  @override
  void initState() {
    _identityEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _passwordAgainEditingController = TextEditingController();

    _identityFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _identityEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _passwordAgainEditingController.dispose();

    _identityFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordAgainFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      registerName = Atom.queryParameters['registerName'];
      registerSurname = Atom.queryParameters['registerSurname'];
      registerPhoneNumber = Atom.queryParameters['registerPhoneNumber'];
      registerGender = Atom.queryParameters['registerGender'];
      registerDateOfBirth = Atom.queryParameters['registerDateOfBirth'];
    } catch (_) {
      return RbioRouteError();
    }
    return ChangeNotifierProvider<RegisterStep2ScreenVm>(
      create: (_) => RegisterStep2ScreenVm(context),
      child: Consumer<RegisterStep2ScreenVm>(builder: (
        BuildContext context,
        RegisterStep2ScreenVm vm,
        Widget child,
      ) {
        return KeyboardDismissOnTap(
          child: RbioScaffold(
            resizeToAvoidBottomInset: true,
            appbar: RbioAppBarLogin(
              title: Image.asset(
                R.image.oneDoseHealthPng,
                height: 50,
              ),
            ),
            body: _buildBody(vm),
          ),
        );
      }),
    );
  }

  Widget _buildBody(RegisterStep2ScreenVm vm) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          _identityFocusNode,
          _emailFocusNode,
          _passwordFocusNode,
          _passwordAgainFocusNode,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      LocaleProvider.current.btn_sign_up,
                      style: context.xHeadline1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    LocaleProvider.current.sign_up_text,
                    style: context.xHeadline3,
                  ),
                ],
              ),
            ),

            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  children: [
                    Checkbox(
                      activeColor: getIt<ITheme>().mainColor,
                      value: vm.isTcCitizen,
                      onChanged: (val) {
                        vm.toggleCitizen();
                      },
                    ),
                    Text(
                      LocaleProvider.current.tr_citizen,
                      style: context.xHeadline3,
                    ),
                  ],
                ),

                //
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: RbioTextFormField(
                    obscureText: false,
                    focusNode: _identityFocusNode,
                    controller: _identityEditingController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    hintText: vm.isTcCitizen
                        ? LocaleProvider.of(context).tc_identity_number
                        : LocaleProvider.of(context).passport_number,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        _identityFocusNode,
                        _emailFocusNode,
                      ),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        _identityFocusNode,
                        _emailFocusNode,
                      );
                    },
                  ),
                ),
              ],
            ),

            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    LocaleProvider.current.email,
                    style: context.xHeadline3,
                  ),
                ),

                //
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: RbioTextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailEditingController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    hintText: LocaleProvider.of(context).email_address,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        _emailFocusNode,
                        null,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        _emailFocusNode,
                        null,
                      );
                    },
                  ),
                ),
              ],
            ),

            //
            Column(
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
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: RbioTextFormField(
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                    controller: _passwordEditingController,
                    textInputAction: TextInputAction.next,
                    hintText: LocaleProvider.of(context).hint_input_password,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        _passwordFocusNode,
                        _passwordAgainFocusNode,
                      ),
                    ],
                    onChanged: (value) {
                      vm.passwordFetcher(value);
                    },
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        _passwordFocusNode,
                        _passwordAgainFocusNode,
                      );
                    },
                  ),
                ),
              ],
            ),

            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    LocaleProvider.current.password_again,
                    style: context.xHeadline3,
                  ),
                ),

                //
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: RbioTextFormField(
                    obscureText: true,
                    focusNode: _passwordAgainFocusNode,
                    controller: _passwordAgainEditingController,
                    textInputAction: TextInputAction.done,
                    hintText: LocaleProvider.of(context).password_again,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        _passwordAgainFocusNode,
                        null,
                      ),
                    ],
                    onChanged: (value) {
                      vm.passwordAgainFetcher(value);
                    },
                    onFieldSubmitted: (term) {
                      UtilityManager().fieldFocusChange(
                        context,
                        _passwordAgainFocusNode,
                        null,
                      );
                    },
                  ),
                ),
              ],
            ),

            //
            Row(
              children: [
                //
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: vm.clickedGeneralForm,
                    onChanged: (newValue) {
                      vm.showApplicationContestForm();
                    },
                    activeColor: getIt<ITheme>().mainColor,
                  ),
                ),

                //
                Expanded(
                  child: InkWell(
                    onTap: () {
                      vm.showApplicationContestForm();
                    },
                    child: Text(
                      LocaleProvider.of(context)
                          .accept_application_consent_form,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.xHeadline4.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: Utils.instance.button(
                text: LocaleProvider.of(context).btn_next.toUpperCase(),
                onPressed: () {
                  if (checkedValueForTc) {
                    RegisterStep1PusulaModel userRegisterStep1 =
                        RegisterStep1PusulaModel();

                    userRegisterStep1.firstName = registerName;
                    userRegisterStep1.lastName = registerSurname;
                    //TODO : Düzenlenecek
                    userRegisterStep1.nationalityId = vm.isTcCitizen ? 213 : 38;
                    vm.isTcCitizen
                        ? userRegisterStep1.identityNumber =
                            _identityEditingController.text
                        : userRegisterStep1.passportNumber =
                            _identityEditingController.text;
                    //
                    userRegisterStep1.gender = registerGender;
                    userRegisterStep1.gsm = registerPhoneNumber;
                    userRegisterStep1.birthDate = registerDateOfBirth;
                    userRegisterStep1.email = _emailEditingController.text;
                    //-------------------------------------
                    UserRegistrationStep1Model userRegisterStep1Model =
                        UserRegistrationStep1Model();
                    userRegisterStep1Model.name = registerName;
                    userRegisterStep1Model.surname = registerSurname;
                    userRegisterStep1Model.identificationNumber =
                        _identityEditingController.text;
                    userRegisterStep1Model.userNationality =
                        vm.isTcCitizen ? 'TC' : 'D';
                    userRegisterStep1Model.phoneNumber = registerPhoneNumber;
                    userRegisterStep1Model.electronicMail =
                        _emailEditingController.text;

                    if (_identityEditingController.text.length > 0 &&
                        _emailEditingController.text.length > 0) {
                      vm.registerStep1(
                          userRegisterStep1, userRegisterStep1Model);
                    } else if ((_identityEditingController.text == null ||
                            _identityEditingController.text.length == 0) &&
                        _emailEditingController.text.length > 0) {
                      vm.registerStep1(
                          userRegisterStep1, userRegisterStep1Model);
                    } else {
                      vm.showInfoDialog(
                        LocaleProvider.of(context).warning,
                        LocaleProvider.of(context).fill_all_field,
                      );
                    }
                  } else {
                    vm.showInfoDialog(
                      LocaleProvider.of(context).warning,
                      LocaleProvider.of(context).check_personal_data,
                    );
                  }
                },
              ),
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  LocaleProvider.of(context).lbl_dont_have_account,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                  ),
                ),
                InkWell(
                  child: Text(
                    LocaleProvider.of(context).btn_sign_in,
                    style: context.xHeadline3.copyWith(
                      color: getIt<ITheme>().mainColor,
                    ),
                  ),
                  onTap: () {
                    context.vRouter.to(PagePaths.LOGIN);
                  },
                ),
              ],
            ),

            //
            //buildSeperator(),

            //
            //buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  Row buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          R.image.facebook,
          width: 50,
        ),
        SvgPicture.asset(
          R.image.apple,
          width: 50,
        ),
        SvgPicture.asset(
          R.image.google,
          width: 50,
        ),
      ],
    );
  }

  Row buildSeperator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Text(
            "or",
            style: context.xHeadline3.copyWith(
              color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  String gender;
  Widget addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: genderList[btnValue],
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              print(value);
              gender = value;
            });
          },
        ),
        Text(title, style: context.xHeadline3)
      ],
    );
  }
}
