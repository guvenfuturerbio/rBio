import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';
import 'appointment_summary_vm.dart';

class AppointmentSummaryScreen extends StatefulWidget {
  int tenantId;
  int resourceId;
  int departmentId;
  String from;
  String to;
  String departmentName;
  String doctorName;
  bool forOnline;
  int appointmentId;
  String imageUrl;

  AppointmentSummaryScreen({
    Key key,
    this.tenantId,
    this.resourceId,
    this.departmentId,
    this.from,
    this.to,
    this.departmentName,
    this.doctorName,
    this.forOnline,
    this.appointmentId,
    this.imageUrl,
  }) : super(key: key);

  @override
  _AppointmentSummaryScreenState createState() =>
      _AppointmentSummaryScreenState();
}

class _AppointmentSummaryScreenState extends State<AppointmentSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']);
      widget.imageUrl = Atom.queryParameters['imageUrl'];
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']);
      widget.from = Atom.queryParameters['from'];
      widget.to = Atom.queryParameters['to'];
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']);
      widget.doctorName = Uri.decodeFull(Atom.queryParameters['doctorName']);
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return RbioError();
    }

    return ChangeNotifierProvider<AppointmentSummaryScreenVm>(
      create: (context) => AppointmentSummaryScreenVm(
          resourceId: widget.resourceId,
          departmentId: widget.departmentId,
          tenantId: widget.tenantId,
          from: widget.from,
          to: widget.to,
          forOnline: widget.forOnline,
          context: context),
      child: Consumer<AppointmentSummaryScreenVm>(
        builder: (BuildContext context, AppointmentSummaryScreenVm value,
            Widget child) {
          return LoadingOverlay(
            isLoading: value.showOverlayLoading,
            opacity: 0,
            progressIndicator: RbioLoading(),
            child: Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(value, context),
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return MainAppBar(
      context: context,
      leading: IconButton(
          icon: SvgPicture.asset(R.image.ic_back_white),
          onPressed: () {
            Atom.historyBack();
          }),
      title: TitleAppBarWhite(
          title: LocaleProvider.of(context).title_appointment_detail),
      actions: [
        IconButton(
          icon: SvgPicture.asset(R.image.ic_edit_white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody(AppointmentSummaryScreenVm value, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: kIsWeb
            ? EdgeInsets.only(
                left: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10,
                right: Atom.size.width < 800
                    ? Atom.size.width * 0.03
                    : Atom.size.width * 0.10)
            : EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          widget.imageUrl ?? "",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return CustomCircleAvatar(
                              size: Atom.size.width < 800 ? 35 : 80,
                              child: SvgPicture.asset(
                                R.image.doctor_avatar,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null)
                              return CustomCircleAvatar(
                                child: Container(
                                  child: child,
                                ),
                                size: Atom.size.width < 800 ? 35 : 80,
                              );
                            return Container(
                                child: Stack(
                              alignment: Alignment.center,
                              children: [
                                RbioLoading(),
                                Center(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                ))
                              ],
                            ));
                          },
                        ),
                        Container(
                          width: Atom.size.width < 800
                              ? Atom.size.width * 0.4
                              : Atom.size.width * 0.5,
                          margin: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.doctorName,
                                style: TextStyle(
                                    color: R.color.black,
                                    fontSize: Atom.size.width < 800
                                        ? 14
                                        : Atom.size.width < 1000
                                            ? 18
                                            : 20,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  value.hospitalName,
                                  style: TextStyle(
                                    color: R.color.gray,
                                    fontSize: Atom.size.width < 800
                                        ? 14
                                        : Atom.size.width < 1000
                                            ? 16
                                            : 18,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  widget.departmentName,
                                  style: TextStyle(
                                    color: R.color.gray,
                                    fontSize: Atom.size.width < 800
                                        ? 14
                                        : Atom.size.width < 1000
                                            ? 16
                                            : 18,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(R.image.ic_tabbar_doctors_grey),
                        Container(
                          width: 1,
                          height: 20,
                          margin: EdgeInsets.only(right: 16, left: 16),
                          color: R.color.dark_white,
                        ),
                        Expanded(
                          child: Text(
                            value.hospitalName,
                            style:
                                TextStyle(color: R.color.black, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(R.image.ic_calendar_black),
                        Container(
                          width: 1,
                          height: 20,
                          margin: EdgeInsets.only(right: 16, left: 16),
                          color: R.color.dark_white,
                        ),
                        Text(
                          value.textDate,
                          style: TextStyle(color: R.color.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(R.image.ic_clock_black),
                        Container(
                          width: 1,
                          height: 20,
                          margin: EdgeInsets.only(right: 16, left: 16),
                          color: R.color.dark_white,
                        ),
                        Text(
                          value.appointmentRange,
                          style: TextStyle(color: R.color.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.forOnline,
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 16, left: 16, right: 16),
                              child: Text(
                                LocaleProvider.current.fee_information,
                                style: TextStyle(
                                    color: R.color.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: R.color.dark_white,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 16, right: 16, left: 16, bottom: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        LocaleProvider.current.online_appo,
                                        style: TextStyle(
                                            color: R.color.grey, fontSize: 16),
                                      ),
                                    ],
                                  )),
                                  value.priceLoading
                                      ? Text("- TL")
                                      : Text(
                                          (value?.getVideoCallPriceResponse
                                                          ?.patientPrice ??
                                                      0) <
                                                  1
                                              ? LocaleProvider.of(context).free
                                              : (value?.getVideoCallPriceResponse
                                                          ?.patientPrice
                                                          ?.toString() ??
                                                      "-") +
                                                  " " +
                                                  "TL",
                                          style: TextStyle(
                                              color: R.color.black,
                                              fontSize: 18),
                                        )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: R.color.dark_white,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 16, right: 16, left: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      LocaleProvider.current.total,
                                      style: TextStyle(
                                          color: R.color.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  value.priceLoading
                                      ? Text("- TL")
                                      : Text(
                                          (value?.getVideoCallPriceResponse
                                                          ?.patientPrice ??
                                                      0) <
                                                  1
                                              ? LocaleProvider.of(context).free
                                              : (value?.getVideoCallPriceResponse
                                                          ?.patientPrice
                                                          ?.toString() ??
                                                      "-") +
                                                  " " +
                                                  "TL",
                                          style: TextStyle(
                                              color: R.color.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: button(
                  width: 250,
                  text: widget.forOnline
                      ? (value?.getVideoCallPriceResponse?.patientPrice ?? 0) <
                              1
                          ? LocaleProvider.of(context).confirm.toUpperCase()
                          : LocaleProvider.current.payment
                      : LocaleProvider.of(context).confirm.toUpperCase(),
                  onPressed: () {
                    if (getIt<UserInfo>().canAccessHospital()) {
                      value.saveAppointment(
                        price: value?.getVideoCallPriceResponse?.patientPrice
                            ?.toString(),
                        forOnline: widget.forOnline,
                        forFree:
                            (value?.getVideoCallPriceResponse?.patientPrice ??
                                        0) <
                                    1
                                ? true
                                : false,
                        appointmentId: widget.appointmentId,
                      );
                    } else {
                      value.showNecessary();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
