import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as masked;

import '../../../../core/core.dart';
import '../../../../model/shared/user_account_info.dart';
import '../viewmodel/personal_information_vm.dart';

class PersonalInformationScreen extends StatefulWidget {
  PersonalInformationScreen({Key key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  UserAccount userAccount;

  TextEditingController _identityEditingController;
  TextEditingController _nameEditingController;
  TextEditingController _birthdayEditingController;
  TextEditingController _phoneNumberEditingController;
  TextEditingController _emailEditingController;

  FocusNode phoneNumberFocus;
  FocusNode emailFocus;

  @override
  void initState() {
    _identityEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
    _birthdayEditingController = TextEditingController();
    _phoneNumberEditingController =
        masked.MaskedTextController(mask: '(000) 000-0000');
    _emailEditingController = TextEditingController();

    phoneNumberFocus = FocusNode();
    emailFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _identityEditingController.dispose();
    _nameEditingController.dispose();
    _birthdayEditingController.dispose();
    _phoneNumberEditingController.dispose();
    _emailEditingController.dispose();

    phoneNumberFocus.dispose();
    emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      userAccount = getIt<UserNotifier>().getUserAccount();
    } catch (e) {
      return RbioRouteError();
    }

    _identityEditingController.text = userAccount.nationality.xIsTCNationality
        ? userAccount.identificationNumber
        : userAccount.passaportNumber;
    _nameEditingController.text = userAccount.name + " " + userAccount.surname;

    _birthdayEditingController.text = userAccount.patients.length > 0
        ? userAccount.patients.first.birthDate.replaceAll('.', '/')
        : "-";

    return ChangeNotifierProvider<PersonalInformationScreenVm>(
      create: (context) => PersonalInformationScreenVm(
        mContext: context,
        email: userAccount.electronicMail.contains("@mailyok.com")
            ? "-"
            : userAccount.electronicMail,
        phoneNumber: userAccount.phoneNumber,
      ),
      child: Consumer<PersonalInformationScreenVm>(
        builder: (
          BuildContext context,
          PersonalInformationScreenVm vm,
          Widget child,
        ) {
          _phoneNumberEditingController.text = vm.phoneNumber;
          _emailEditingController.text = vm.email;

          return KeyboardDismissOnTap(
            child: RbioLoadingOverlay(
              isLoading: vm.showLoadingOverlay,
              progressIndicator: RbioLoading(),
              opacity: 0,
              child: RbioScaffold(
                resizeToAvoidBottomInset: false,
                appbar: RbioAppBar(
                  title: RbioAppBar.textTitle(
                    context,
                    LocaleProvider.of(context).lbl_personal_information,
                  ),
                ),
                body: _builBody(context, vm),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _builBody(BuildContext context, PersonalInformationScreenVm vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //
          // Identity Number
          _buildTitle(
            userAccount.nationality.xIsTCNationality
                ? LocaleProvider.of(context).tc_identity_number
                : LocaleProvider.of(context).passport_number,
          ),
          _buildDisabledTextField(
            _identityEditingController,
          ),

          // Name
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).name,
          ),
          _buildDisabledTextField(
            _nameEditingController,
          ),

          // Birthday
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).birth_date,
          ),
          _buildDisabledTextField(
            _birthdayEditingController,
          ),

          // Phone Number
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).phone_number,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
                  focusNode: phoneNumberFocus,
                  controller: _phoneNumberEditingController,
                  keyboardType: TextInputType.phone,
                  border: RbioTextFormField.activeBorder(),
                  textInputAction: TextInputAction.done,
                  hintText: LocaleProvider.of(context).hint_input_password,
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      phoneNumberFocus,
                      emailFocus,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // E-mail
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).email_address,
          ),
          RbioTextFormField(
            focusNode: emailFocus,
            controller: _emailEditingController,
            border: RbioTextFormField.activeBorder(),
            textInputAction: TextInputAction.done,
            hintText: LocaleProvider.of(context).hint_input_password,
            inputFormatters: <TextInputFormatter>[
              TabToNextFieldTextInputFormatter(
                context,
                emailFocus,
                phoneNumberFocus,
              ),
            ],
          ),

          //
          _buildSubmitButton(vm),
        ],
      ),
    );
  }

  Widget _buildSpacer() => SizedBox(height: 8);

  Widget _buildTitle(String title) => Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          title,
          style: context.xHeadline4,
        ),
      );

  Widget _buildDisabledTextField(
    TextEditingController controller,
  ) =>
      AbsorbPointer(
        absorbing: true,
        child: RbioTextFormField(
          controller: controller,
        ),
      );

  Widget _buildSubmitButton(PersonalInformationScreenVm vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Expanded(
            flex: 3,
            child: RbioElevatedButton(
              title: LocaleProvider.current.update_information,
              onTap: () {
                vm.updateValues(
                  newPhoneNumber: _phoneNumberEditingController.text.trim(),
                  newEmail: _emailEditingController.text.trim(),
                );
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
