import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../chronic_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import '../../utils/bg_measurement_list.dart';
import '../../utils/graph_header_section.dart';
import '../../utils/hypo_hyper_edit/hypo_hyper_edit_view_model.dart';
import '../../utils/widgets.dart';
import '../chat/chat_controller.dart';
import '../chat/chat_window.dart';
import 'patient_detail_page_view_model.dart';

class PatientDetailPage extends StatefulWidget {
  @override
  _PatientDetailPageState createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  ScrollController _controller = ScrollController();

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientDetailPageViewModel>(
      builder: (context, value, child) {
        return DropdownBanner(
          navigatorKey: _navigatorKey,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(
                  preferredSize: Size.fromHeight(context.HEIGHT * .18),
                  title: titleAppBarWhite(
                      title: value.patientDetail == null
                          ? ""
                          : value.patientDetail.name),
                  leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(R.image.back)),
                  actions: [
                    InkWell(
                      child: Icon(Icons.chat, color: Colors.white),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider<
                                        DoctorChatController>(
                                    create: (context) => DoctorChatController(),
                                    child: DoctorChatWindow(
                                        value.patientid.toString(),
                                        value.patientDetail.name))));
                      },
                    )
                  ]),
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: context.HEIGHT * .18,
                    ),
                    value.stateProcessPatientDetail == StateProcess.LOADING
                        ? Shimmer.fromColors(
                            child: patientDetail(
                                context: context,
                                targetRangePresses: () {},
                                hyperEdit: () {}),
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100])
                        : patientDetail(
                            context: context,
                            patientDetail: value.patientDetail,
                            targetRangePresses: () {
                              value.showNormalRangeEdit();
                            },
                            hypoEdit: () {
                              value.showHypoEdit();
                            },
                            hyperEdit: () {
                              value.showHyperEdit();
                            }),
                    if (!value.isDataLoading) ...{
                      BgGraphHeaderSection(
                          value: value, controller: _controller),
                      SizedBox(
                        height: context.HEIGHT * .3,
                        child: BgMeasurementListWidget(
                          bgMeasurements: value.bgMeasurements,
                          scrollController: _controller,
                          useStickyGroupSeparatorsValue:
                              value.selected == LocaleProvider.current.daily ||
                                      value.selected ==
                                          LocaleProvider.current.specific
                                  ? true
                                  : false,
                        ),
                      ),
                    } else ...{
                      Shimmer.fromColors(
                          child: patientDetail(
                              context: context,
                              targetRangePresses: () {},
                              hyperEdit: () {}),
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100])
                    }
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget patientDetail({
    BuildContext context,
    DoctorPatientDetailModel patientDetail,
    Function targetRangePresses,
    Function hypoEdit,
    Function hyperEdit,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.current.name_surname,
                                style: TextStyle(
                                    color: R.color.title, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.date_of_birth,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                patientDetail?.name ?? "-",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              patientDetail?.birthDay ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.current.identity_passport,
                                style: TextStyle(
                                    color: R.color.title, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.height,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              patientDetail?.height ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.current.diabet_type,
                                style: TextStyle(
                                    color: R.color.title, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.weight,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                patientDetail?.diabetType?.name ?? "-",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              patientDetail?.weight ?? "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    LocaleProvider.current.normal_range,
                                    style: TextStyle(
                                        color: R.color.title, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      targetRangePresses();
                                    },
                                    child: SvgPicture.asset(
                                      R.image.other,
                                      color: R.color.mainColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.last_hba1c,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                (patientDetail?.rangeMin ?? "").toString() +
                                    "-" +
                                    (patientDetail?.rangeMax ?? "").toString() +
                                    (" mg/dL"),
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    LocaleProvider.current.hypo,
                                    style: TextStyle(
                                        color: R.color.title, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      hypoEdit();
                                    },
                                    child: SvgPicture.asset(
                                      R.image.other,
                                      color: R.color.mainColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.year_of_diagnosis,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                (patientDetail?.hypo ?? "-").toString() +
                                    " mg/dL",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              (patientDetail?.yearOfDiagnosis ?? "-")
                                  .toString(),
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    LocaleProvider.current.hyper,
                                    style: TextStyle(
                                        color: R.color.title, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      hyperEdit();
                                    },
                                    child: SvgPicture.asset(
                                      R.image.other,
                                      color: R.color.mainColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.smoking,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                (patientDetail?.hyper ?? "-").toString() +
                                    " mg/dL",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              patientDetail?.smoker != null
                                  ? patientDetail.smoker
                                      ? LocaleProvider.current.yes
                                      : LocaleProvider.current.no
                                  : "-",
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                LocaleProvider.current.medicines,
                                style: TextStyle(
                                    color: R.color.title, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              LocaleProvider.current.strip_number,
                              style:
                                  TextStyle(color: R.color.title, fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: R.color.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                                child: Text(
                              (patientDetail?.stripCount ?? "-").toString(),
                              style: TextStyle(
                                  color: R.color.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
        ], begin: Alignment.topLeft, end: Alignment.topRight),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(5, 10))
        ],
      ),
    );
  }
}
