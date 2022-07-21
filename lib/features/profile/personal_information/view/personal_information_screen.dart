// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:onedosehealth/features/profile/personal_information/cubit/personel_information_cubit.dart';

import '../../../../core/core.dart';
import '../../../../model/shared/user_account_info.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late UserAccount userAccount;

  /// Kullanici mail adresi boş ise, oturum açma esnasında Ana sayfa yerine
  /// kişisel bilgilerim sayfası açılır ve kullanıcıdan mail girmesi istenilir.
  bool isEmailRequired = false;

  @override
  Widget build(BuildContext context) {
    try {
      // Kullanici mail adresi boş ise, oturum açma esnasında Ana sayfa yerine
      // kişisel bilgilerim sayfası açılır ve kullanıcıdan mail girmesi istenilir.
      isEmailRequired =
          (Atom.queryParameters['emailRequired'] ?? false) == 'true';
      userAccount = getIt<UserFacade>().getUserAccount();
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }
    final isEMail =
        !(userAccount.electronicMail?.contains("@mailyok.com") ?? false);
    return BlocProvider(
      create: (context) => PersonelInformationCubit(
        repository: getIt(),
        userFacade: getIt(),
        sharedPreferencesManager: getIt(),
        sentryManager: getIt<IAppConfig>().platform.sentryManager,
        imageManager: getIt(),
        email: isEMail ? "-" : (userAccount.electronicMail ?? ''),
        phoneNumber: userAccount.phoneNumber ?? '',
      ),
      child: PersonalInformationView(
        userAccount: userAccount,
        isEmailRequired: isEmailRequired,
      ),
    );
  }
}

class PersonalInformationView extends StatefulWidget {
  PersonalInformationView({
    required this.userAccount,
    required this.isEmailRequired,
    Key? key,
  }) : super(key: key);

  UserAccount userAccount;
  final bool isEmailRequired;

