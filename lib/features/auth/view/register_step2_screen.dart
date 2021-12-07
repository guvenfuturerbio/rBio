import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../auth.dart';
import '../../../core/core.dart';
import '../../../model/model.dart';
import '../viewmodel/register_step2_vm.dart';

class RegisterStep2Screen extends StatefulWidget {
  String registerName;
  String registerSurname;
  String registerGender;
  String registerDateOfBirth;
  String registerPhoneNumber;

  RegisterStep2Screen(
      {Key key,
      this.registerName,
      this.registerSurname,
      this.registerDateOfBirth,
      this.registerGender,
      this.registerPhoneNumber})
      : super(key: key);

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  List genderList = [
    "E",
    "K",
  ];

  final passwordFNode = FocusNode();
  final passwordAgainFNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  Country country;
  final focus = FocusNode();
  final TextEditingController _tcIdentity = new TextEditingController();
  final TextEditingController _tcEmail = new TextEditingController();

  bool checkedValueForFn = false;
  bool checkedValueForTc = true;

  // Turkish Citizen Tab
  final tcFNode = FocusNode();
  final tcNameNode = FocusNode();
  final tcLNameNode = FocusNode();
  final phoneFNode = FocusNode();
  final emailFNode = FocusNode();
  final birthdayNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    try {
      widget.registerName = Atom.queryParameters['registerName'];
      widget.registerSurname = Atom.queryParameters['registerSurname'];
      widget.registerPhoneNumber = Atom.queryParameters['registerPhoneNumber'];
      widget.registerGender = Atom.queryParameters['registerGender'];
      widget.registerDateOfBirth = Atom.queryParameters['registerDateOfBirth'];
    } catch (_) {
      return RbioRouteError();
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ChangeNotifierProvider<RegisterStep2ScreenVm>(
        create: (_) => RegisterStep2ScreenVm(context),
        child: Consumer<RegisterStep2ScreenVm>(
          builder: (
            BuildContext context,
            RegisterStep2ScreenVm vm,
            Widget child,
          ) =>
              RbioScaffold(
            resizeToAvoidBottomInset: true,
            appbar: RbioAppBarLogin(
                title: Image.asset(
              R.image.oneDoseHealthPng,
              height: 50,
            )),
            body: _buildBody(vm),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(RegisterStep2ScreenVm vm) {
    return KeyboardAvoider(
      autoScroll: true,
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
                  focusNode: tcFNode,
                  controller: _tcIdentity,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintText: vm.isTcCitizen
                      ? LocaleProvider.of(context).tc_identity_number
                      : LocaleProvider.of(context).passport_number,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      tcFNode,
                      phoneFNode,
                    ),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                  ],
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                      context,
                      tcFNode,
                      phoneFNode,
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
                  focusNode: emailFNode,
                  controller: _tcEmail,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  hintText: LocaleProvider.of(context).email_address,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      emailFNode,
                      null,
                    ),
                  ],
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                      context,
                      tcFNode,
                      birthdayNode,
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
                  focusNode: passwordFNode,
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  hintText: LocaleProvider.of(context).hint_input_password,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      passwordFNode,
                      passwordAgainFNode,
                    ),
                  ],
                  onChanged: (value) {
                    vm.passwordFetcher(value);
                  },
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                      context,
                      passwordFNode,
                      passwordAgainFNode,
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
                  focusNode: passwordAgainFNode,
                  controller: _passwordAgainController,
                  textInputAction: TextInputAction.done,
                  hintText: LocaleProvider.of(context).password_again,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      passwordAgainFNode,
                      null,
                    ),
                  ],
                  onChanged: (value) {
                    vm.passwordAgainFetcher(value);
                  },
                  onFieldSubmitted: (term) {
                    UtilityManager().fieldFocusChange(
                      context,
                      passwordAgainFNode,
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
                    LocaleProvider.of(context).accept_application_consent_form,
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

                  userRegisterStep1.firstName = widget.registerName;
                  userRegisterStep1.lastName = widget.registerSurname;
                  //TODO : Düzenlenecek
                  userRegisterStep1.nationalityId = vm.isTcCitizen ? 213 : 38;
                  userRegisterStep1.identityNumber = _tcIdentity.text;
                  userRegisterStep1.gender = widget.registerGender;
                  userRegisterStep1.gsm = widget.registerPhoneNumber;
                  userRegisterStep1.birthDate = widget.registerDateOfBirth;
                  userRegisterStep1.email = _tcEmail.text;
                  //-------------------------------------
                  UserRegistrationStep1Model userRegisterStep1Model =
                      UserRegistrationStep1Model();
                  userRegisterStep1Model.name = widget.registerName;
                  userRegisterStep1Model.surname = widget.registerSurname;
                  userRegisterStep1Model.identificationNumber =
                      _tcIdentity.text;
                  userRegisterStep1Model.userNationality =
                      vm.isTcCitizen ? 'TC' : 'D';
                  userRegisterStep1Model.phoneNumber =
                      widget.registerPhoneNumber;
                  userRegisterStep1Model.electronicMail = _tcEmail.text;

                  if (_tcIdentity.text.length > 0 && _tcEmail.text.length > 0) {
                    vm.registerStep1(userRegisterStep1, userRegisterStep1Model);
                  } else if ((_tcIdentity.text == null ||
                          _tcIdentity.text.length == 0) &&
                      _tcEmail.text.length > 0) {
                    vm.registerStep1(userRegisterStep1, userRegisterStep1Model);
                  } else {
                    vm.showGradientDialog(
                        context,
                        LocaleProvider.of(context).warning,
                        LocaleProvider.of(context).fill_all_field);
                  }
                } else {
                  vm.showGradientDialog(
                      context,
                      LocaleProvider.of(context).warning,
                      LocaleProvider.of(context).check_personal_data);
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
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: getIt<ITheme>().textColorSecondary.withOpacity(0.4),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
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
          ),

          //
          Row(
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
          ),
        ],
      ),
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
