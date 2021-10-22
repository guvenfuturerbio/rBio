import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../../core/utils/user_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: kIsWeb
          ? Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width < 800
                      ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width < 800
                      ? MediaQuery.of(context).size.width * 0.03
                      : MediaQuery.of(context).size.width * 0.10),
              child: _buildBody(context))
          : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) => Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  LocaleProvider.of(context).lbl_hello +
                      " " +
                      getIt<UserInfo>().getUserAccount().name +
                      " " +
                      getIt<UserInfo>().getUserAccount().surname,
                  style: TextStyle(
                    color: R.color.black,
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
                    color: R.color.gray,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
              ),

              //
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: InkWell(
                  child: _ItemFindHospital(
                      title: LocaleProvider.of(context).online_appo,
                      image: R.image.ic_video_icon,
                      number: LocaleProvider.of(context).title_appointment,
                      colorLeft: R.color.online_appointment,
                      colorRight: R.color.light_online_appointment,
                      margin: EdgeInsets.only(top: 10)),
                  onTap: () {
                    AnalyticsManager().sendEvent(OnlineAppointmentClickEvent());
                    Atom.to(
                      PagePaths.DEPARTMENTS,
                      queryParameters: {
                        'tenantId': 1.toString(),
                        'fromOnlineSelection': true.toString(),
                      },
                    );
                  },
                ),
              ),

              //
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: InkWell(
                  child: _ItemFindHospital(
                      title: LocaleProvider.of(context).lbl_find_hospital,
                      image: R.image.ic_hospital_white,
                      colorLeft: R.color.blue,
                      colorRight: R.color.light_blue,
                      number: LocaleProvider.of(context).lbl_number_hospital,
                      margin: EdgeInsets.only(top: 10)),
                  onTap: () {
                    AnalyticsManager().sendEvent(FindDoctorClickEvent());
                    Atom.to(PagePaths.HOSPITALS);
                  },
                ),
              ),

              //
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                child: InkWell(
                  child: _ItemFindHospital(
                      title: LocaleProvider.of(context)
                          .free_consultation_appointment,
                      image: R.image.danisma_icon,
                      number: LocaleProvider.of(context)
                          .free_consultation_appointment,
                      colorLeft: R.color.danisma,
                      colorRight: R.color.danisma_light,
                      margin: EdgeInsets.only(top: 10)),
                  onTap: () {
                    Atom.to(
                      PagePaths.RESOURCES,
                      queryParameters: {
                        'tenantId': '1',
                        ' fromOnline': 'true',
                        'departmentName': Uri.encodeFull(LocaleProvider
                            .current.free_consultation_appointment),
                        'departmentId': '132'
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
      );

  Widget optionsWidget(BuildContext context) => Table(
        children: [
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                title: LocaleProvider.of(context).for_you,
                image: R.image.for_you,
                number: LocaleProvider.of(context).lbl_number_doctor,
                margin: EdgeInsetsDirectional.only(end: 10, bottom: 10),
                isFocused: false,
              ),
              onTap: () {
                AnalyticsManager().sendEvent(ForYouPageClickEvent());
                Atom.to(PagePaths.FOR_YOU_CATEGORIES);
              },
            ),
            InkWell(
              child: _ItemOption(
                  title: LocaleProvider.of(context).request_and_suggestions,
                  image: R.image.ic_edit_white,
                  number: LocaleProvider.of(context).lbl_number_doctor,
                  margin: EdgeInsetsDirectional.only(start: 10, bottom: 10)),
              onTap: () {
                AnalyticsManager().sendEvent(FindDoctorClickEvent());
                Atom.to(PagePaths.REQUEST_SUGGESTION);
              },
            )
          ]),
          TableRow(children: [
            InkWell(
              child: _ItemOption(
                  title: LocaleProvider.of(context).my_appointments,
                  image: R.image.ic_appointment_white,
                  number: LocaleProvider.of(context).lbl_number_appointment,
                  margin: EdgeInsetsDirectional.only(
                    end: 10,
                  )),
              onTap: () {
                AnalyticsManager().sendEvent(MyAppointmentsClickEvent());
                Atom.to(PagePaths.APPOINTMENTS);
              },
            ),
            InkWell(
              child: _ItemOption(
                  title: LocaleProvider.of(context).results,
                  image: R.image.ic_price_services,
                  number: LocaleProvider.of(context).lbl_number_services,
                  margin: EdgeInsetsDirectional.only(start: 10)),
              onTap: () {
                AnalyticsManager().sendEvent(MyResultsClickEvent());
                Atom.to(PagePaths.ERESULT);
              },
            ),
          ]),
          TableRow(children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            )
          ]),
        ],
      );

  @override
  bool get wantKeepAlive => true;
}

Widget _ItemOption(
        {String title,
        String image,
        String number,
        bool isFocused = false,
        EdgeInsetsDirectional margin}) =>
    Container(
      height: 100,
      margin: margin,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 18),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                  image,
                  height: 100,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          /*Container(
            child: Text(number,
                style:
                    TextStyle(color: Colors.white.withAlpha(50), fontSize: 14)),
          )*/
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              colors: isFocused
                  ? [
                      R.color.blue,
                      R.color.light_blue,
                    ]
                  : [
                      R.color.gray,
                      R.color.grey,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );

Widget _ItemOnlineAppo(
        {String title,
        String image,
        String number,
        bool isFocused = false,
        EdgeInsets margin}) =>
    Container(
      height: 100,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          /*Container(
            child: Text(number,
                style:
                    TextStyle(color: Colors.white.withAlpha(50), fontSize: 14)),
          )*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 18.0),
              child: Container(
                child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                    )),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            R.color.online_appointment,
            R.color.light_online_appointment,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );

Widget _ItemFindHospital(
        {String title,
        String image,
        String number,
        bool isFocused = false,
        Color colorLeft,
        Color colorRight,
        EdgeInsets margin}) =>
    Container(
      height: 100,
      margin: margin,
      padding: EdgeInsets.only(
        left: 15,
        top: 15,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          /*Container(
            child: Text(number,
                style:
                    TextStyle(color: Colors.white.withAlpha(50), fontSize: 14)),
          )*/
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 80,
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Opacity(
                    opacity: 0.5,
                    child: SvgPicture.asset(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                    )),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(colors: [
            colorLeft,
            colorRight,
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: R.color.dark_black.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(5, 10))
          ]),
    );