  @override
  _PersonalInformationViewState createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  final AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController identityEditingController;
  late TextEditingController nameEditingController;
  late TextEditingController birthdayEditingController;
  late TextEditingController phoneNumberEditingController;
  late TextEditingController emailEditingController;
  late String countryCode;
  late FocusNode phoneNumberFocus;
  late FocusNode emailFocus;
  @override
  void initState() {
    identityEditingController = TextEditingController();
    nameEditingController = TextEditingController();
    birthdayEditingController = TextEditingController();
    phoneNumberEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    phoneNumberFocus = FocusNode();
    emailFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    identityEditingController.dispose();
    nameEditingController.dispose();
    birthdayEditingController.dispose();
    phoneNumberEditingController.dispose();
    emailEditingController.dispose();
    phoneNumberFocus.dispose();
    emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xIsTCNationality = widget.userAccount.nationality?.xIsTCNationality;
    if (xIsTCNationality != null) {
      identityEditingController.text = xIsTCNationality
          ? widget.userAccount.identificationNumber ?? ''
          : widget.userAccount.passaportNumber ?? '';
    }
    countryCode = widget.userAccount.countryCode ?? '+90';
    final userName = widget.userAccount.name ?? '';
    final userSurname = widget.userAccount.surname ?? '';
    nameEditingController.text = userName + " " + userSurname;
    final patientsLength = widget.userAccount.patients?.length ?? 0;
    if (patientsLength > 0) {
      final patientsFirstBirthDate =
          widget.userAccount.patients?.first.birthDate?.replaceAll('.', '/') ??
              '';
      birthdayEditingController.text =
          patientsLength > 0 ? patientsFirstBirthDate : "-";
    }
    final isEMail =
        !(widget.userAccount.electronicMail?.contains("@mailyok.com") ?? false);
    if (isEMail) {
      emailEditingController.text = widget.userAccount.electronicMail ?? '';
    }

    phoneNumberEditingController.text = widget.userAccount.phoneNumber ?? '';
    return BlocConsumer<PersonelInformationCubit, PersonelInformationState>(
      listener: (context, state) async {
        if (state.status == PersonelInformationStatus.success) {
          Utils.instance.showSuccessSnackbar(
            context,
            LocaleProvider.current.personal_update_success,
          );

          if (widget.isEmailRequired) {
            Atom.to(PagePaths.main, isReplacement: true);
          }
        } else if (state.status == PersonelInformationStatus.deletePhoto) {
        } else if (state.status ==
            PersonelInformationStatus.getPhotoFromSource) {
          if (state.imageSource == ImageSource.gallery) {
            if (!await getIt<PermissionManager>().request(
              permission: GalleryPermissionStrategy(
                LocaleProvider.current,
                getIt<IAppConfig>(),
              ),
              context: context,
            )) {
              Navigator.of(context).pop();
              return;
            } else {
              if (!await getIt<PermissionManager>().request(
                permission: CameraPermissionStrategy(
                  LocaleProvider.current,
                  getIt<IAppConfig>(),
                ),
                context: context,
              )) {
                Navigator.of(context).pop();
                return;
              }
            }
          }
        } else if (state.status == PersonelInformationStatus.errorDialog) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return RbioMessageDialog(
                description: LocaleProvider.of(context).sorry_dont_transaction,
                buttonTitle: LocaleProvider.current.ok,
                isAtom: false,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return KeyboardDismissOnTap(
          child: RbioStackedScaffold(
            isLoading: state.isLoading,
            resizeToAvoidBottomInset: true,
            appbar: _buildAppBar(context),
            body: _builBody(context, state),
          ),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,

      /// Kullanici mail adresi boş ise, oturum açma esnasında Ana sayfa yerine
      /// kişisel bilgilerim sayfası açılır ve kullanıcıdan mail girmesi istenilir.
      /// Bu senaryoda sayfada geri butonu yer almaz.
      leading: widget.isEmailRequired ? const SizedBox() : null,
      leadingWidth: widget.isEmailRequired ? 0 : null,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).lbl_personal_information,
      ),
    );
  }

  Widget _builBody(BuildContext context, PersonelInformationState state) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Expanded(
              child: RbioKeyboardActions(
                focusList: [
                  phoneNumberFocus,
                  emailFocus,
                ],
                child: KeyboardAvoider(
                  autoScroll: true,
                  duration: const Duration(seconds: 1),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //
                        R.widgets.stackedTopPadding(context),
                        R.widgets.hSizer16,

                        //
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //
                              CircleAvatar(
                                backgroundImage: state.getProfileImage,
                                radius: R.sizes.iconSize * 1.3,
                                backgroundColor: context.xCardColor,
                              ),

                              //
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    getIt<IAppConfig>().theme.textColorPassive,
                                  ),
                                ),
                                onPressed: () {
                                  _openCupertinoModalPopup();
                                },
                                child: Text(
                                  LocaleProvider.current.change,
                                  style: context.xHeadline5.copyWith(
                                    color: context.xPrimaryColor,
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
                          (widget.userAccount.nationality?.xIsTCNationality ??
                                  false)
                              ? LocaleProvider.of(context).tc_identity_number
                              : LocaleProvider.of(context).passport_number,
                        ),
                        _buildDisabledTextField(
                          identityEditingController,
                        ),

                        // Name
                        _buildSpacer(),
                        _buildTitle(
                          LocaleProvider.of(context).name,
                        ),
                        _buildDisabledTextField(
                          nameEditingController,
                        ),

                        // Birthday
                        _buildSpacer(),
                        _buildTitle(
                          LocaleProvider.of(context).birth_date,
                        ),
                        _buildDisabledTextField(
                          birthdayEditingController,
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
                              initialSelection: widget
                                          .userAccount.countryCode ==
                                      null
                                  ? '+90'
                                  : widget.userAccount.countryCode!
                                          .contains('+')
                                      ? widget.userAccount.countryCode
                                      : '+' + widget.userAccount.countryCode!,
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
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return LocaleProvider.current.validation;
                                  }
                                },
                                autovalidateMode: autovalidateMode,
                                focusNode: phoneNumberFocus,
                                controller: phoneNumberEditingController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                hintText:
                                    LocaleProvider.of(context).phone_number,
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
                          validator: (value) {
                            if (!R.regExp.email.hasMatch(value!)) {
                              return LocaleProvider.of(context).invalid_mail;
                            } else if (value.isNotEmpty) {
                              return null;
                            } else {
                              return LocaleProvider.current.validation;
                            }
                          },
                          autovalidateMode: AutovalidateMode.always,
                          focusNode: emailFocus,
                          controller: emailEditingController,
                          textInputAction: TextInputAction.done,
                          hintText: LocaleProvider.of(context).email_address,
                          inputFormatters: <TextInputFormatter>[
                            TabToNextFieldTextInputFormatter(
                                context, emailFocus, null),
                          ],
                          onFieldSubmitted: (String term) {
                            Utils.instance
                                .fieldFocusChange(context, emailFocus, null);
                          },
                        ),
                      ],
                    ),
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
                        backColor: context.xCardColor,
                        textColor: getIt<IAppConfig>().theme.textColorSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //
                    R.widgets.wSizer12,

                    //
                    Expanded(
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.update,
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context
                                .read<PersonelInformationCubit>()
                                .updateValues(
                                  countryCode: countryCode,
                                  newPhoneNumber:
                                      phoneNumberEditingController.text.trim(),
                                  newEmail: emailEditingController.text.trim(),
                                );
                          } else {
                            LocaleProvider.current.validation;
                          }
                        },
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            //
            R.widgets.defaultBottomPadding,
          ],
        );
      },
    );
  }

  Widget _buildSpacer() => R.widgets.hSizer16;

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

  void _openCupertinoModalPopup() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext ctx) {
        return BlocProvider.value(
          value: context.read<PersonelInformationCubit>(),
          child: Builder(
            builder: (context) {
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
                            await context
                                .read<PersonelInformationCubit>()
                                .deletePhoto();
                            Navigator.pop(context);
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
                            await context
                                .read<PersonelInformationCubit>()
                                .deletePhoto();
                            Navigator.pop(context);
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
                            await context
                                .read<PersonelInformationCubit>()
                                .getPhotoFromSource(
                                  ImageSource.gallery,
                                );
                            Navigator.pop(context);
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
                            await context
                                .read<PersonelInformationCubit>()
                                .getPhotoFromSource(
                                  ImageSource.camera,
                                );
                            Navigator.pop(context);
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
          ),
        );
      },
    );
  }
}
