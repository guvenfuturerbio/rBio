import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import '../viewmodel/add_patient_relatives_vm.dart';

class AddPatientRelativesScreen extends StatefulWidget {
  const AddPatientRelativesScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientRelativesScreen> createState() =>
      _AddPatientRelativesScreenState();
}

class _AddPatientRelativesScreenState extends State<AddPatientRelativesScreen> {
  late TextEditingController _nameEditingController;
  late TextEditingController _surnameEditingController;

  @override
  void initState() {
    _nameEditingController = TextEditingController();
    _surnameEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _surnameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPatientRelativesScreenVm>(
      create: (context) => AddPatientRelativesScreenVm(context),
      child: Consumer<AddPatientRelativesScreenVm>(
        builder: (
          BuildContext context,
          AddPatientRelativesScreenVm vm,
          Widget? child,
        ) {
          return KeyboardDismissOnTap(
            child: RbioScaffold(
              appbar: RbioAppBar(
                title: RbioAppBar.textTitle(
                  context,
                  LocaleProvider.of(context).add_new_relative,
                ),
              ),
              body: _buildBody(context, vm),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddPatientRelativesScreenVm vm) {
    switch (vm.status) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildWithUserAcc(context, vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildWithUserAcc(
    BuildContext context,
    AddPatientRelativesScreenVm vm,
  ) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //
          const SizedBox(height: 25),

          //
          _buildTitle(context, LocaleProvider.current.name),

          //
          RbioTextFormField(
            controller: _nameEditingController,
            obscureText: false,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            hintText: LocaleProvider.of(context).name,
            onFieldSubmitted: (term) {},
          ),

          //
          _buildTitle(context, LocaleProvider.current.surname),

          //
          RbioTextFormField(
            controller: _surnameEditingController,
            obscureText: false,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            hintText: LocaleProvider.of(context).surname,
            onFieldSubmitted: (term) {},
          ),

          //
          _buildTitle(context, LocaleProvider.current.gender),

          //
          addRadioButton(vm, 0, LocaleProvider.current.male),
          addRadioButton(vm, 1, LocaleProvider.current.female),

          //
          _buildTitle(context, LocaleProvider.current.birth_date),

          //
          InkWell(
            onTap: () => vm.selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: (vm.selectedDate == null)
                        ? Text(
                            'DD/MM/YYYY',
                            style: context.xHeadline4.copyWith(
                              color: getIt<ITheme>().textColorPassive,
                            ),
                          )
                        : Text(
                            DateFormat('dd MMMM yyyy').format(vm.selectedDate!),
                            style: context.xHeadline4,
                          ),
                  ),

                  //
                  Icon(
                    Icons.calendar_today,
                    size: R.sizes.iconSize3,
                  )
                ],
              ),
            ),
          ),

          //
          _buildTitle(context, LocaleProvider.current.country),

          //
          InkWell(
            onTap: () => showCountryPicker(vm),
            child: Container(
              padding: const EdgeInsets.only(left: 13.0, bottom: 15, top: 13),
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //
                  Flexible(
                    child: Text(
                      vm.selectedCountry.name.toString(),
                      style: context.xHeadline4,
                    ),
                  ),

                  //
                  const SizedBox(width: 10),

                  //
                  SvgPicture.asset(
                    R.image.arrowDown,
                    width: R.sizes.iconSize3,
                  ),
                ],
              ),
            ),
          ),

          //
          const SizedBox(height: 12),

          //
          Center(
            child: Text(
              LocaleProvider.of(context).relatives_only_children_warning,
              textAlign: TextAlign.center,
              style: context.xHeadline5,
            ),
          ),

          //
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: constraints.maxWidth * 0.15,
                ),
                child: RbioElevatedButton(
                  title: LocaleProvider.of(context).save,
                  onTap: () => addUser(vm),
                  infinityWidth: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _buildTitle(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
      child: Text(
        value,
        textAlign: TextAlign.start,
        style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  void showCountryPicker(AddPatientRelativesScreenVm vm) {
    Atom.show(
      GuvenAlert(
        title: GuvenAlert.buildTitle(LocaleProvider.current.country),
        backgroundColor: getIt<ITheme>().cardBackgroundColor,
        content: SizedBox(
          height: 300.0,
          width: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: vm.countryList.countries?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  final countries = vm.countryList.countries;
                  if (countries != null) {
                    if (countries.isNotEmpty) {
                      vm.setSelectedCountry(countries[index]);
                      Atom.dismiss();
                    }
                  }
                },
                title: Text(
                  vm.countryList.countries?[index].name ?? '',
                  style: context.xHeadline4,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void addUser(AddPatientRelativesScreenVm vm) {
    if (vm.selectedDate == null) return;

    AddPatientRelativeRequest addPatientRelative = AddPatientRelativeRequest();
    String formattedDate =
        DateFormat('EEE MMM dd yyyy HH:mm:ss', 'en').format(vm.selectedDate!);
    formattedDate += " GMT+0300 (GMT+03:00)";

    addPatientRelative.firstName = _nameEditingController.text;
    addPatientRelative.lastName = _surnameEditingController.text;
    addPatientRelative.identityNumber = '';
    addPatientRelative.birthDate = formattedDate;
    addPatientRelative.gender = vm.selectedGender == 1 ? 'E' : 'K';
    addPatientRelative.patientType = 1;
    addPatientRelative.email = '';
    addPatientRelative.nationalityId = vm.selectedCountry.id;
    addPatientRelative.nationalityId == 213
        ? addPatientRelative.patientType = 1
        : addPatientRelative.patientType = 3;

    if (_nameEditingController.text.isNotEmpty &&
        _surnameEditingController.text.isNotEmpty &&
        vm.selectedDate != null) {
      vm.savePatientRelative(addPatientRelative, context);
    } else {
      vm.showInfoDialog(
        LocaleProvider.of(context).warning,
        LocaleProvider.of(context).fill_all_field,
      );
    }
  }

  // #region addRadioButton
  Widget addRadioButton(
    AddPatientRelativesScreenVm vm,
    int btnValue,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        vm.setGender(vm.genderList[btnValue]);
      },
      child: Card(
        elevation: 0,
        color: getIt<ITheme>().cardBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //
            Radio(
              activeColor: Theme.of(context).primaryColor,
              value: vm.genderList[btnValue],
              groupValue: vm.gender,
              onChanged: (value) {
                if (value != null) {
                  if (value is String) {
                    vm.setGender(value);
                  }
                }
              },
            ),

            //
            Text(
              title,
              style: context.xHeadline4,
            ),
          ],
        ),
      ),
    );
  }
  // #endregion
}
