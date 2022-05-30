// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';

class AddPatientRelativeScreen extends StatelessWidget {
  const AddPatientRelativeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
            context, LocaleProvider.of(context).add_new_relative),
      ),
      body: _buildBody(context),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    final tcFNode = FocusNode();
    final nameFNode = FocusNode();
    final surnameFNode = FocusNode();
    final phoneFNode = FocusNode();
    final emailFNode = FocusNode();

    final TextEditingController tcNoController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    validatorForEmpty(String? value) {
      if (value!.isEmpty) {
        return LocaleProvider.of(context).validation;
      } else {
        return null;
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).country,
              prefixSvgPath: R.image.user,
              editable: false,
            ),
            //! TC & Passaport
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).tc_or_passport,
              prefixSvgPath: R.image.user,
              controller: tcNoController,
              focusNode: tcFNode,
              keyboardType: TextInputType.number,
              validator: validatorForEmpty,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, tcFNode, nameFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]')),
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(context, tcFNode, nameFNode);
              },
            ),
            //! Name
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).name,
              prefixSvgPath: R.image.user,
              controller: nameController,
              focusNode: nameFNode,
              validator: validatorForEmpty,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, nameFNode, surnameFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\t\r]')),
              ],
              onFieldSubmitted: (term) {
                UtilityManager()
                    .fieldFocusChange(context, nameFNode, surnameFNode);
              },
            ),
            //! Surname
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).surname,
              prefixSvgPath: R.image.user,
              controller: surnameController,
              focusNode: surnameFNode,
              validator: validatorForEmpty,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, surnameFNode, phoneFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\t\r]')),
              ],
              onFieldSubmitted: (term) {
                UtilityManager()
                    .fieldFocusChange(context, surnameFNode, phoneFNode);
              },
            ),
            //! Phone
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).phone_number,
              prefixSvgPath: R.image.icPhoneGrey,
              controller: phoneController,
              focusNode: phoneFNode,
              maxLenght: 10,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.length != 10) {
                  return LocaleProvider.of(context).validation_of_phone_number;
                } else {
                  return null;
                }
              },
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, phoneFNode, emailFNode),
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
              ],
              onFieldSubmitted: (term) {
                UtilityManager()
                    .fieldFocusChange(context, phoneFNode, emailFNode);
              },
            ),
            //! Mail
            _BuildAddPRTextField(
              hintText: LocaleProvider.of(context).email_address,
              prefixSvgPath: R.image.email,
              controller: emailController,
              focusNode: emailFNode,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                RegExp mailReg = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                // if (reg.hasMatch(value!)) return "Hata";
                if (!mailReg.hasMatch(value!)) {
                  return LocaleProvider.of(context).Ok;
                } else {
                  return null;
                }
              },
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, emailFNode, null),
              ],
              onFieldSubmitted: (String term) {
                // UtilityManager().fieldFocusChange(context, emailFNode, null);
                FocusScope.of(context).unfocus();
              },
            ),
            //! DatePicker
            _BuildAddPRBottomSheet(
              text: LocaleProvider.of(context).birth_date,
              svgPath: R.image.icClendarBlack,
              onPressed: () async {
                await showRbioDatePicker(
                  context,
                  title: LocaleProvider.of(context).select_birth_date,
                  initialDateTime: DateTime.now(),
                );
              },
            ),
            //! Gender
            _BuildAddPRBottomSheet(
              text: LocaleProvider.of(context).gender,
              svgPath: R.image.icGenderSelectionGrey,
              onPressed: () async {
                await showRbioSelectBottomSheet(
                  context,
                  title: LocaleProvider.current.gender,
                  children: [
                    Text(LocaleProvider.current.male),
                    Text(LocaleProvider.current.female),
                  ],
                  initialItem: 0,
                );
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                LocaleProvider.of(context).relatives_only_children_warning,
                style: context.xTextTheme.headline5,
              ),
            ),
            const SizedBox(height: 10),
            RbioElevatedButton(
              title: LocaleProvider.of(context).save,
              fontWeight: FontWeight.bold,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
//               var result = await auth.sendPasswordResetEmail(_email);
//               print(result);
                  Atom.historyBack();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildAddPRTextField extends StatelessWidget {
  const _BuildAddPRTextField({
    Key? key,
    required this.hintText,
    required this.prefixSvgPath,
    this.editable = true,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.maxLenght,
    this.validator,
    this.controller,
    this.focusNode,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final String prefixSvgPath;
  final bool editable;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onFieldSubmitted;
  final int? maxLenght;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: editable
          ? RbioTextFormField(
              hintText: hintText,
              maxLength: maxLenght,
              inputFormatters: inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: onFieldSubmitted,
              validator: validator,
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              prefixIcon: SvgPicture.asset(
                prefixSvgPath,
                fit: BoxFit.scaleDown,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: getIt<IAppConfig>().theme.white,
                border: Border.all(
                  color: getIt<IAppConfig>().theme.white,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    prefixSvgPath,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(width: 16),
                  Text('Türkiye', style: context.xTextTheme.headline4),
                ],
              ),
            ),
    );
  }
}

class _BuildAddPRBottomSheet extends StatelessWidget {
  const _BuildAddPRBottomSheet({
    Key? key,
    required this.svgPath,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final String svgPath;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: getIt<IAppConfig>().theme.white,
            border: Border.all(
              color: getIt<IAppConfig>().theme.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
              ),
              const SizedBox(width: 16),
              Text(text, style: context.xHeadline4)
            ],
          ),
        ),
      ),
    );
  }
}
