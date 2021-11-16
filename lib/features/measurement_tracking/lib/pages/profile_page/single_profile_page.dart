import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/user_profiles/person.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/notifiers/user_profiles_notifier.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils/base_provider_repository.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onedosehealth/main.dart';

class ProfilesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilesPage();
}

class _ProfilesPage extends State<ProfilesPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    fetchImages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Future<void> didPopNext() async {
    print("didPopNext");
    fetchImages();
    super.didPopNext();
  }

  fetchImages() async {
    for (Person p in UserProfilesNotifier().profiles.person) {
      File file =
          await BaseProviderRepository().getProfilePictureOfProfile(p.id);
      p.profileImage = file ?? new File("");
      if (p.id == UserProfilesNotifier().selection.id) {
        UserProfilesNotifier().selection.profileImage = file;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          context: context,
          title: TitleAppBarWhite(title: LocaleProvider.current.profile),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      body: SingleChildScrollView(
        child: Consumer<UserProfilesNotifier>(
          builder: (BuildContext context, userProfilesNotifier, _) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  getPersonView(context, userProfilesNotifier.selection),

                  /*Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(children: [
                                  RawMaterialButton(
                                    onPressed: () {
                                      UtilityManager().showConfirmationAlertDialog(
                                          context,
                                          LocaleProvider.current.warning,
                                          LocaleProvider.current.new_profile_addition,
                                          FlatButton(
                                            child: Text(LocaleProvider.current.Ok),
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              userProfilesNotifier.addProfile(
                                                  new Person().fromDefault());
                                            },
                                          ));

                                    },
                                    elevation: 2.0,
                                    fillColor: Colors.white,
                                    child: SvgPicture.asset(
                                      R.image.add_icon_grey,
                                      height: 50,
                                      width: 50,
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                  ),
                                ]),
                              ),
                            )*/

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 50,
                      width: 300,
                      child: Material(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 2),
                                child: CustomCircleAvatar(
                                    child: userProfilesNotifier
                                                .selection.profileImage?.path ==
                                            ""
                                        ? SvgPicture.asset(
                                            R.image.profile_avatar,
                                            fit: BoxFit.cover,
                                            color: R.btnDarkBlue,
                                          )
                                        : PhotoView(
                                            imageProvider: FileImage(
                                                userProfilesNotifier.selection
                                                        .profileImage ??
                                                    new File(
                                                        userProfilesNotifier
                                                                .selection
                                                                .profileImage
                                                                ?.path ??
                                                            "")),
                                          )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  userProfilesNotifier.selection.name ?? "",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
                      ),
                    ),
                    child: RaisedButton(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            R.image.edit_icon,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(LocaleProvider.current.edit,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.EDIT_PROFILE_PAGE);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: <Color>[R.btnLightBlue, R.btnDarkBlue],
                      ),
                    ),
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            R.image.logout_icon,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(LocaleProvider.current.logout,
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        userProfilesNotifier.logout(
                            userProfilesNotifier.selection, context);
                      },
                    ),
                  ),
                  DropdownButton<Locale>(
                    hint: Text(LocaleProvider.current.select_language +
                        ": " +
                        Intl.getCurrentLocale()),
                    items: LocaleProvider.delegate.supportedLocales
                        .map((Locale value) {
                      return new DropdownMenuItem<Locale>(
                        value: value,
                        child: new Text(value.languageCode.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      changeCountryCode(value.languageCode);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // LOCALE CHANGER
  /*void loadLocaleIfStored() async {
    if (!isLocaleChecked) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String current = prefs.getString("kSelectedLocale");
      if (current != null) {
        print('Current locale = $current.');
        changeCountryCode(current);
        currentLocale = current.toUpperCase();
      } else {
        currentLocale = Intl.getCurrentLocale().toLowerCase();
        changeCountryCode(currentLocale);
      }
      isLocaleChecked = true;
    }
  }*/

  void changeCountryCode(String locale) async {
    print("CHANGING LOCALE TO " + locale);
    if (LocaleProvider.delegate.isSupported(Locale(locale.toLowerCase()))) {
      LocaleProvider lp =
          await LocaleProvider.delegate.load(Locale(locale.toLowerCase()));
      print("OLD lp: ${LocaleProvider.current.toString()}");
      print("NEW lp: ${lp.toString()}");
      LocaleProvider.current = lp;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('kSelectedLocale', locale.toLowerCase());
      setState(() {});
    }
  }

  Widget getPersonView(BuildContext context, Person currentPerson) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            UserProfilesNotifier().changeActiveProfile(currentPerson);
          },
          child: CustomCircleAvatar(
              size: currentPerson.id == UserProfilesNotifier().selection.id
                  ? 100
                  : 70,
              child: currentPerson.profileImage?.path == ""
                  ? SvgPicture.asset(
                      R.image.profile_avatar,
                      fit: BoxFit.cover,
                      color: R.btnDarkBlue,
                    )
                  : PhotoView(
                      imageProvider: FileImage(currentPerson.profileImage ??
                          new File(currentPerson.profileImage?.path ?? "")),
                    )),
        ),
      ),
    );
  }

  /*Widget getOldPersonView(BuildContext context, Person currentPerson) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Stack(children: [
        Container(
          height: 90,
          width: 90,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              userProfilesNotifier.changeSelection(
                  currentPerson);
            },
            child: userProfilesNotifier
                .profiles.active == currentPerson
                ? userProfilesNotifier.selection == currentPerson
                ? CircleAvatar(
                backgroundColor:
                R.darkGreen,
                radius: 45,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  NetworkImage(
                    currentPerson
                        .imageURL,
                  ),
                ))
                : CircleAvatar(
                backgroundColor:
                R.darkGreen,
                radius: 40,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage:
                  NetworkImage(
                    userProfilesNotifier
                        .profiles
                        .person[index]
                        .imageURL,
                  ),
                ))
                : userProfilesNotifier.selection ==
                userProfilesNotifier
                    .profiles.person[index]
                ? CircleAvatar(
              radius: 40,
              backgroundImage:
              NetworkImage(
                userProfilesNotifier
                    .profiles
                    .person[index]
                    .imageURL,
              ),
            )
                : CircleAvatar(
              radius: 35,
              backgroundImage:
              NetworkImage(
                userProfilesNotifier
                    .profiles
                    .person[index]
                    .imageURL,
              ),
            ),
          ),
        )
      ]),
    );
  }*/
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
