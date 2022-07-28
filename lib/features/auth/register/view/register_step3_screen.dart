import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Utils.instance
          .showSuccessSnackbar(context, LocaleProvider.current.code_sent);
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      isWithoutTCKN = Atom.queryParameters['isWithoutTCKN'] == 'true';
      userRegistrationStep2Model = UserRegistrationStep2Model.fromJson(
          jsonDecode(Atom.queryParameters['userRegistrationStep2Model']!));
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
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
                appbar: RbioAppBar(
                  context: context,
                ),
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
        duration: const Duration(seconds: 1),
        child: Form(
          key: vm.formKey,
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
                  autovalidateMode: vm.autovalidateMode,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    } else {
                      return LocaleProvider.current.validation;
                    }
                  },
                  controller: _smsController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  hintText: LocaleProvider.of(context).sms_verification_code,
                  focusNode: focus,
                  onFieldSubmitted: (term) {
                    Utils.instance.fieldFocusChange(context, focus, null);
                  },
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Utils.instance.button(
                    context: context,
                    text: LocaleProvider.of(context).btn_done.toUpperCase(),
                    onPressed: () {
                      if (vm.formKey?.currentState?.validate() ?? false) {
                        UserRegistrationStep3Model userRegisterStep3 =
                            UserRegistrationStep3Model();
                        userRegisterStep3.userRegistrationStep2 =
                            userRegistrationStep2Model;
                        userRegisterStep3.sms = _smsController.text;
                        vm.registerStep3(
                          userRegisterStep3,
                          isWithoutTCKN,
                        );
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
