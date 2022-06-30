// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';

import '../../../../model/model.dart';
import '../cubit/add_patient_relatives_cubit.dart';

part 'widget/add_pr_text_field.dart';

class AddPatientRelativeScreen extends StatelessWidget {
  const AddPatientRelativeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPatientRelativesCubit(getIt(), getIt()),
      child: const AddPatientRelativeView(),
    );
  }
}

class AddPatientRelativeView extends StatefulWidget {
  const AddPatientRelativeView({Key? key}) : super(key: key);

  @override
  State<AddPatientRelativeView> createState() => _AddPatientRelativeViewState();
}

class _AddPatientRelativeViewState extends State<AddPatientRelativeView> {
  late final TextEditingController birthDateController;
  late final FocusNode birthDateFNode;
  late final TextEditingController countryController;
  late final FocusNode countryFNode;
  late final TextEditingController emailController;
  late final FocusNode emailFNode;
  late final TextEditingController genderController;
  late final FocusNode genderFNode;
  late final TextEditingController nameController;
  late final FocusNode nameFNode;
  late final MaskedTextController phoneController;
  late final FocusNode phoneFNode;
  late final TextEditingController surnameController;
  late final FocusNode surnameFNode;
  late final TextEditingController tcNoController;
  late final FocusNode tcNoFNode;

  late final GlobalKey<FormState> _formKey;

  final List<String> listOfGender = [
    LocaleProvider.current.male,
    LocaleProvider.current.female,
  ];

  @override
  void initState() {
    super.initState();

    tcNoFNode = FocusNode();
    nameFNode = FocusNode();
    surnameFNode = FocusNode();
    phoneFNode = FocusNode();
    emailFNode = FocusNode();
    countryFNode = FocusNode();
    birthDateFNode = FocusNode();
    genderFNode = FocusNode();

    tcNoController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    countryController = TextEditingController(text: R.constants.turkey);
    birthDateController = TextEditingController();
    genderController = TextEditingController();

    _formKey = GlobalKey<FormState>();
    phoneController = MaskedTextController(mask: '(000) 000-0000');
  }

