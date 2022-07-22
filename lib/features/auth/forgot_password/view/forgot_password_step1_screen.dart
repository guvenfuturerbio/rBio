import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../core/core.dart';
import '../../auth.dart';
import '../cubit/forgot_password_step1_cubit/forgot_password_step1_cubit.dart';

class ForgotPasswordStep1Screen extends StatelessWidget {
  const ForgotPasswordStep1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordStep1Cubit(getIt()),
      child: const ForgotPasswordStep1View(),
    );
  }
}

class ForgotPasswordStep1View extends StatefulWidget {
  const ForgotPasswordStep1View({Key? key}) : super(key: key);

  @override
  _ForgotPasswordStep1ViewState createState() =>
      _ForgotPasswordStep1ViewState();
}

class _ForgotPasswordStep1ViewState extends State<ForgotPasswordStep1View> {
  late TextEditingController _tcIdentityEditingController;
  late TextEditingController _tcPhoneNumberEditingController;
  late FocusNode tcNoFNode;
  late FocusNode phoneNumberFNode;

  @override
  void initState() {
    _tcIdentityEditingController = TextEditingController();
    _tcPhoneNumberEditingController = TextEditingController();
    tcNoFNode = FocusNode();
    phoneNumberFNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _tcIdentityEditingController.dispose();
    _tcPhoneNumberEditingController.dispose();
    tcNoFNode.dispose();
    phoneNumberFNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordStep1Cubit, ForgotPasswordStep1State>(
      listener: (context, state) {
        if (state.isError) {
          if (state.dialogMessage != null) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return RbioMessageDialog(
                  description: state.dialogMessage!,
                  buttonTitle: LocaleProvider.current.Ok,
                  isAtom: false,
                );
              },
            );
          }
        }
      },
      builder: (context, state) {
        return KeyboardDismissOnTap(
          child: RbioStackedScaffold(
            isLoading: state.isLoading,
            resizeToAvoidBottomInset: true,
            appbar: RbioAppBar(
              context: context,
            ),
            body: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ForgotPasswordStep1State state,
  ) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          tcNoFNode,
          phoneNumberFNode,
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            R.widgets.stackedTopPadding(context),

            //
            const SizedBox(
              height: 20,
            ),

            //
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 25, top: 10),
              child: Text(
                LocaleProvider.current.recover_your_password,
                style: context.xHeadline1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: context.textScale * 30,
                ),
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 30, top: 5, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 10),
                    child: Text(
                      LocaleProvider.current.tc_identity_number,
                      style: context.xHeadline3,
                    ),
                  ),
                  RbioTextFormField(
                    focusNode: tcNoFNode,
                    controller: _tcIdentityEditingController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    hintText: LocaleProvider.of(context).tc_identity_number,
                    inputFormatters: <TextInputFormatter>[
                      TabToNextFieldTextInputFormatter(
                        context,
                        tcNoFNode,
                        phoneNumberFNode,
                      ),
                    ],
                    onFieldSubmitted: (term) {
                      Utils.instance.fieldFocusChange(
                        context,
                        tcNoFNode,
                        phoneNumberFNode,
                      );
                    },
                  ),
                ],
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 30, top: 5, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 10),
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
                        onChanged: (countryCode) {
                          LoggerUtils.instance.i(countryCode);
                        },
                      ),

                      //
                      const SizedBox(
                        width: 5,
                      ),

                      //
                      Expanded(
                        child: RbioTextFormField(
                          focusNode: phoneNumberFNode,
                          controller: _tcPhoneNumberEditingController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          hintText: LocaleProvider.of(context).phone_number,
                          inputFormatters: <TextInputFormatter>[
                            TabToNextFieldTextInputFormatter(
                              context,
                              phoneNumberFNode,
                              null,
                            ),
                          ],
                          onFieldSubmitted: (term) {
                            Utils.instance.fieldFocusChange(
                              context,
                              phoneNumberFNode,
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
            Padding(
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 30,
                        left: 30,
                      ),
                      child: RbioElevatedButton(
                        infinityWidth: true,
                        title: LocaleProvider.of(context)
                            .btn_send_code
                            .toUpperCase(),
                        onTap: () {
                          UserRegistrationStep1Model userRegisterStep1 =
                              UserRegistrationStep1Model();
                          userRegisterStep1.userNationality = "TC";
                          userRegisterStep1.phoneNumber =
                              _tcPhoneNumberEditingController.text;
                          userRegisterStep1.identificationNumber =
                              _tcIdentityEditingController.text;

                          if (_tcPhoneNumberEditingController.text.isNotEmpty &&
                              _tcIdentityEditingController.text.isNotEmpty) {
                            context
                                .read<ForgotPasswordStep1Cubit>()
                                .forgotPassStep1(userRegisterStep1);
                          } else {
                            context.read<ForgotPasswordStep1Cubit>().showDialog(
                                  LocaleProvider.of(context).fill_all_field,
                                );
                          }
                        },
                      ),
                    ),
                  ),

                  //
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //
                        Text(
                          LocaleProvider.of(context).lbl_dont_have_account,
                          style: context.xHeadline3.copyWith(
                            color: context.xAppColors.grey,
                          ),
                        ),

                        //
                        InkWell(
                          child: Text(
                            LocaleProvider.of(context).btn_sign_up,
                            style: context.xHeadline3.copyWith(
                              color: context.xPrimaryColor,
                            ),
                          ),
                          onTap: () {
                            Atom.to(PagePaths.registerStep1);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
