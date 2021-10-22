import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'register_step3_vm.dart';

class RegisterStep3Screen extends StatefulWidget {
  UserRegistrationStep2Model userRegistrationStep2Model;
  bool isWithoutTCKN;

  RegisterStep3Screen({
    Key key,
    this.userRegistrationStep2Model,
    this.isWithoutTCKN,
  }) : super(key: key);

  @override
  _RegisterStep3ScreenState createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  final TextEditingController _smsController = new TextEditingController();
  final focus = FocusNode();

  LoadingDialog loadingDialog;

  @override
  Widget build(BuildContext context) {
    try {
      widget.isWithoutTCKN = Atom.queryParameters['isWithoutTCKN'] == 'true';
      widget.userRegistrationStep2Model = UserRegistrationStep2Model.fromJson(
          jsonDecode(Atom.queryParameters['userRegistrationStep2Model']));
    } catch (_) {
      return QueryParametersError();
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
        child: ChangeNotifierProvider<RegisterStep3ScreenVm>(
          create: (_) => RegisterStep3ScreenVm(context),
          child: Consumer<RegisterStep3ScreenVm>(
            builder: (
              BuildContext context,
              RegisterStep3ScreenVm vm,
              Widget child,
            ) =>
                Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: _buildAppBar(context),
              body: _buildBody(context, vm),
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
              LocaleProvider.of(context).sms_verification,
              style: new TextStyle(
                color: R.color.blue,
              ),
            ),
            SizedBox(height: 20),
            SvgPicture.asset(R.image.step_3_total_3),
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

  Container _buildBody(BuildContext context, RegisterStep3ScreenVm vm) {
    return Container(
      margin: EdgeInsets.all(30),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: <Widget>[
            //
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 40),
              child: TextFormField(
                controller: _smsController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                style: inputTextStyle(),
                decoration: inputImageDecoration(
                  hintText: LocaleProvider.of(context).sms_verification_code,
                  image: R.image.ic_email,
                ),
                focusNode: focus,
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(context, focus, null);
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: button(
                text: LocaleProvider.of(context).btn_done.toUpperCase(),
                onPressed: () {
                  // tcknsiz giriş için yeni model
                  UserRegistrationStep3Model userRegisterStep3Model =
                      UserRegistrationStep3Model();
                  UserRegistrationStep3Model userRegisterStep3 =
                      UserRegistrationStep3Model();

                  if (widget.isWithoutTCKN) {
                    userRegisterStep3Model.userRegistrationStep2 =
                        widget.userRegistrationStep2Model;
                    userRegisterStep3Model.sms = _smsController.text;
                  }

                  if (_smsController.text.length > 0) {
                    vm.registerStep3(
                      userRegisterStep3,
                      userRegisterStep3Model,
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
            ),
          ],
        ),
      ),
    );
  }
}
