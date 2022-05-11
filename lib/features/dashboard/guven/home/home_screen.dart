import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class GuvenHomeScreen extends StatefulWidget {
  const GuvenHomeScreen({Key? key}) : super(key: key);

  @override
  _GuvenHomeScreenState createState() => _GuvenHomeScreenState();
}

class _GuvenHomeScreenState extends State<GuvenHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) => Scaffold(
        appBar: RbioAppBar(
          leading: const SizedBox(),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    LocaleProvider.of(context).lbl_hello +
                        " " +
                        Utils.instance.getCurrentUserNameAndSurname,
                    style: TextStyle(
                      color: getIt<IAppConfig>().theme.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),

                //
                Container(
                  child: Text(
                    LocaleProvider.of(context).lbl_take_care,
                    style: TextStyle(
                      color: getIt<IAppConfig>().theme.gray,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      Atom.to(
                        PagePaths.createAppointment,
                        queryParameters: {
                          'forOnline': true.toString(),
                          'fromSearch': false.toString(),
                          'fromSymptom': false.toString(),
                        },
                      );
                    },
                    child: _itemFindHospital(
                      title: LocaleProvider.of(context).online_appo,
                      image: R.image.icVideoIcon,
                      number: LocaleProvider.of(context).title_appointment,
                      colorLeft: getIt<IAppConfig>().theme.onlineAppointment,
                      colorRight:
                          getIt<IAppConfig>().theme.lightOnlineAppointment,
                      margin: const EdgeInsets.only(top: 10),
                    ),
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: InkWell(
                    child: _itemFindHospital(
                        title: LocaleProvider.of(context).lbl_find_hospital,
                        image: R.image.icHospitalWhite,
                        colorLeft: getIt<IAppConfig>().theme.red,
                        colorRight: getIt<IAppConfig>().theme.lightRed,
                        number: LocaleProvider.of(context).lbl_number_hospital,
                        margin: const EdgeInsets.only(top: 10)),
                    onTap: () {
                      getIt<FirebaseAnalyticsManager>().logEvent(
                          MenuElementTiklamaEvent('hastane_randevusu_olustur'));
                      Atom.to(
                        PagePaths.createAppointment,
                        queryParameters: {
                          'forOnline': false.toString(),
                          'fromSearch': false.toString(),
                          'fromSymptom': false.toString(),
                        },
                      );
                    },
                  ),
                ),

                //
                optionsWidget(context),
              ],
            ),
          ),
        ),
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          //
          TableRow(
            children: [
              InkWell(
                child: _itemOption(
                  title: LocaleProvider.of(context).for_you,
                  image: R.image.forYou,
                  number: LocaleProvider.of(context).lbl_number_doctor,
                  margin: const EdgeInsetsDirectional.only(
                      top: 10, end: 10, bottom: 10),
                  isFocused: false,
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('size_ozel'));
                  Atom.to(PagePaths.forYouCategories);
                },
              ),
              InkWell(
                child: _itemOption(
                    title: LocaleProvider.of(context).request_and_suggestions,
                    image: R.image.icEditWhite,
                    number: LocaleProvider.of(context).lbl_number_doctor,
                    margin: const EdgeInsetsDirectional.only(
                        top: 10, start: 10, bottom: 10)),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('oneriler'));
                  Atom.to(PagePaths.suggestResult);
                },
              ),
            ],
          ),

          //
          TableRow(
            children: [
              InkWell(
                child: _itemOption(
                  title: LocaleProvider.of(context).my_appointments,
                  image: R.image.icAppointmentWhite,
                  number: LocaleProvider.of(context).lbl_number_appointment,
                  margin: const EdgeInsetsDirectional.only(
                    end: 10,
                  ),
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('randevu'));
                  Atom.to(PagePaths.appointment);
                },
              ),
              InkWell(
                child: _itemOption(
                  title: LocaleProvider.of(context).results,
                  image: R.image.icPriceServices,
                  number: LocaleProvider.of(context).lbl_number_services,
                  margin: const EdgeInsetsDirectional.only(start: 10),
                ),
                onTap: () {
                  getIt<FirebaseAnalyticsManager>()
                      .logEvent(MenuElementTiklamaEvent('sonuclar'));
                  Atom.to(PagePaths.eResult);
                },
              ),
            ],
          ),

          //
          const TableRow(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      );

  bool get wantKeepAlive => true;
}

Widget _itemOption({
  required String title,
  required String image,
  required String number,
  bool isFocused = false,
  required EdgeInsetsDirectional margin,
}) =>
    Container(
      height: 100,
      margin: margin,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: getIt<IAppConfig>().theme.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: 0.5,
                child: SvgPicture.asset(
                  image,
                  width: 60,
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          colors: isFocused
              ? [
                  getIt<IAppConfig>().theme.red,
                  getIt<IAppConfig>().theme.lightRed,
                ]
              : [
                  getIt<IAppConfig>().theme.gray,
                  getIt<IAppConfig>().theme.grey,
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(5, 10),
          ),
        ],
      ),
    );

Widget _itemFindHospital({
  required String title,
  required String image,
  required String number,
  required Color colorLeft,
  required Color colorRight,
  required EdgeInsets margin,
}) {
  return Container(
    height: 100,
    margin: margin,
    padding: const EdgeInsets.only(
      left: 15,
      top: 15,
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: getIt<IAppConfig>().theme.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 0,
              ),
            ),
          ),

          //
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.5,
              child: SvgPicture.asset(
                image,
                width: 80,
              ),
            ),
          ),
        ],
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      gradient: LinearGradient(
        colors: [
          colorLeft,
          colorRight,
        ],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
      boxShadow: [
        BoxShadow(
          color: getIt<IAppConfig>().theme.darkBlack.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: const Offset(5, 10),
        ),
      ],
    ),
  );
}
