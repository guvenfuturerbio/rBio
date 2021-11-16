import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/user_profiles/user_profiles.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../main.dart';
import '../../models/user_profiles/person.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../../widgets/utils.dart';
import '../../widgets/utils/base_provider_repository.dart';
import 'profile_picture_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Future<void> didPopNext() async {
    fetchImages();
    super.didPopNext();
  }

  fetchImages() async {
    for (Person p in UserProfilesNotifier().profiles.person) {
      File file =
          await BaseProviderRepository().getProfilePictureOfProfile(p.id);
      setState(() {
        p.profileImage = file ?? new File("");
        if (p.id == UserProfilesNotifier().selection.id) {
          UserProfilesNotifier().selection.profileImage = file;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    int genderselect = 1;
    var birthdateselection;
    var selectedheight;
    var selectedtype;
    var selectedweight;
    var selectedhypo;
    var selectedhyper;
    var selectedYear = 0;
    var selectedSmoker = 0;
    return Scaffold(
        appBar: MainAppBar(
            context: context,
            title: TitleAppBarWhite(title: LocaleProvider.current.edit_profile),
            leading: InkWell(
                child: SvgPicture.asset(R.image.back_icon),
                onTap: () => Navigator.of(context).pop())),
        body: SingleChildScrollView(child: Consumer<UserProfilesNotifier>(
            builder: (BuildContext context, userProfilesNotifier, _) {
          print(UserProfiles().active.profileImage.path);
          return Center(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileImageViewerScreen(
                        UserProfilesNotifier().selection.profileImage?.path,
                        LocaleProvider.current.profile_picture_name),
                    settings: RouteSettings(name: 'ProfileImageViewerScreen'),
                  ),
                );
              },
              child: CustomCircleAvatar(
                  size: 80,
                  child: UserProfilesNotifier().selection.imageURL == null
                      ? UserProfilesNotifier().selection.profileImage?.path ==
                              ""
                          ? SvgPicture.asset(
                              R.image.profile_avatar,
                              fit: BoxFit.cover,
                              color: R.btnDarkBlue,
                            )
                          : Image(
                              image: FileImage(UserProfilesNotifier()
                                      .selection
                                      .profileImage ??
                                  new File(UserProfilesNotifier()
                                          .selection
                                          .profileImage
                                          ?.path ??
                                      "")),
                            )
                      : UserProfilesNotifier().selection.profileImage?.path !=
                              ""
                          ? Image(
                              image: FileImage(UserProfilesNotifier()
                                      .selection
                                      .profileImage ??
                                  new File(UserProfilesNotifier()
                                          .selection
                                          .profileImage
                                          ?.path ??
                                      "")),
                            )
                          : Image(
                              image: NetworkImage(
                                  UserProfilesNotifier().selection.imageURL))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                      initialValue: userProfilesNotifier.selection.name ?? "",
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
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: LocaleProvider.current.name_and_surname),
                      onFieldSubmitted: (String value) {
                        userProfilesNotifier.changeName(value);
                      },
                      validator: (value) {
                        return value.length > 5
                            ? LocaleProvider.current.password_at_least_6
                            : null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(LocaleProvider.current.demographic,
                      style: TextStyle(fontWeight: FontWeight.w400))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.gender,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.gender ??
                                LocaleProvider.current.unspecified,
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      genderselect = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  print(
                                                      "Selected Gender is $genderselect");
                                                  if (genderselect == 1) {
                                                    userProfilesNotifier
                                                        .changeGender(
                                                            "Male"); // LocaleProvider.current.male
                                                  } else if (genderselect ==
                                                      2) {
                                                    userProfilesNotifier
                                                        .changeGender(
                                                            "Female"); // LocaleProvider.current.female
                                                  } else {
                                                    userProfilesNotifier
                                                        .changeGender(
                                                            "Other"); // LocaleProvider.current.unspecified
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: (userProfilesNotifier
                                                              .selection
                                                              .gender ==
                                                          null ||
                                                      userProfilesNotifier
                                                              .selection
                                                              .gender ==
                                                          "Other")
                                                  ? 0
                                                  : userProfilesNotifier
                                                              .selection
                                                              .gender ==
                                                          LocaleProvider.of(
                                                                  context)
                                                              .male
                                                      ? 1
                                                      : 2),
                                      backgroundColor: Colors.grey[400],
                                      onSelectedItemChanged: (value) {
                                        if (value == null) {
                                          genderselect = userProfilesNotifier
                                                      .selection.gender ==
                                                  null
                                              ? 0
                                              : userProfilesNotifier
                                                          .selection.gender ==
                                                      LocaleProvider
                                                          .current.male
                                                  ? 1
                                                  : 2;
                                        } else
                                          genderselect = value;
                                      },
                                      itemExtent: 50.0,
                                      children: [
                                        Text(
                                          LocaleProvider.current.other,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          LocaleProvider.current.male,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          LocaleProvider.current.female,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.age,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.birthDate ??
                                LocaleProvider.current.unspecified,
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      birthdateselection = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  birthdateselection ??=
                                                      DateTime.now();
                                                  //print(birthdateselection);
                                                  userProfilesNotifier
                                                      .changeBirthdate(
                                                          birthdateselection
                                                              .toString()
                                                              .substring(
                                                                  0, 10));

                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 300,
                                      child: CupertinoDatePicker(
                                        initialDateTime: UserProfilesNotifier()
                                                .getDateFromStringddMMyyyy() ??
                                            DateTime.now(),
                                        onDateTimeChanged: (DateTime newdate) {
                                          birthdateselection =
                                              DateFormat("dd.MM.yyyy")
                                                  .format(newdate);
                                        },
                                        use24hFormat: true,
                                        maximumDate: DateTime.now(),
                                        minimumYear: 1920,
                                        maximumYear: DateTime.now().year,
                                        minuteInterval: 1,
                                        mode: CupertinoDatePickerMode.date,
                                      )),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.height,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.height == null
                                ? LocaleProvider.current.unspecified
                                : userProfilesNotifier.selection.height +
                                    " cm.",
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedheight = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  selectedheight ??= 70;
                                                  print(
                                                      "Selected height is ${selectedheight}");
                                                  userProfilesNotifier
                                                      .changeHeight(
                                                          (selectedheight)
                                                              .toString());
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: int.parse(
                                                      UserProfilesNotifier()
                                                          .selection
                                                          .height) ??
                                                  70),
                                      backgroundColor: Colors.grey[400],
                                      onSelectedItemChanged: (value) {
                                        selectedheight = value;
                                      },
                                      itemExtent: 50.0,
                                      children: userProfilesNotifier
                                          .heightParameters(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.weight,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.weight == null
                                ? LocaleProvider.current.unspecified
                                : userProfilesNotifier.selection.weight +
                                    " kg.",
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedweight = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: ListView(
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  selectedweight ??= 50;
                                                  print(
                                                      "Selected weight $selectedweight");
                                                  userProfilesNotifier
                                                      .changeWeight(
                                                          (selectedweight)
                                                              .toString());
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem: int.parse(
                                                        UserProfilesNotifier()
                                                            .selection
                                                            .weight) ??
                                                    50),
                                        backgroundColor: Colors.grey[400],
                                        onSelectedItemChanged: (value) {
                                          selectedweight = value;
                                        },
                                        itemExtent: 50.0,
                                        children: userProfilesNotifier
                                            .weightParameters()),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 18.0, bottom: 8),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(LocaleProvider.current.details,
                      style: TextStyle(fontWeight: FontWeight.w400))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.year_of_diagnosis,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.yearOfDiagnosis ==
                                    null
                                ? LocaleProvider.current.unspecified
                                : userProfilesNotifier.selection.yearOfDiagnosis
                                    .toString(),
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedweight = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  print(selectedYear);
                                                  selectedYear ??=
                                                      DateTime.now().year;
                                                  userProfilesNotifier
                                                      .changeSelectedYear(
                                                          (userProfilesNotifier
                                                                      .years100[
                                                                  selectedYear])
                                                              .toString());
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem:
                                                    DateTime.now().year -
                                                        UserProfilesNotifier()
                                                            .selection
                                                            .yearOfDiagnosis),
                                        backgroundColor: Colors.grey[400],
                                        onSelectedItemChanged: (value) {
                                          selectedYear = value;
                                        },
                                        itemExtent: 50.0,
                                        children: userProfilesNotifier
                                            .yearParameters()),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.smoker_type,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.smoker == null
                                ? LocaleProvider.current.unspecified
                                : userProfilesNotifier.selection.smoker
                                    ? LocaleProvider.current.smoker
                                    : LocaleProvider.current.non_smoker,
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  selectedSmoker ??= 0;
                                                  if (selectedSmoker == 0) {
                                                    userProfilesNotifier
                                                        .changeSelectedSmoker(
                                                            LocaleProvider.of(
                                                                    context)
                                                                .non_smoker);
                                                  } else if (selectedSmoker ==
                                                      1) {
                                                    userProfilesNotifier
                                                        .changeSelectedSmoker(
                                                            LocaleProvider.of(
                                                                    context)
                                                                .smoker);
                                                  } else {
                                                    userProfilesNotifier
                                                        .changeSelectedSmoker(
                                                            LocaleProvider
                                                                .current
                                                                .non_smoker);
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem:
                                                  UserProfilesNotifier()
                                                          .selection
                                                          .smoker
                                                      ? 1
                                                      : 0),
                                      backgroundColor: Colors.grey[400],
                                      onSelectedItemChanged: (value) {
                                        selectedSmoker = value;
                                        userProfilesNotifier
                                            .changeSelectedSmoker(
                                                selectedSmoker);
                                      },
                                      itemExtent: 50.0,
                                      children: [
                                        Text(
                                          LocaleProvider.current.non_smoker,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          LocaleProvider.current.smoker,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.diabetes_type,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.diabetesType == null
                                ? LocaleProvider.current.unspecified
                                : userProfilesNotifier.selection.diabetesType,
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedtype = null;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 340,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.cancel)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  selectedtype ??= 0;
                                                  if (selectedtype == 0) {
                                                    userProfilesNotifier
                                                        .changeDiabetesType(
                                                            "Other"); // LocaleProvider.current.non_diabetes
                                                  }
                                                  if (selectedtype == 1) {
                                                    userProfilesNotifier
                                                        .changeDiabetesType(
                                                            "Type 1"); // LocaleProvider.current.diabetes_type_1
                                                  }
                                                  if (selectedtype == 2) {
                                                    userProfilesNotifier
                                                        .changeDiabetesType(
                                                            "Type 2"); // LocaleProvider.current.diabetes_type_2
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text(LocaleProvider
                                                    .current.pick)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                      scrollController:
                                          FixedExtentScrollController(
                                              initialItem: UserProfilesNotifier()
                                                          .selection
                                                          .diabetesType ==
                                                      "Type 1"
                                                  ? 1
                                                  : (UserProfilesNotifier()
                                                              .selection
                                                              .diabetesType ==
                                                          "Type 2"
                                                      ? 2
                                                      : 0)),
                                      backgroundColor: Colors.grey[400],
                                      onSelectedItemChanged: (value) {
                                        selectedtype = value;
                                      },
                                      itemExtent: 50.0,
                                      children: [
                                        Text(
                                          LocaleProvider.current.other,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          LocaleProvider
                                              .current.diabetes_type_1,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          LocaleProvider
                                              .current.diabetes_type_2,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.normal_range,
                            style: TextStyle(color: R.grey)),
                        Text(
                            userProfilesNotifier.selection.rangeMin
                                    .round()
                                    .toString() +
                                "-" +
                                userProfilesNotifier.selection.rangeMax
                                    .round()
                                    .toString() +
                                "mg/dL",
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      /* showDialog(
                          context: context,
                          builder: (_) => RangeSelectionSlider()); */
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.hyper,
                            style: TextStyle(color: R.grey)),
                        Text(userProfilesNotifier.selection.hyper.toString(),
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedhyper = null;
                      showDialog(
                          context: context,
                          builder: (BuildContext builder) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem:
                                                    userProfilesNotifier
                                                        .hyperParametersAsInt()
                                                        .indexOf(
                                                            userProfilesNotifier
                                                                .selection
                                                                .hyper)),
                                        backgroundColor: Colors.white,
                                        onSelectedItemChanged: (value) {
                                          selectedhyper = userProfilesNotifier
                                              .hyperParametersAsInt()[value];
                                        },
                                        itemExtent: 50.0,
                                        children: userProfilesNotifier
                                            .hyperParameters()),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 16.0, bottom: 16.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: R.color.defaultBlue,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32.0),
                                            bottomRight: Radius.circular(32.0)),
                                      ),
                                      child: Text(
                                        LocaleProvider.current.save,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    onTap: () {
                                      selectedhyper ??= 180;
                                      print("Selected hyper $selectedhyper");
                                      userProfilesNotifier
                                          .changeHyper(selectedhyper);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Container(
                height: 50,
                width: 350,
                child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleProvider.current.hypo,
                            style: TextStyle(color: R.grey)),
                        Text(userProfilesNotifier.selection.hypo.toString(),
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    color: Colors.white,
                    onPressed: () {
                      selectedhypo = null;
                      showDialog(
                          context: context,
                          builder: (BuildContext builder) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 300,
                                    child: CupertinoPicker(
                                        scrollController:
                                            FixedExtentScrollController(
                                                initialItem:
                                                    (UserProfilesNotifier()
                                                            .selection
                                                            .hypo ~/
                                                        10)),
                                        backgroundColor: Colors.white,
                                        onSelectedItemChanged: (value) {
                                          selectedhypo = value;
                                        },
                                        itemExtent: 50.0,
                                        children: userProfilesNotifier
                                            .hypoParameters()),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 16.0, bottom: 16.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: R.color.defaultBlue,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(32.0),
                                            bottomRight: Radius.circular(32.0)),
                                      ),
                                      child: Text(
                                        LocaleProvider.current.save,
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    onTap: () {
                                      selectedhyper ??= 180;
                                      print("Selected hypo $selectedhypo");
                                      userProfilesNotifier
                                          .changeHypo(selectedhypo * 10);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ),
          ]));
        })));
  }
}

Widget CustomCircleAvatar(
        {double size = 50, Widget child, BoxDecoration decoration}) =>
    Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: child,
      ),
      decoration: decoration,
    );
