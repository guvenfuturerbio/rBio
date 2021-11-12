import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'register_step2_vm.dart';

class RegisterStep2Screen extends StatefulWidget {
  UserRegistrationStep1Model registerStep1Model;
  bool isWithoutTCKN;

  RegisterStep2Screen({
    Key key,
    this.registerStep1Model,
    this.isWithoutTCKN,
  }) : super(key: key);

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final passwordFNode = FocusNode();
  final passwordAgainFNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  LoadingDialog loadingDialog;

  @override
  Widget build(BuildContext context) {
    try {
      widget.registerStep1Model = UserRegistrationStep1Model.fromJson(
          jsonDecode(Atom.queryParameters['registerStep1Model']));
      widget.isWithoutTCKN = Atom.queryParameters['isWithoutTCKN'] == 'true';
    } catch (_) {
      return RbioError();
    }

    return DefaultTabController(
      length: 2,
      child: GestureDetector(
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
                Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: _buildAppBar(context),
              body: _buildBody(vm, context),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150.0),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              LocaleProvider.of(context).create_password,
              style: new TextStyle(
                color: R.color.blue,
              ),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(R.image.step_2_total_3),
          ],
        ),
        leading: IconButton(
          icon: SvgPicture.asset(R.image.back_arrow_red),
          onPressed: () {
            Atom.historyBack();
          },
        ),
      ),
    );
  }

  Container _buildBody(RegisterStep2ScreenVm vm, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                obscureText: true,
                onChanged: (value) {
                  vm.checkPasswordCapability(value);
                },
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).hint_input_password,
                  image: R.image.ic_password,
                ),
                focusNode: passwordFNode,
                inputFormatters: <TextInputFormatter>[
                  new TabToNextFieldTextInputFormatter(
                      context, passwordFNode, passwordAgainFNode)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                      context, passwordFNode, passwordAgainFNode);
                },
              ),
              margin: EdgeInsets.only(bottom: 20, top: 40),
            ),

            //
            Container(
              child: TextFormField(
                controller: _passwordAgainController,
                textInputAction: TextInputAction.done,
                obscureText: true,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).password_again,
                  image: R.image.ic_password,
                ),
                focusNode: passwordAgainFNode,
                inputFormatters: <TextInputFormatter>[
                  new TabToNextFieldTextInputFormatter(
                      context, passwordAgainFNode, null)
                ],
                onFieldSubmitted: (term) {
                  UtilityManager()
                      .fieldFocusChange(context, passwordAgainFNode, null);
                },
              ),
              margin: EdgeInsets.only(bottom: 20),
            ),

            //
            Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Checkbox(
                    value: vm.checkNumeric,
                    onChanged: (value) {},
                    activeColor: R.color.blue, //// <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_digit,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: R.color.black,
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
                    value: vm.checkUpperCase,
                    onChanged: (value) {},
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_uppercase,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: R.color.black,
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
                    value: vm.checkLowerCase,
                    onChanged: (value) {},
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_lowercase,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: R.color.black,
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
                    value: vm.checkSpecial,
                    onChanged: (value) {},
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).must_contain_special,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: R.color.black,
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
                    value: vm.checkLength,
                    onChanged: (value) {},
                    activeColor: R.color.blue, //  <-- leading Checkbox
                  ),
                ),
                Text(
                  LocaleProvider.of(context).password_must_8_char,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: R.color.black,
                  ),
                ),
              ],
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: button(
                text: LocaleProvider.of(context).btn_next.toUpperCase(),
                onPressed: () {
                  UserRegistrationStep2Model userRegisterStep2 =
                      UserRegistrationStep2Model();
                  userRegisterStep2.userRegistrationStep1 =
                      widget.registerStep1Model;
                  userRegisterStep2.password = _passwordController.text;
                  userRegisterStep2.repassword = _passwordAgainController.text;

                  // Burada old modele dönüştürülmeyecek ikinci bir model oluşturuyoruz.
                  UserRegistrationStep2Model userRegisterStep2Model =
                      UserRegistrationStep2Model();
                  userRegisterStep2Model.userRegistrationStep1 =
                      widget.registerStep1Model;
                  userRegisterStep2Model.password = _passwordController.text;
                  userRegisterStep2Model.repassword =
                      _passwordAgainController.text;

                  if (_passwordController.text.length > 0 &&
                      _passwordAgainController.text.length > 0) {
                    vm.registerStep2(
                      userRegisterStep2,
                      userRegisterStep2Model,
                      widget.isWithoutTCKN,
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
            )
          ],
        ),
      ),
    );
  }
}
