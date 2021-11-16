import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/user_profiles/person.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/edit_profile/edit_profile_vm.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/profile_page/range_selection_slider.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.edit_profile),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => EditProfileVm(mContext: context),
        child: Consumer<EditProfileVm>(
          builder: (ctxCons, val, child) => val.isLoading
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: context.HEIGHT * .18,
                      ),
                      _imageSection(val.selectedPerson, ctxCons,
                          () => val.navigateToImagePage()),
                      _userNameSection(val, ctxCons),
                      _demographicsSection(ctxCons, val),
                      _detailSection(ctxCons, val),
                      SizedBox(
                        height: ctxCons.HEIGHT * .04,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  GestureDetector _imageSection(
      Person person, BuildContext ctxCons, VoidCallback func) {
    return GestureDetector(
        onTap: func,
        child: SizedBox(
          height: ctxCons.HEIGHT * 0.15,
          width: ctxCons.HEIGHT * 0.15,
          child: _currentPersonAvatar(
            ctxCons,
            person,
          ),
        ));
  }

  Column _demographicsSection(BuildContext ctxCons, EditProfileVm val) {
    return Column(
      children: [
        _sectionHeader(ctxCons, LocaleProvider.of(ctxCons).demographic),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).gender,
            value: val.selectedPerson.gender ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showGenderSheet(
                  [
                    Text(
                      LocaleProvider.of(ctxCons).other,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      LocaleProvider.of(ctxCons).male,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      LocaleProvider.of(ctxCons).female,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).date_of_birth,
            value: val.selectedPerson.birthDate ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showDateSheet()),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).height,
            value: val.selectedPerson.height ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showHeightSheet(
                  [
                    ...List.generate(
                        250,
                        (index) => Text(
                              '$index cm',
                              style: TextStyle(color: Colors.black),
                            ))
                  ],
                )),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).weight,
            value: val.selectedPerson.weight ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showWeightSheet(
                  [
                    ...List.generate(
                        250,
                        (index) => Text(
                              '$index kg',
                              style: TextStyle(color: Colors.black),
                            ))
                  ],
                )),
      ],
    );
  }

  Column _detailSection(BuildContext ctxCons, EditProfileVm val) {
    return Column(
      children: [
        _sectionHeader(ctxCons, LocaleProvider.of(ctxCons).details),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).year_of_diagnosis,
            value: val.selectedPerson.yearOfDiagnosis ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showDiagnosisSheet([
                  ...List.generate(
                      100,
                      (index) => Text(
                            '${DateTime.now().year - index}',
                            style: TextStyle(color: Colors.black),
                          )),
                ])),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).smoker,
            value: val.selectedPerson.smoker == null
                ? LocaleProvider.of(ctxCons).unspecified
                : val.selectedPerson.smoker
                    ? LocaleProvider.current.smoker
                    : LocaleProvider.current.non_smoker,
            onPressed: () => val.showSmokerSheet(
                  [
                    Text(
                      LocaleProvider.of(ctxCons).non_smoker,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      LocaleProvider.of(ctxCons).smoker,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.of(ctxCons).diabetes_type,
            value: val.selectedPerson.diabetesType ??
                LocaleProvider.of(ctxCons).unspecified,
            onPressed: () => val.showDiabetsSheet(
                  [
                    Text(
                      LocaleProvider.of(ctxCons).non_diabetes,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      LocaleProvider.of(ctxCons).diabetes_type_1,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      LocaleProvider.of(ctxCons).diabetes_type_2,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.current.normal_range,
            value:
                '${val.selectedPerson.rangeMin} - ${val.selectedPerson.rangeMax}',
            onPressed: () => showDialog(
                  context: ctxCons,
                  builder: (context) =>
                      RangeSelectionSlider(val.selectedPerson.id),
                )),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.current.hyper,
            value: val.selectedPerson.hyper,
            onPressed: () => val.showHyperSheet(val
                .getHyperInitialValue()
                .map((e) => Text((e).toString() + " mg/dL."))
                .toList())),
        _settingsPageItem(ctxCons,
            title: LocaleProvider.current.hypo,
            value: val.selectedPerson.hypo,
            onPressed: () => val.showHypoSheet([
                  ...List.generate((val.selectedPerson.rangeMin + 10) ~/ 10,
                      (index) => Text((index * 10).toString() + " mg/dL."))
                ]))
      ],
    );
  }

  Padding _userNameSection(EditProfileVm val, BuildContext ctxCons) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ctxCons.HEIGHT * .05),
      child: Theme(
        data: ThemeData(primaryColor: R.darkBlue),
        child: Material(
          elevation: 15,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            width: 350,
            child: TextFormField(
              controller: val.nameController,
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: LocaleProvider.of(ctxCons).name_and_surname),
              onFieldSubmitted: (_) {
                val.changeName();
              },
              validator: (value) {
                return value.length > 5
                    ? LocaleProvider.of(ctxCons).password_at_least_6
                    : null;
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _sectionHeader(BuildContext ctxCons, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ctxCons.HEIGHT * .02),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w400)),
    );
  }

  Padding _settingsPageItem(BuildContext context,
      {@required String title,
      @required dynamic value,
      @required Function() onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.WIDTH * .05, vertical: context.HEIGHT * .007),
      child: SizedBox(
        height: context.HEIGHT * .07,
        child: RaisedButton(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(color: R.grey)),
                Text('$value', style: TextStyle(color: Colors.black))
              ],
            ),
            color: Colors.white,
            onPressed: onPressed),
      ),
    );
  }

  CircleAvatar _currentPersonAvatar(BuildContext context, Person person) {
    return CircleAvatar(
        backgroundColor: Color(R.backgroundColor.blue),
        child: person?.imageURL == null
            ? person.profileImage.path == ''
                ? SvgPicture.asset(
                    R.image.profile_avatar,
                    fit: BoxFit.cover,
                    color: R.color.dark_blue,
                  )
                : Image(image: FileImage(person.profileImage))
            : person.profileImage.path == ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(context.HEIGHT * .5),
                    child: Image(image: NetworkImage(person.imageURL)),
                  )
                : Image(image: FileImage(person.profileImage)));
  }
}
