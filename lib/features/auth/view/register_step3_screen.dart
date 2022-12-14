import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../auth.dart';
import '../viewmodel/register_step3_vm.dart';

class RegisterStep3Screen extends StatefulWidget {
  const RegisterStep3Screen({Key? key}) : super(key: key);

  @override
  _RegisterStep3ScreenState createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  late UserRegistrationStep2Model userRegistrationStep2Model;
  late bool isWithoutTCKN;

  final TextEditingController _smsController = TextEditingController();
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    try {
      isWithoutTCKN = Atom.queryParameters['isWithoutTCKN'] == 'true';
      userRegistrationStep2Model = UserRegistrationStep2Model.fromJson(
          jsonDecode(Atom.queryParameters['userRegistrationStep2Model']!));
    } catch (_) {
      return const RbioRouteError();
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
              Widget? child,
            ) {
              return RbioScaffold(
                resizeToAvoidBottomInset: true,
                appbar: RbioAppBar(),
                body: _buildBody(context, vm),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, RegisterStep3ScreenVm vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: KeyboardAvoider(
        autoScroll: true,
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
                      LocaleProvider.current.enter_the_code,
                      style: context.xHeadline1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    LocaleProvider.current.check_sms,
                    style: context.xHeadline3,
                  ),
                ],
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 20, top: 40),
              child: RbioTextFormField(
                controller: _smsController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                hintText: LocaleProvider.of(context).sms_verification_code,
                focusNode: focus,
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(context, focus, null);
                },
              ),
            ),

            //
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Utils.instance.button(
                text: LocaleProvider.of(context).btn_done.toUpperCase(),
                onPressed: () {
                  // tcknsiz giri?? i??in yeni model
                  UserRegistrationStep3Model userRegisterStep3Model =
                      UserRegistrationStep3Model();
                  UserRegistrationStep3Model userRegisterStep3 =
                      UserRegistrationStep3Model();

                  if (isWithoutTCKN) {
                    userRegisterStep3Model.userRegistrationStep2 =
                        userRegistrationStep2Model;
                    userRegisterStep3Model.sms = _smsController.text;
                  }

                  if (_smsController.text.isNotEmpty) {
                    vm.registerStep3(
                      userRegisterStep3,
                      userRegisterStep3Model,
                      isWithoutTCKN,
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
          ],
        ),
      ),
    );
  }
}
