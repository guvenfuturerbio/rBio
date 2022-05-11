import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../auth.dart';
import '../../../../core/core.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({Key? key}) : super(key: key);

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  // #region vRouter Params
  late String registerName;
  late String registerSurname;
  late String registerGender;
  late String registerDateOfBirth;
  late String registerPhoneNumber;
  late String registerCountryCode;
  // #endregion

  List genderList = ["E", "K"];

  late TextEditingController _identityEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _passwordAgainEditingController;

  late FocusNode _identityFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordAgainFocusNode;

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
      registerName = Atom.queryParameters['registerName']!;
      registerSurname = Atom.queryParameters['registerSurname']!;
      registerPhoneNumber = Atom.queryParameters['registerPhoneNumber']!;
      registerGender = Atom.queryParameters['registerGender']!;
      registerDateOfBirth = Atom.queryParameters['registerDateOfBirth']!;
      registerCountryCode =
          Uri.decodeFull(Atom.queryParameters['registerCountryCode']!);
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<RegisterStep2ScreenVm>(
      create: (_) => RegisterStep2ScreenVm(context),
      child: Consumer<RegisterStep2ScreenVm>(builder: (
        BuildContext context,
        RegisterStep2ScreenVm vm,
        Widget? child,
      ) {
        return KeyboardDismissOnTap(
          child: RbioScaffold(
            resizeToAvoidBottomInset: true,
            appbar: RbioAppBar(),
            body: _buildBody(vm),
          ),
        );
      }),
    );
  }

  Widget _buildBody(RegisterStep2ScreenVm vm) {
    return RbioKeyboardActions(
      focusList: [
        _identityFocusNode,
        _emailFocusNode,
        _passwordFocusNode,
        _passwordAgainFocusNode,
      ],
      child: KeyboardAvoider(
        autoScroll: true,
        duration: const Duration(seconds: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //
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
                      activeColor: getIt<IAppConfig>().theme.mainColor,
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
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: RbioTextFormField(
                    obscureText: false,
                    focusNode: _identityFocusNode,
                    controller: _identityEditingController,
                    textInputAction: TextInputAction.next,
                    keyboardType: vm.isTcCitizen
                        ? TextInputType.number
                        : TextInputType.text,
                    hintText: vm.isTcCitizen
                        ? LocaleProvider.of(context).tc_identity_number
                        : LocaleProvider.of(context).passport_number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value!.isNotEmpty &&
                          value.length < 5 &&
                          !vm.isTcCitizen)) {
                        return LocaleProvider.current.passport_validation;
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        _identityFocusNode,
                        _emailFocusNode,
                      ),
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
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    LocaleProvider.current.email,
                    style: context.xHeadline3,
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
                  margin: const EdgeInsets.only(bottom: 10),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value ?? '').isNotEmpty) {
                        if (!vm.passwordFetcher(value!)) {
                          return LocaleProvider.current.password_validation;
                        }
                      }

                      return null;
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
                  margin: const EdgeInsets.only(bottom: 10),
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
                    activeColor: getIt<IAppConfig>().theme.mainColor,
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
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              child: Utils.instance.button(
                text: LocaleProvider.of(context).btn_next.toUpperCase(),
                onPressed: () {
                  AddStep1Model userRegisterStep1 = AddStep1Model();
                  userRegisterStep1.id = 0;
                  userRegisterStep1.firstName = registerName;
                  userRegisterStep1.lastName = registerSurname;
                  userRegisterStep1.nationalityId = vm.isTcCitizen ? 213 : 38;
                  userRegisterStep1.identityNumber =
                      _identityEditingController.text;

                  //
                  userRegisterStep1.gender = registerGender;
                  userRegisterStep1.gsm = registerPhoneNumber;
                  userRegisterStep1.birthDate = registerDateOfBirth;
                  userRegisterStep1.email = _emailEditingController.text;
                  userRegisterStep1.countryCode =
                      registerCountryCode.substring(1);
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
                  userRegisterStep1Model.countryCode =
                      registerCountryCode.substring(1);

                  if (_identityEditingController.text.isNotEmpty &&
                      _emailEditingController.text.isNotEmpty) {
                    vm.registerStep1(
                      userRegisterStep1,
                      userRegisterStep1Model,
                    );
                  } else if ((_identityEditingController.text.isEmpty) &&
                      _emailEditingController.text.isNotEmpty) {
                    vm.registerStep1(
                      userRegisterStep1,
                      userRegisterStep1Model,
                    );
                  } else {
                    vm.showInfoDialog(
                      LocaleProvider.of(context).warning,
                      LocaleProvider.of(context).fill_all_field,
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
                    color: getIt<IAppConfig>().theme.textColorSecondary,
                  ),
                ),
                InkWell(
                  child: Text(
                    LocaleProvider.of(context).btn_sign_in,
                    style: context.xHeadline3.copyWith(
                      color: getIt<IAppConfig>().theme.mainColor,
                    ),
                  ),
                  onTap: () {
                    context.vRouter.to(PagePaths.login);
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
            color:
                getIt<IAppConfig>().theme.textColorSecondary.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Text(
            "or",
            style: context.xHeadline3.copyWith(
              color:
                  getIt<IAppConfig>().theme.textColorSecondary.withOpacity(0.4),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color:
                getIt<IAppConfig>().theme.textColorSecondary.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  String? gender;
  Widget addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: genderList[btnValue],
          groupValue: gender,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                gender = value;
              });
            }
          },
        ),
        Text(title, style: context.xHeadline3)
      ],
    );
  }
}
