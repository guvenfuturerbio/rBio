import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as masked;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'add_patient_relatives_vm.dart';

class AddPatientRelativesScreen extends StatelessWidget {
  final tcFNode = FocusNode();
  final nameFNode = FocusNode();
  final surnameFNode = FocusNode();
  final phoneFNode = FocusNode();
  final emailFNode = FocusNode();

  final TextEditingController relativeTcNo = TextEditingController();
  final TextEditingController relativeName = TextEditingController();
  final TextEditingController relativeSurname = TextEditingController();
  final TextEditingController _relativeEmail = TextEditingController();

  final masked.MaskedTextController _relativePhoneNumber =
      masked.MaskedTextController(mask: '(000) 000-0000');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPatientRelativesScreenVm>(
      create: (context) => AddPatientRelativesScreenVm(context),
      child: Consumer<AddPatientRelativesScreenVm>(
        builder: (
          BuildContext context,
          AddPatientRelativesScreenVm vm,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).add_new_relative,
              ),
            ),
            body: _builBody(context, vm),
          );
        },
      ),
    );
  }

  Widget _builBody(BuildContext context, AddPatientRelativesScreenVm vm) {
    if (vm.status == LoadingStatus.loading) {
      return RbioLoading();
    } else {
      return _buildWithUserAcc(context, vm.userAccount, vm);
    }
  }

  Widget _buildWithUserAcc(
    BuildContext context,
    UserAccount userAccount,
    AddPatientRelativesScreenVm vm,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: <Widget>[
            //
            SizedBox(
              height: 40,
            ),

            //
            InkWell(
              onTap: () {
                return Get.defaultDialog(
                  title: "Countries",
                  titleStyle: TextStyle(
                    color: getIt<ITheme>().mainColor,
                  ),
                  content: Container(
                    height: 300.0, // Change as per your requirement
                    width: 300.0, // Change as per your requirement
                    child: ListView.builder(
                      itemCount: vm.countryList.countries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            vm.setSelectedCountry(
                                vm.countryList.countries[index]);

                            Navigator.pop(context);
                          },
                          title: Text(
                            vm.countryList.countries[index].name,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: R.color.dark_white,
                  ),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      R.image.ic_user,
                      fit: BoxFit.none,
                    ),
                    SizedBox(width: 8),
                    Text(
                      vm.selectedCountry.name.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: relativeTcNo,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                obscureText: false,
                style: Utils.instance.inputTextStyle(),
                decoration: Utils.instance.inputImageDecoration(
                  hintText: 'Yakının TC Kimlik Numarası / Pasaport Numarası',
                  image: R.image.ic_user,
                ),
                focusNode: tcFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    tcFNode,
                    nameFNode,
                  ),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\t\r]'))
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    tcFNode,
                    nameFNode,
                  );
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: relativeName,
                style: Utils.instance.inputTextStyle(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: Utils.instance.inputImageDecoration(
                  hintText: LocaleProvider.of(context).name,
                  image: R.image.ic_user,
                ),
                focusNode: nameFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    nameFNode,
                    surnameFNode,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    nameFNode,
                    surnameFNode,
                  );
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: relativeSurname,
                style: Utils.instance.inputTextStyle(),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: Utils.instance.inputImageDecoration(
                  hintText: LocaleProvider.of(context).surname,
                  image: R.image.ic_user,
                ),
                focusNode: surnameFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    surnameFNode,
                    null,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    surnameFNode,
                    null,
                  );
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _relativePhoneNumber,
                style: Utils.instance.inputTextStyle(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: Utils.instance.inputImageDecoration(
                  hintText: LocaleProvider.of(context).phone_number,
                  image: R.image.ic_phone_call_grey,
                ),
                focusNode: phoneFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    phoneFNode,
                    emailFNode,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    phoneFNode,
                    emailFNode,
                  );
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _relativeEmail,
                style: Utils.instance.inputTextStyle(),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                decoration: Utils.instance.inputImageDecoration(
                  hintText: LocaleProvider.of(context).email_address,
                  image: R.image.ic_email,
                ),
                focusNode: emailFNode,
                inputFormatters: <TextInputFormatter>[
                  TabToNextFieldTextInputFormatter(
                    context,
                    emailFNode,
                    null,
                  ),
                ],
                onFieldSubmitted: (term) {
                  UtilityManager().fieldFocusChange(
                    context,
                    emailFNode,
                    null,
                  );
                },
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 15),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(R.image.ic_calendar_black),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: GestureDetector(
                          onTap: () {
                            vm.selectDate(context);
                          },
                          child: Text(vm.selectedDate == null
                              ? LocaleProvider.of(context).birth_date
                              : DateFormat('dd MMMM yyyy')
                                  .format(vm.selectedDate))),
                    ),
                  ],
                ),
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(R.image.ic_gender_selection_grey),

                  //
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton(
                      value: vm.selectedGender,
                      onChanged: (value) {
                        vm.changeGender(value);
                      },
                      items: [
                        //
                        DropdownMenuItem(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(LocaleProvider.of(context).gender_male),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SvgPicture.asset(R.image.ic_male_grey),
                              ),
                            ],
                          ),
                          value: 1,
                        ),

                        //
                        DropdownMenuItem(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(LocaleProvider.of(context).gender_female),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SvgPicture.asset(R.image.ic_female_grey),
                              ),
                            ],
                          ),
                          value: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //
            Center(
              child: Text(
                LocaleProvider.of(context).relatives_only_children_warning,
                textAlign: TextAlign.center,
              ),
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Utils.instance.button(
                text: LocaleProvider.of(context).save,
                onPressed: () {
                  AddPatientRelativeRequest addPatientRelative =
                      AddPatientRelativeRequest();
                  String formattedDate =
                      DateFormat('EEE MMM dd yyyy HH:mm:ss', 'en')
                          .format(vm.selectedDate);
                  formattedDate += " GMT+0300 (GMT+03:00)";

                  addPatientRelative.firstName = relativeName.text;
                  addPatientRelative.lastName = relativeSurname.text;
                  addPatientRelative.identityNumber = relativeTcNo.text;
                  addPatientRelative.birthDate = formattedDate;
                  addPatientRelative.gender =
                      vm.selectedGender == 1 ? 'E' : 'K';
                  addPatientRelative.patientType = 1;
                  addPatientRelative.gsm = _relativePhoneNumber.text;
                  addPatientRelative.email = _relativeEmail.text;
                  addPatientRelative.nationalityId = vm.selectedCountry.id;
                  addPatientRelative.nationalityId == 213
                      ? addPatientRelative.patientType = 1
                      : addPatientRelative.patientType = 3;

                  if (relativeTcNo.text.length > 0 &&
                      relativeName.text.length > 0 &&
                      relativeSurname.text.length > 0 &&
                      _relativeEmail.text.length > 0 &&
                      _relativePhoneNumber.text.length > 0 &&
                      vm.selectedDate != null) {
                    vm.savePatientRelative(addPatientRelative, context);
                  } else {
                    vm.showGradientDialog(
                        context,
                        LocaleProvider.of(context).warning,
                        LocaleProvider.of(context).fill_all_field);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
