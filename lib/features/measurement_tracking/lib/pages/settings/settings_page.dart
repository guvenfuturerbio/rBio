import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/user_profiles/person.dart';
import 'package:onedosehealth/pages/settings/settings_page_vm.dart';
import 'package:onedosehealth/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: R.backgroundColor,
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.profile),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      body: ChangeNotifierProvider(
        create: (context) => SettingPageVm(mContext: context),
        child: Consumer<SettingPageVm>(
          builder: (ctxCons, val, child) => val.isLoading
              ? Container()
              : Column(
                  children: [
                    Expanded(child: _personInfo(context, val)),
                    Expanded(flex: 2, child: _actions(context, val)),
                  ],
                ),
        ),
      ),
    );
  }

  Column _personInfo(BuildContext context, SettingPageVm val) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: context.HEIGHT * .1,
                  width: context.HEIGHT * .1,
                  child: _currentPersonAvatar(val.personList[0]))

              //WARNING: thissection enabled when multiprofile activated
              /*  ...val.personList
                                  .map((person) => SizedBox(
                                      height: context.HEIGHT * .2,
                                      width: context.WIDTH * .2,
                                      child: _currentPersonAvatar(person)))
                                  .toList(),*/
            ],
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _selectedPersonInfoSection(context, val),
          ),
        ),
      ],
    );
  }

  Column _actions(BuildContext context, SettingPageVm val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(context,
            title: LocaleProvider.current.edit_profile,
            onTap: () =>
                Navigator.pushNamed(context, Routes.EDIT_PROFILE_PAGE)),
        _button(context,
            title: LocaleProvider.current.logout, onTap: () => val.logOut()),

        /// MGH4
        DropdownButton<Locale>(
          hint: Text(LocaleProvider.current.select_language +
              ": " +
              Intl.getCurrentLocale().toUpperCase()),
          items: LocaleProvider.delegate.supportedLocales.map((Locale value) {
            return new DropdownMenuItem<Locale>(
              value: value,
              child: new Text(value.languageCode.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            val.changeCountryCode(value.languageCode);
          },
        )
      ],
    );
  }

  ElevatedButton _button(BuildContext context, {String title, Function onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: context.HEIGHT * 0.01),
          animationDuration: Duration(milliseconds: 50),
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.HEIGHT * .2))),
      child: Container(
        decoration: onTap == null
            ? null
            : BoxDecoration(
                gradient: BlueGradient(),
                borderRadius: BorderRadius.circular(context.HEIGHT * .2)),
        child: SizedBox(
          width: context.WIDTH * .7,
          height: context.HEIGHT * .05,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$title',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _selectedPersonInfoSection(BuildContext context, SettingPageVm val) {
    return SizedBox(
      height: context.HEIGHT * .05,
      width: context.WIDTH * .8,
      child: Material(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentPersonAvatar(val.selectedPerson),
            Expanded(
              child: Text(val.selectedPerson.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  CircleAvatar _currentPersonAvatar(Person person) {
    return CircleAvatar(
        backgroundColor: Color(R.backgroundColor.blue),
        child: person.imageURL == null
            ? SvgPicture.asset(
                R.image.profile_avatar,
                fit: BoxFit.cover,
                color: R.color.dark_blue,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(context.HEIGHT * .5),
                child: Image(image: NetworkImage(person.imageURL)),
              ));
  }
}