  @override
  void dispose() {
    tcNoFNode.dispose();
    nameFNode.dispose();
    surnameFNode.dispose();
    phoneFNode.dispose();
    emailFNode.dispose();
    countryFNode.dispose();
    birthDateFNode.dispose();
    genderFNode.dispose();

    tcNoController.dispose();
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    countryController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
            context, LocaleProvider.of(context).add_new_relative),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddPatientRelativesCubit, AddPatientRelativesState>(
      listener: (context, state) {
        if (state.status == AddPatientRelativesStatus.failure) {
          Utils.instance.showErrorSnackbar(
            context,
            LocaleProvider.of(context).something_went_wrong,
          );
        } else if (state.status == AddPatientRelativesStatus.done) {
          Utils.instance.showSuccessSnackbar(
              context, LocaleProvider.of(context).add_relative_request);
          Atom.historyBack();
        } else if (state.status == AddPatientRelativesStatus.datum0) {
          Utils.instance.showSuccessSnackbar(
              context, LocaleProvider.of(context).existing_relative_add);
          Atom.historyBack();
        } else if (state.status == AddPatientRelativesStatus.datum1) {
          Utils.instance.showSuccessSnackbar(
              context, LocaleProvider.of(context).add_new_relative);
          Atom.historyBack();
        }
      },
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            _buildSuccess(context, state.model),

            //
            if (state.status ==
                AddPatientRelativesStatus.loadingInProgress) ...[
              RbioLoading.progressIndicator()
            ],
          ],
        );
      },
    );
  }

  Widget _buildSuccess(BuildContext context, UserRelativePatientModel model) {
    validatorForEmpty(String? value) {
      if (value!.isEmpty) {
        return LocaleProvider.of(context).validation;
      } else {
        return null;
      }
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //! Country
            _AddPRTextField(
              prefixSvgPath: R.image.user,
              readOnly: true,
              controller: countryController,
              focusNode: countryFNode,
            ),

            //! TC & Passaport
            _AddPRTextField(
              hintText: LocaleProvider.of(context).relative_identity_number,
              prefixSvgPath: R.image.user,
              controller: tcNoController,
              focusNode: tcNoFNode,
              keyboardType: TextInputType.number,
              maxLenght: 11,
              counterText: "",
              validator: (value) {
                if (value!.length != 11) {
                  return LocaleProvider.of(context).invalid_identity_number;
                } else {
                  return null;
                }
              },
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, tcNoFNode, nameFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]')),
              ],
              onFieldSubmitted: (term) {
                Utils.instance.fieldFocusChange(context, tcNoFNode, nameFNode);
              },
            ),

            //! Name
            _AddPRTextField(
              hintText: LocaleProvider.of(context).name,
              prefixSvgPath: R.image.user,
              controller: nameController,
              focusNode: nameFNode,
              validator: validatorForEmpty,
              keyboardType: TextInputType.name,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, nameFNode, surnameFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\t\r]')),
              ],
              onFieldSubmitted: (term) {
                Utils.instance.fieldFocusChange(context, nameFNode, surnameFNode);
              },
            ),

            //! Surname
            _AddPRTextField(
              hintText: LocaleProvider.of(context).surname,
              prefixSvgPath: R.image.user,
              controller: surnameController,
              focusNode: surnameFNode,
              validator: validatorForEmpty,
              keyboardType: TextInputType.name,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, surnameFNode, phoneFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\t\r]')),
              ],
              onFieldSubmitted: (term) {
                Utils.instance.fieldFocusChange(context, surnameFNode, phoneFNode);
              },
            ),

            //! Phone
            _AddPRTextField(
              hintText: LocaleProvider.of(context).phone_number,
              prefixSvgPath: R.image.icPhoneGrey,
              controller: phoneController,
              focusNode: phoneFNode,
              maxLenght: 14,
              keyboardType: TextInputType.phone,
              counterText: "",
              validator: (value) {
                if (value!.length != 14) {
                  return LocaleProvider.of(context).invalid_phone_number;
                } else {
                  return null;
                }
              },
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                    context, phoneFNode, emailFNode),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]')),
              ],
              onFieldSubmitted: (term) {
                Utils.instance.fieldFocusChange(context, phoneFNode, emailFNode);
              },
            ),

            //! Mail
            _AddPRTextField(
              hintText: LocaleProvider.of(context).email_address,
              prefixSvgPath: R.image.email,
              controller: emailController,
              focusNode: emailFNode,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                RegExp mailReg = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                if (!mailReg.hasMatch(value!)) {
                  return LocaleProvider.of(context).invalid_mail;
                } else {
                  return null;
                }
              },
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, emailFNode, null),
              ],
              onFieldSubmitted: (String term) {
                Utils.instance.fieldFocusChange(context, emailFNode, null);
              },
            ),

            //! DatePicker
            _AddPRTextField(
              hintText: LocaleProvider.of(context).birth_date,
              prefixSvgPath: R.image.icClendarBlack,
              readOnly: true,
              validator: validatorForEmpty,
              controller: birthDateController,
              focusNode: birthDateFNode,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, birthDateFNode, null),
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')),
              ],
              onFieldSubmitted: (term) {
                Utils.instance.fieldFocusChange(context, birthDateFNode, null);
              },
              onTap: () async {
                final DateTime? picked = await showRbioDatePicker(
                  context,
                  title: LocaleProvider.of(context).select_birth_date,
                  initialDateTime:
                      DateTime.now().subtract(const Duration(days: 365 * 18)),
                  maximumDate:
                      DateTime.now().subtract(const Duration(days: 365 * 18)),
                  minimumDate:
                      DateTime.now().subtract(const Duration(days: 365 * 100)),
                  maxYear: DateTime.now().year - 18,
                  minYear: DateTime.now().year - 99,
                );

                if (picked != null) {
                  birthDateController.text = DateFormat.yMMMMd().format(picked);
                  context.read<AddPatientRelativesCubit>().updateModel(
                      model.copyWith(birthDate: picked.toString()));
                }
              },
            ),

            //! Gender
            _AddPRTextField(
              hintText: LocaleProvider.of(context).gender,
              prefixSvgPath: R.image.icGenderSelectionGrey,
              readOnly: true,
              controller: genderController,
              focusNode: genderFNode,
              validator: validatorForEmpty,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(context, genderFNode, null),
              ],
              onFieldSubmitted: (String term) {
                Utils.instance.fieldFocusChange(context, genderFNode, null);
              },
              onTap: () async {
                var res = await showRbioSelectBottomSheet(
                  context,
                  title: LocaleProvider.current.gender,
                  children: [
                    for (var item in listOfGender) Center(child: Text(item))
                  ],
                  initialItem: 0,
                );

                genderController.text = listOfGender[res as int];
              },
              onChanged: (String value) {
                genderController.text = value;
              },
            ),

            const SizedBox(height: 30),

            //
            Center(
              child: Text(
                LocaleProvider.of(context).relatives_only_children_warning,
                style: context.xTextTheme.headline5,
              ),
            ),

            //
            const SizedBox(height: 10),

            //
            RbioElevatedButton(
              title: LocaleProvider.of(context).save,
              fontWeight: FontWeight.bold,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  UserRelativePatientModel addPatientRelative =
                      UserRelativePatientModel(
                    firstName: nameController.text,
                    lastName: surnameController.text,
                    birthDate: model.birthDate,
                    gender:
                        genderController.text == LocaleProvider.of(context).male
                            ? 'E'
                            : 'K',
                    gsm: phoneController.text,
                    email: emailController.text,
                    identityNumber: tcNoController.text,
                    nationalityId: "213",
                  );

                  if (addPatientRelative.identityNumber!.isNotEmpty &&
                      addPatientRelative.firstName!.isNotEmpty &&
                      addPatientRelative.lastName!.isNotEmpty &&
                      addPatientRelative.birthDate!.isNotEmpty &&
                      addPatientRelative.email!.isNotEmpty &&
                      addPatientRelative.gsm!.isNotEmpty &&
                      addPatientRelative.birthDate!.isNotEmpty) {
                    context
                        .read<AddPatientRelativesCubit>()
                        .updateModel(addPatientRelative);

                    context
                        .read<AddPatientRelativesCubit>()
                        .addPatientRelative(addPatientRelative);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
