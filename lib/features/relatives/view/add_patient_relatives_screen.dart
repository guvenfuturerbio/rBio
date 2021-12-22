import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import '../viewmodel/add_patient_relatives_vm.dart';

class AddPatientRelativesScreen extends StatefulWidget {
  @override
  State<AddPatientRelativesScreen> createState() =>
      _AddPatientRelativesScreenState();
}

class _AddPatientRelativesScreenState extends State<AddPatientRelativesScreen> {
  String gender;
  List genderList = ["E", "K"];

  TextEditingController relativeTcNo;
  TextEditingController relativeName;
  TextEditingController relativeSurname;
  TextEditingController relativeEmail;

  @override
  void initState() {
    relativeTcNo = TextEditingController();
    relativeName = TextEditingController();
    relativeSurname = TextEditingController();
    relativeEmail = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    relativeTcNo.dispose();
    relativeName.dispose();
    relativeSurname.dispose();
    relativeEmail.dispose();
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
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).add_new_relative,
              ),
            ),
            body: _buildBody(context, vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddPatientRelativesScreenVm vm) {
    switch (vm.status) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildWithUserAcc(context, vm.userAccount, vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildWithUserAcc(
    BuildContext context,
    UserAccount userAccount,
    AddPatientRelativesScreenVm vm,
  ) {
    return KeyboardAvoider(
      autoScroll: true,
      child: Column(
        children: <Widget>[
          //
          SizedBox(
            height: 40,
          ),

          //
          Wrap(
            children: [
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                    child: Text(
                      LocaleProvider.current.name,
                      style: context.xHeadline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: RbioTextFormField(
                      controller: relativeName,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: LocaleProvider.of(context).name,
                      onFieldSubmitted: (term) {},
                    ),
                  ),
                ],
              ),

              //
              SizedBox(
                width: 5,
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      bottom: 5,
                      top: 15,
                    ),
                    child: Text(
                      LocaleProvider.current.surname,
                      style: context.xHeadline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: RbioTextFormField(
                      controller: relativeSurname,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: LocaleProvider.of(context).surname,
                      onFieldSubmitted: (term) {},
                    ),
                  ),
                ],
              ),
            ],
          ),

          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 5,
                  top: 15,
                ),
                child: Text(
                  LocaleProvider.current.gender,
                  style:
                      context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              //
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    addRadioButton(0, 'Male'),
                    addRadioButton(1, 'Female'),
                  ],
                ),
              ),
            ],
          ),
          //
          Wrap(
            children: [
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      bottom: 5,
                      top: 15,
                    ),
                    child: Text(
                      LocaleProvider.current.birth_date,
                      style: context.xHeadline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () => vm.selectDate(context),
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: R.color.white,
                        border: Border.all(
                          color: R.color.dark_white,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (vm.selectedDate == null)
                              ? Text('DD/MM/YYYY',
                                  style: context.xHeadline3.copyWith(
                                      color: getIt<ITheme>()
                                          .textColorSecondary
                                          .withOpacity(0.5)))
                              : Text(
                                  DateFormat('dd MMMM yyyy')
                                      .format(vm.selectedDate),
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                          Icon(Icons.calendar_today)
                        ],
                      ),
                      margin: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                  ),
                ],
              ),

              //
              SizedBox(
                width: 5,
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleProvider.current.country,
                    style: context.xHeadline3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      return Atom.show(
                        GuvenAlert(
                          title: GuvenAlert.buildTitle(
                              LocaleProvider.current.country),
                          backgroundColor: getIt<ITheme>().cardBackgroundColor,
                          content: Container(
                            height: 300.0, // Change as per your requirement
                            width: 300.0, // Change as per your requirement
                            child: ListView.builder(
                              itemCount: vm.countryList.countries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    vm.setSelectedCountry(
                                      vm.countryList.countries[index],
                                    );
                                    Atom.dismiss();
                                  },
                                  title: Text(
                                    vm.countryList.countries[index].name,
                                    style: context.xHeadline4,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 13.0,
                        bottom: 15,
                        top: 13,
                      ),
                      decoration: BoxDecoration(
                        color: R.color.white,
                        border: Border.all(
                          color: R.color.dark_white,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          //
                          SizedBox(
                            width: 8,
                          ),

                          //
                          Text(
                            vm.selectedCountry.name.toString(),
                            style: context.xHeadline4,
                          ),

                          //
                          SizedBox(width: 10),

                          //
                          Transform.rotate(
                            angle: -190,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: context.TEXTSCALE * 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
                addPatientRelative.gender = vm.selectedGender == 1 ? 'E' : 'K';
                addPatientRelative.patientType = 1;
                addPatientRelative.email = relativeEmail.text;
                addPatientRelative.nationalityId = vm.selectedCountry.id;
                addPatientRelative.nationalityId == 213
                    ? addPatientRelative.patientType = 1
                    : addPatientRelative.patientType = 3;

                if (relativeTcNo.text.length > 0 &&
                    relativeName.text.length > 0 &&
                    relativeSurname.text.length > 0 &&
                    relativeEmail.text.length > 0 &&
                    vm.selectedDate != null) {
                  vm.savePatientRelative(addPatientRelative, context);
                } else {
                  vm.showGradientDialog(
                    context,
                    LocaleProvider.of(context).warning,
                    LocaleProvider.of(context).fill_all_field,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // #region addRadioButton
  Widget addRadioButton(int btnValue, String title) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: genderList[btnValue],
            groupValue: gender,
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
          ),

          //
          Text(
            title,
            style: context.xHeadline3,
          ),
        ],
      ),
    );
  }
  // #endregion
}
