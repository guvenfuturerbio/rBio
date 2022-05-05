import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/shared/user_account_info.dart';
import '../viewmodel/personal_information_vm.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late UserAccount userAccount;

  late TextEditingController _identityEditingController;
  late TextEditingController _nameEditingController;
  late TextEditingController _birthdayEditingController;
  late TextEditingController _phoneNumberEditingController;
  late TextEditingController _emailEditingController;
  late String countryCode;
  late FocusNode _phoneNumberFocus;
  late FocusNode _emailFocus;

  @override
  void initState() {
    _identityEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
    _birthdayEditingController = TextEditingController();
    _phoneNumberEditingController = TextEditingController();
    _emailEditingController = TextEditingController();

    _phoneNumberFocus = FocusNode();
    _emailFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _identityEditingController.dispose();
    _nameEditingController.dispose();
    _birthdayEditingController.dispose();
    _phoneNumberEditingController.dispose();
    _emailEditingController.dispose();

    _phoneNumberFocus.dispose();
    _emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      userAccount = getIt<UserNotifier>().getUserAccount();
    } catch (e) {
      return const RbioRouteError();
    }

    final xIsTCNationality = userAccount.nationality?.xIsTCNationality;
    if (xIsTCNationality != null) {
      _identityEditingController.text = xIsTCNationality
          ? userAccount.identificationNumber ?? ''
          : userAccount.passaportNumber ?? '';
    }
    countryCode = userAccount.countryCode ?? '+90';
    final userName = userAccount.name ?? '';
    final userSurname = userAccount.surname ?? '';
    _nameEditingController.text = userName + " " + userSurname;

    final patientsLength = userAccount.patients?.length ?? 0;
    if (patientsLength > 0) {
      final patientsFirstBirthDate =
          userAccount.patients?.first.birthDate?.replaceAll('.', '/') ?? '';
      _birthdayEditingController.text =
          patientsLength > 0 ? patientsFirstBirthDate : "-";
    }

    _phoneNumberEditingController.text = userAccount.phoneNumber ?? '';

    final isEMail =
        !(userAccount.electronicMail?.contains("@mailyok.com") ?? false);
    if (isEMail) {
      _emailEditingController.text = userAccount.electronicMail ?? '';
    }

    return ChangeNotifierProvider<PersonalInformationScreenVm>(
      create: (context) => PersonalInformationScreenVm(
        mContext: context,
        email: isEMail ? "-" : (userAccount.electronicMail ?? ''),
        phoneNumber: userAccount.phoneNumber ?? '',
      ),
      child: Consumer<PersonalInformationScreenVm>(
        builder: (
          BuildContext context,
          PersonalInformationScreenVm vm,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioStackedScaffold(
              isLoading: vm.showLoadingOverlay,
              resizeToAvoidBottomInset: true,
              appbar: _buildAppBar(context),
              body: _builBody(context, vm),
            ),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).lbl_personal_information,
      ),
    );
  }

  Widget _builBody(BuildContext context, PersonalInformationScreenVm vm) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: RbioKeyboardActions(
              focusList: [
                _phoneNumberFocus,
                _emailFocus,
              ],
              child: KeyboardAvoider(
                autoScroll: true,
                duration: const Duration(seconds: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //
                    R.sizes.stackedTopPadding(context),
                    R.sizes.hSizer16,

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
                            radius: R.sizes.iconSize * 1.3,
                            backgroundColor:
                                getIt<IAppConfig>().theme.cardBackgroundColor,
                          ),

                          //
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                getIt<IAppConfig>().theme.textColorPassive,
                              ),
                            ),
                            onPressed: () {
                              _openCupertinoModalPopup(vm);
                            },
                            child: Text(
                              LocaleProvider.current.change,
                              style: context.xHeadline5.copyWith(
                                color: getIt<IAppConfig>().theme.mainColor,
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
                      (userAccount.nationality?.xIsTCNationality ?? false)
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
                        RbioCountryCodePicker(
                          initialSelection: userAccount.countryCode == null
                              ? '+90'
                              : userAccount.countryCode!.contains('+')
                                  ? userAccount.countryCode
                                  : '+' + userAccount.countryCode!,
                          onChanged: (code) {
                            countryCode = code.dialCode!;
                          },
                        ),

                        //
                        const SizedBox(
                          width: 5,
                        ),

                        //
                        Expanded(
                          child: RbioTextFormField(
                            focusNode: _phoneNumberFocus,
                            controller: _phoneNumberEditingController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            hintText: LocaleProvider.of(context).phone_number,
                            inputFormatters: <TextInputFormatter>[
                              TabToNextFieldTextInputFormatter(
                                context,
                                _phoneNumberFocus,
                                _emailFocus,
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
                      focusNode: _emailFocus,
                      controller: _emailEditingController,
                      textInputAction: TextInputAction.done,
                      hintText: LocaleProvider.of(context).email_address,
                      inputFormatters: <TextInputFormatter>[
                        TabToNextFieldTextInputFormatter(
                          context,
                          _emailFocus,
                          _phoneNumberFocus,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          //
          if (!isKeyboardVisible)
            Container(
              padding: const EdgeInsets.only(top: 8),
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
                        Atom.historyBack();
                      },
                      backColor: getIt<IAppConfig>().theme.cardBackgroundColor,
                      textColor: getIt<IAppConfig>().theme.textColorSecondary,
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
                          countryCode: countryCode,
                          newPhoneNumber:
                              _phoneNumberEditingController.text.trim(),
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
    });
  }

  Widget _buildSpacer() => const SizedBox(height: 16);

  Widget _buildTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 14),
        child: Text(
          title,
          style: context.xHeadline4.copyWith(
            fontWeight: FontWeight.bold,
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
          textColor: getIt<IAppConfig>().theme.textColorPassive,
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
