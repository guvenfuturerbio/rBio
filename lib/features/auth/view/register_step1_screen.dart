import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import '../viewmodel/register_step2_vm.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({Key key}) : super(key: key);

  @override
  _RegisterStep1ScreenState createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  List genderList = ["E", "K"];
  Country country;

  TextEditingController _nameEditingController;
  TextEditingController _surnameEditingController;
  TextEditingController _phoneNumberEditingController;

  FocusNode _nameFocusNode;
  FocusNode _surnameFocusNode;
  FocusNode _phoneNumberFocusNode;

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
    return ChangeNotifierProvider<RegisterStep2ScreenVm>(
      create: (_) => RegisterStep2ScreenVm(context),
      child: Consumer<RegisterStep2ScreenVm>(
        builder: (
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
        },
      ),
    );
  }

  Widget _buildBody(RegisterStep2ScreenVm vm) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          _nameFocusNode,
          _surnameFocusNode,
          _phoneNumberFocusNode,
        ],
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
                            fontSize: context.TEXTSCALE * 30,
                          ),
                        ),
                      ),
                      Text(
                        "Let's know you better!",
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
                              "Name",
                              style: context.xHeadline3,
                            ),
                          ),
                          Container(
                            child: RbioTextFormField(
                              focusNode: _nameFocusNode,
                              controller: _nameEditingController,
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              hintText: LocaleProvider.of(context).name,
                              onFieldSubmitted: (term) {
                                UtilityManager().fieldFocusChange(
                                  context,
                                  _nameFocusNode,
                                  _surnameFocusNode,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    SizedBox(
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
                              "Surname",
                              style: context.xHeadline3,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: RbioTextFormField(
                              focusNode: _surnameFocusNode,
                              controller: _surnameEditingController,
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              hintText: LocaleProvider.of(context).surname,
                              onFieldSubmitted: (term) {
                                UtilityManager().fieldFocusChange(
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
                    "Gender",
                    style: context.xHeadline3,
                  ),
                ),

                //
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addRadioButton(0, 'Male'),
                      addRadioButton(1, 'Female'),
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
                    "Date of birth",
                    style: context.xHeadline3,
                  ),
                ),
                InkWell(
                  onTap: () => vm.selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: R.color.white,
                      border: Border.all(
                        color: R.color.dark_white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (vm.selectedDate == null)
                            ? Text('DD/MM/YYYY',
                                style: context.xHeadline3.copyWith(
                                    color: getIt<ITheme>()
                                        .textColorSecondary
                                        .withOpacity(0.5)))
                            : Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(vm.selectedDate),
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                        Icon(Icons.calendar_today)
                      ],
                    ),
                    margin: EdgeInsets.only(
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
                      RbioCountryCodePicker(),

                      //
                      SizedBox(
                        width: 5,
                      ),

                      //
                      Expanded(
                        child: RbioTextFormField(
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
                          ],
                          onFieldSubmitted: (term) {
                            UtilityManager().fieldFocusChange(
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
              margin: EdgeInsets.only(
                top: 5,
                bottom: 10,
                left: 50,
                right: 50,
              ),
              child: RbioElevatedButton(
                infinityWidth: true,
                title: LocaleProvider.of(context).btn_next.toUpperCase(),
                onTap: () {
                  if (_nameEditingController.text.length > 0 &&
                      _surnameEditingController.text.length > 0 &&
                      _phoneNumberEditingController.text.length > 0 &&
                      vm.selectedDate != null) {
                    Atom.to(
                      PagePaths.REGISTER_STEP_2,
                      queryParameters: {
                        'registerName': _nameEditingController.text,
                        'registerSurname': _surnameEditingController.text,
                        'registerGender': gender,
                        'registerDateOfBirth': vm.selectedDate.toString(),
                        'registerPhoneNumber':
                            _phoneNumberEditingController.text
                      },
                    );
                  } else {
                    vm.showGradientDialog(
                      context,
                      LocaleProvider.of(context).warning,
                      LocaleProvider.of(context).fill_all_field,
                    );
                  }
                },
              ),
            ),

            //
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
            //   buildSeperator(),

            SizedBox(
              height: 10,
            ),

            //
            //     buildSocialLogin(),
          ],
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

  String gender;

  Widget addRadioButton(int btnValue, String title) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
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
        ),
      ),
    );
  }
}
