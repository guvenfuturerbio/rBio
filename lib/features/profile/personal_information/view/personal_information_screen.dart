import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/shared/user_account_info.dart';
import '../viewmodel/personal_information_vm.dart';

class PersonalInformationScreen extends StatefulWidget {
  UserAccount userAccount;

  PersonalInformationScreen({Key key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  TextEditingController identityController;
  TextEditingController nameController;
  TextEditingController birthdayController;
  TextEditingController phoneNumberController;
  TextEditingController emailController;

  FocusNode phoneNumberFocus;
  FocusNode emailFocus;

  @override
  void initState() {
    identityController = TextEditingController();
    nameController = TextEditingController();
    birthdayController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();

    phoneNumberFocus = FocusNode();
    emailFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    identityController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();

    phoneNumberFocus.dispose();
    emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.userAccount = getIt<UserNotifier>().getUserAccount();
    } catch (e) {
      return RbioRouteError();
    }

    identityController.text = widget.userAccount.nationality.xIsTCNationality
        ? widget.userAccount.identificationNumber
        : widget.userAccount.passaportNumber;
    nameController.text =
        widget.userAccount.name + " " + widget.userAccount.surname;

    birthdayController.text = widget.userAccount.patients.length > 0
        ? widget.userAccount.patients.first.birthDate.replaceAll('.', '/')
        : "-";

    return ChangeNotifierProvider<PersonalInformationScreenVm>(
      create: (context) => PersonalInformationScreenVm(
        mContext: context,
        email: widget.userAccount.electronicMail.contains("@mailyok.com")
            ? "-"
            : widget.userAccount.electronicMail,
        phoneNumber: widget.userAccount.phoneNumber,
      ),
      child: Consumer<PersonalInformationScreenVm>(
        builder: (
          BuildContext context,
          PersonalInformationScreenVm vm,
          Widget child,
        ) {
          phoneNumberController.text = vm.phoneNumber;
          emailController.text = vm.email;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //
        _buildCard(context, vm),

        //
        _buildSubmitButton(vm),
      ],
    );
  }

  Widget _buildCard(BuildContext context, PersonalInformationScreenVm vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Identity Number
          _buildTitle(
            widget.userAccount.nationality.xIsTCNationality
                ? LocaleProvider.of(context).tc_identity_number
                : LocaleProvider.of(context).passport_number,
          ),
          _buildDisabledTextField(
            identityController,
          ),

          // Name
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).name,
          ),
          _buildDisabledTextField(
            nameController,
          ),

          // Birthday
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).birth_date,
          ),
          _buildDisabledTextField(
            birthdayController,
          ),

          // Phone Number
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).phone_number,
          ),
          RbioTextFormField(
            focusNode: phoneNumberFocus,
            controller: phoneNumberController,
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

          // E-mail
          _buildSpacer(),
          _buildTitle(
            LocaleProvider.of(context).email_address,
          ),
          RbioTextFormField(
            focusNode: emailFocus,
            controller: emailController,
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
                  newPhoneNumber: phoneNumberController.text.trim(),
                  newEmail: emailController.text.trim(),
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
