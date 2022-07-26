import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/rbio_error_text.dart';
import '../viewmodel/register_step2_vm.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({Key? key}) : super(key: key);

  @override
  _RegisterStep1ScreenState createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  CountryCode countryCode = CountryCode(dialCode: '+90');

  List genderList = ["E", "K"];

  late TextEditingController _nameEditingController;
  late TextEditingController _surnameEditingController;
  late TextEditingController _phoneNumberEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late FocusNode _nameFocusNode;
  late FocusNode _surnameFocusNode;
  late FocusNode _phoneNumberFocusNode;
  bool isGenderNull = false;
  bool isBirthDayNull = false;

  @override
  void initState() {
    _nameEditingController = TextEditingController();
    _surnameEditingController = TextEditingController();
    _phoneNumberEditingController = TextEditingController();

    _nameFocusNode = FocusNode();
    _surnameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _surnameEditingController.dispose();
    _phoneNumberEditingController.dispose();

    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFromIntro = Atom.url == PagePaths.registerStep1Intro;

    return ChangeNotifierProvider<RegisterStep2ScreenVm>(
      create: (_) => RegisterStep2ScreenVm(context),
      child: Consumer<RegisterStep2ScreenVm>(
        builder: (
          BuildContext context,
          RegisterStep2ScreenVm vm,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioScaffold(
              resizeToAvoidBottomInset: true,
              appbar: RbioAppBar(
                context: context,
                leading: isFromIntro ? const SizedBox() : null,
              ),
              body: _buildBody(vm),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(RegisterStep2ScreenVm vm) {
    return RbioKeyboardActions(
      focusList: [
        _nameFocusNode,
        _surnameFocusNode,
        _phoneNumberFocusNode,
      ],
      child: KeyboardAvoider(
        autoScroll: true,
        duration: const Duration(seconds: 1),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15.0, left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            LocaleProvider.current.btn_sign_up,
                            style: context.xHeadline1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: context.textScale * 30,
                            ),
                          ),
                        ),
                        Text(
                          LocaleProvider.current.lets_know_you_better,
                          style: context.xHeadline3,
                        ),
                      ],
                    ),
                  ),

                  //
                  Row(
                    children: [
                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, bottom: 5),
                              child: Text(
                                LocaleProvider.current.name,
                                style: context.xHeadline3,
                              ),
                            ),
                            RbioTextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value?.isNotEmpty ?? false) {
                                  return null;
                                } else {
                                  return LocaleProvider.current.validation;
                                }
                              },
                              focusNode: _nameFocusNode,
                              controller: _nameEditingController,
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              hintText: LocaleProvider.of(context).name,
                              onFieldSubmitted: (term) {
                                Utils.instance.fieldFocusChange(
                                  context,
                                  _nameFocusNode,
                                  _surnameFocusNode,
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      //
                      const SizedBox(
                        width: 5,
                      ),

                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                bottom: 5,
                                top: 15,
                              ),
                              child: Text(
                                LocaleProvider.current.surname,
                                style: context.xHeadline3,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: RbioTextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return LocaleProvider.current.validation;
                                  }
                                },
                                focusNode: _surnameFocusNode,
                                controller: _surnameEditingController,
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                hintText: LocaleProvider.of(context).surname,
                                onFieldSubmitted: (term) {
                                  Utils.instance.fieldFocusChange(
                                    context,
                                    _surnameFocusNode,
                                    null,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      bottom: 5,
                      top: 15,
                    ),
                    child: Text(
                      LocaleProvider.current.gender,
                      style: context.xHeadline3,
                    ),
                  ),

                  //
                  Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        addRadioButton(
                            0, LocaleProvider.current.gender_male, true),
                        addRadioButton(
                            1, LocaleProvider.current.gender_female, false),
                      ],
                    ),
                  ),
                ],
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      bottom: 5,
                      top: 15,
                    ),
                    child: Text(
                      LocaleProvider.of(context).birth_date,
                      style: context.xHeadline3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isBirthDayNull = false;
                        vm.selectDate(context);
                      });
                    },
                    child: isBirthDayNull
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: context.xCurrentTheme.white,
                                  border: Border.all(
                                    color:
                                        context.xMyCustomTheme.fuzzyWuzzyBrown,
                                  ),
                                  borderRadius: R.sizes.borderRadiusCircular,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (vm.selectedDate == null)
                                      Text('DD/MM/YYYY',
                                          style: context.xHeadline3.copyWith(
                                            color: context.xTextInverseColor
                                                .withOpacity(0.5),
                                          )),
                                    const Icon(Icons.calendar_today)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: RbioErrorText(
                                  title: LocaleProvider.current.validation,
                                ),
                              )
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              color: context.xCurrentTheme.white,
                              border: Border.all(
                                color: context.xMyCustomTheme.mercury,
                              ),
                              borderRadius: R.sizes.borderRadiusCircular,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                vm.selectedDate != null
                                    ? Text(
                                        DateFormat('dd MMMM yyyy')
                                            .format(vm.selectedDate!),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    : Text(
                                        'DD/MM/YYYY',
                                        style: context.xHeadline3.copyWith(
                                          color: context.xTextInverseColor
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                  ),
                ],
              ),

              //
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                      child: Text(
                        LocaleProvider.current.phone_number,
                        style: context.xHeadline3,
                      ),
                    ),

                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        RbioCountryCodePicker(
                          onChanged: (value) {
                            countryCode = value;
                          },
                        ),

                        //
                        const SizedBox(
                          width: 5,
                        ),

                        //
                        Expanded(
                          child: RbioTextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value?.isNotEmpty ?? false) {
                                return null;
                              } else {
                                return LocaleProvider.current.validation;
                              }
                            },
                            focusNode: _phoneNumberFocusNode,
                            controller: _phoneNumberEditingController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            hintText: LocaleProvider.of(context).phone_number,
                            inputFormatters: <TextInputFormatter>[
                              TabToNextFieldTextInputFormatter(
                                context,
                                _phoneNumberFocusNode,
                                null,
                              ),
                              R.regExp.filterText4,
                            ],
                            onFieldSubmitted: (term) {
                              Utils.instance.fieldFocusChange(
                                context,
                                _phoneNumberFocusNode,
                                null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                  left: 50,
                  right: 50,
                ),
                child: RbioElevatedButton(
                  infinityWidth: true,
                  title: LocaleProvider.of(context).btn_next.toUpperCase(),
                  onTap: () {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        !isBirthDayNull &&
                        !isGenderNull) {
                      Atom.to(
                        PagePaths.registerStep2,
                        queryParameters: {
                          'registerName': _nameEditingController.text,
                          'registerSurname': _surnameEditingController.text,
                          'registerGender': gender.toString(),
                          'registerDateOfBirth': vm.selectedDate.toString(),
                          'registerPhoneNumber':
                              _phoneNumberEditingController.text,
                          'registerCountryCode':
                              Uri.encodeFull(countryCode.dialCode.toString()),
                        },
                      );
                    } else {
                      if (gender == null) {
                        setState(() {
                          isGenderNull = true;
                        });
                      }
                      if (vm.selectedDate == null) {
                        setState(() {
                          isBirthDayNull = true;
                        });
                      }

                      getIt<IAppConfig>()
                          .platform
                          .adjustManager
                          ?.trackEvent(UnsuccessfulRegisterStep1Event());
                      getIt<FirebaseAnalyticsManager>().logEvent(
                        KayitOlAdim1Hata(
                          "Register1 User TC",
                          22.toString(),
                        ),
                      );
                      // vm.showInfoDialog(
                      //   LocaleProvider.of(context).warning,
                      //   LocaleProvider.of(context).fill_all_field,
                      // );
                    }
                  },
                ),
              ),

              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    LocaleProvider.of(context).lbl_have_account,
                    style: context.xHeadline3.copyWith(
                      color: context.xTextInverseColor,
                    ),
                  ),

                  //
                  InkWell(
                    child: Text(
                      LocaleProvider.of(context).btn_sign_in,
                      style: context.xHeadline3.copyWith(
                        color: context.xPrimaryColor,
                      ),
                    ),
                    onTap: () {
                      context.vRouter.to(PagePaths.login);
                    },
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSeperator() {
    return Row(
      children: [
        //
        Expanded(
          child: Container(
            height: 1,
            color: context.xTextInverseColor.withOpacity(0.4),
          ),
        ),

        //
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or",
            style: context.xHeadline3.copyWith(
              color: context.xTextInverseColor.withOpacity(0.4),
            ),
          ),
        ),

        //
        Expanded(
          child: Container(
            height: 1,
            color: context.xTextInverseColor.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //
        SvgPicture.asset(
          R.image.facebook,
          width: 50,
        ),

        //
        SvgPicture.asset(
          R.image.apple,
          width: 50,
        ),

        //
        SvgPicture.asset(
          R.image.google,
          width: 50,
        ),
      ],
    );
  }

  String? gender;

  Widget addRadioButton(int btnValue, String title, bool showBorder) {
    return isGenderNull
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: context.xMyCustomTheme.fuzzyWuzzyBrown,
                    ),
                    borderRadius: R.sizes.borderRadiusCircular,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //
                      Radio<String>(
                        activeColor: Theme.of(context).primaryColor,
                        value: genderList[btnValue],
                        groupValue: gender,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              gender = value;
                              isGenderNull = false;
                            });
                          }
                        },
                      ),

                      //
                      Text(
                        title,
                        style: context.xHeadline3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: showBorder
                        ? RbioErrorText(
                            title: LocaleProvider.current.validation,
                          )
                        : const Text(''))
              ],
            ),
          )
        : Expanded(
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //
                  Radio<String>(
                      activeColor: Theme.of(context).primaryColor,
                      value: genderList[btnValue],
                      groupValue: gender,
                      onChanged: (value) {
                        if (!isGenderNull) {
                          if (value != null) {
                            setState(() {
                              gender = value;
                              isGenderNull = false;
                            });
                          }
                        }
                      }),

                  //
                  Text(
                    title,
                    style: context.xHeadline3,
                  ),
                ],
              ),
            ),
          );
  }
}
