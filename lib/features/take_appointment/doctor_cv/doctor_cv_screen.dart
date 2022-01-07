import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'doctor_cv_vm.dart';

class DoctorCvScreen extends StatefulWidget {
  String doctorNameNoTitle;
  int tenantId;
  int departmentId;
  int resourceId;
  String doctorName;
  String departmentName;

  DoctorCvScreen({
    this.tenantId,
    this.departmentId,
    this.resourceId,
    this.doctorName,
    this.departmentName,
    this.doctorNameNoTitle,
  });

  @override
  _DoctorCvScreenState createState() => _DoctorCvScreenState();
}

class _DoctorCvScreenState extends State<DoctorCvScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.doctorNameNoTitle =
          Uri.decodeFull(Atom.queryParameters['doctorNameNoTitle']);
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']);
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']);
      widget.doctorName = Uri.decodeFull(Atom.queryParameters['doctorName']);
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']);
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<DoctorCvScreenVm>(
      create: (context) => DoctorCvScreenVm(
        context: context,
        doctorNameNotTitle: widget.doctorNameNoTitle,
      ),
      child: Consumer<DoctorCvScreenVm>(
        builder: (BuildContext context, DoctorCvScreenVm value, Widget child) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).title_doctors_profiles,
              ),
            ),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DoctorCvScreenVm value) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).size.width > 800
            ? EdgeInsets.all(64)
            : EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                value.progress == LoadingProgress.DONE
                    ? Image.network(
                        value.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Utils.instance.CustomCircleAvatar(
                            size: 120,
                            child: SvgPicture.asset(
                              R.image.doctor_avatar,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null)
                            return Utils.instance.CustomCircleAvatar(
                                child: Container(
                                  child: child,
                                ),
                                size: 120);
                          return Container(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              RbioLoading(),
                              Center(
                                  child: Container(
                                width: 120,
                                height: 120,
                              ))
                            ],
                          ));
                        },
                      )
                    : Utils.instance.CustomCircleAvatar(
                        size: 120,
                        child: SvgPicture.asset(
                          R.image.doctor_avatar,
                          fit: BoxFit.fill,
                        )),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                widget.doctorName,
                style: context.xHeadline2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                  widget.tenantId == 1
                      ? LocaleProvider.current.guven_hospital_ayranci
                      : widget.tenantId == 7
                          ? LocaleProvider.current.guven_cayyolu_campus
                          : LocaleProvider.current.online_hospital,
                  style:
                      context.xHeadline3.copyWith(color: getIt<ITheme>().grey)),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(widget.departmentName,
                  style:
                      context.xHeadline3.copyWith(color: getIt<ITheme>().grey)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Utils.instance.button(
                width: 260,
                text: LocaleProvider.of(context)
                    .make_an_appointment
                    .toUpperCase(),
                onPressed: () {
                  Atom.to(
                    PagePaths.CREATE_APPOINTMENT,
                    queryParameters: {
                      'fromOnline': 'false',
                      'fromSearch': 'true',
                      'departmentId': widget.departmentId.toString(),
                      'resourceId': widget.resourceId.toString(),
                      'tenantId': widget.tenantId.toString(),
                    },
                  );
                },
              ),
            ),
            value.progress == LoadingProgress.DONE
                ? Column(
                    children: [
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.specialties?.length ??
                                        0) ==
                                    0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).specialities,
                              style: context.xHeadline3
                                  .copyWith(fontWeight: FontWeight.bold)),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.specialties?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.specialties[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (value?.doctorCvResponse?.treatments?.length ??
                                    0) ==
                                0
                            ? false
                            : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).treatments,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.treatments?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.treatments[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.experiences?.length ??
                                        0) ==
                                    0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).experiences,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.experiences?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.experiences[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (value?.doctorCvResponse?.educations?.length ??
                                    0) ==
                                0
                            ? false
                            : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).educations,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.educations?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.educations[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.publications?.length ??
                                        0) ==
                                    0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).publications,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.publications?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.publications[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.memberships?.length ??
                                        0) ==
                                    0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).memberships,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.memberships?.length ??
                                    0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.memberships[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.trainings?.length ?? 0) ==
                                    0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(
                            LocaleProvider.of(context).trainings,
                            style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.trainings?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.trainings[index]
                                          .text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            (value?.doctorCvResponse?.awards?.length ?? 0) == 0
                                ? false
                                : true,
                        child: ListTile(
                          title: Text(LocaleProvider.of(context).awards,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                value?.doctorCvResponse?.awards?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                  '-' +
                                      value.doctorCvResponse.awards[index].text,
                                  style: context.xHeadline5);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : value.progress == LoadingProgress.LOADING
                    ? RbioLoading()
                    : Container(
                        margin:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Text(
                            widget.doctorName +
                                " " +
                                LocaleProvider.of(context)
                                    .doctor_cv_not_uploaded,
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.3,
                            style: context.xHeadline5),
                      ),
          ],
        ),
      ),
    );
  }
}
