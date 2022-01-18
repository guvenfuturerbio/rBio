import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as masked;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

    _phoneNumberEditingController.text = userAccount.phoneNumber;
    _emailEditingController.text =
        userAccount.electronicMail.contains("@mailyok.com")
            ? "-"
            : userAccount.electronicMail;

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
          return KeyboardDismissOnTap(
            child: RbioLoadingOverlay(
              isLoading: vm.showLoadingOverlay,
              progressIndicator: RbioLoading.progressIndicator(),
              opacity: 0,
              child: RbioScaffold(
                resizeToAvoidBottomInset: true,
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
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          CircleAvatar(
                            backgroundImage: vm.getProfileImage,
                            radius: R.sizes.iconSize * 1.5,
                            backgroundColor:
                                getIt<ITheme>().cardBackgroundColor,
                          ),

                          //
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                getIt<ITheme>().textColorPassive,
                              ),
                            ),
                            onPressed: () {
                              _openCupertinoModalPopup(vm);
                            },
                            child: Text(
                              LocaleProvider.current.change,
                              style: context.xHeadline5.copyWith(
                                color: getIt<ITheme>().mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSpacer(),

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
                            textInputAction: TextInputAction.done,
                            hintText:
                                LocaleProvider.of(context).hint_input_password,
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
              ),
            ),
          ),
        ),

        //
        Container(
          padding: EdgeInsets.only(
            top: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.current.btn_cancel,
                  onTap: () {
                    vm.resetValues();
                  },
                  backColor: getIt<ITheme>().cardBackgroundColor,
                  textColor: getIt<ITheme>().textColorSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //
              R.sizes.wSizer12,

              //
              Expanded(
                child: RbioElevatedButton(
                  title: LocaleProvider.current.update,
                  onTap: () {
                    vm.updateValues(
                      newPhoneNumber: _phoneNumberEditingController.text.trim(),
                      newEmail: _emailEditingController.text.trim(),
                    );
                  },
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        //
        R.sizes.defaultBottomPadding,
      ],
    );
  }

  Widget _buildSpacer() => SizedBox(height: 16);

  Widget _buildTitle(String title) => Padding(
        padding: EdgeInsets.only(bottom: 8, left: 14),
        child: Text(
          title,
          style: context.xHeadline4.copyWith(
            color: getIt<ITheme>().textColorPassive,
          ),
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

  void _openCupertinoModalPopup(PersonalInformationScreenVm vm) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: Atom.isWeb
              ? <Widget>[
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleProvider.current.delete,
                      style: context.xHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await vm.deletePhoto(context);
                    },
                  ),
                ]
              : <Widget>[
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleProvider.current.delete,
                      style: context.xHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await vm.deletePhoto(context);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleProvider.current.gallery,
                      style: context.xHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await vm.getPhotoFromSource(
                        context,
                        ImageSource.gallery,
                      );
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text(
                      LocaleProvider.current.camera,
                      style: context.xHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await vm.getPhotoFromSource(
                        context,
                        ImageSource.camera,
                      );
                    },
                  ),
                ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              LocaleProvider.current.btn_cancel,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
