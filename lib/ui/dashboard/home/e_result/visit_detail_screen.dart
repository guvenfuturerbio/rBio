import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';
import 'visit_detail_vm.dart';

class VisitDetailScreen extends StatefulWidget {
  int countOfRadiologyResults;
  int countOfPathologyResults;
  int countOfLaboratoryResult;
  int visitId;
  int patientId;

  VisitDetailScreen({
    this.countOfRadiologyResults,
    this.countOfPathologyResults,
    this.countOfLaboratoryResult,
    this.visitId,
    this.patientId,
  });

  @override
  _VisitDetailScreenState createState() => _VisitDetailScreenState();
}

class _VisitDetailScreenState extends State<VisitDetailScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.countOfRadiologyResults =
          int.parse(Atom.queryParameters['countOfRadiologyResults']);
      widget.countOfPathologyResults =
          int.parse(Atom.queryParameters['countOfPathologyResults']);
      widget.countOfLaboratoryResult =
          int.parse(Atom.queryParameters['countOfLaboratoryResult']);
      widget.visitId = int.parse(Atom.queryParameters['visitId']);
      widget.patientId = int.parse(Atom.queryParameters['patientId']);
    } catch (_) {
      return QueryParametersError();
    }

    return ChangeNotifierProvider<VisitDetailScreenVm>(
      create: (context) => VisitDetailScreenVm(
        context: context,
        countOfLaboratoryResults: widget.countOfLaboratoryResult,
        countOfPathologyResults: widget.countOfPathologyResults,
        countOfRadiologyResults: widget.countOfRadiologyResults,
        visitId: widget.visitId,
        patientId: widget.patientId,
      ),
      child: Consumer<VisitDetailScreenVm>(
        builder: (
          BuildContext context,
          VisitDetailScreenVm value,
          Widget child,
        ) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: _buildAppBar(context, value),
            body: _buildBody(context, value),
            persistentFooterButtons: [
              value.laboratorySelected
                  ? InkWell(
                      onTap: () {
                        value.getLaboratoryResultsAsPdf();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 60,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: Text(
                          LocaleProvider.current.detailed_report,
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: tabButtonDecoration(true),
                      ),
                    )
                  : Container(
                      height: 0,
                      color: Colors.white,
                    )
            ],
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context, VisitDetailScreenVm value) {
    return MainAppBar(
      context: context,
      title: getTitleBar(context, LocaleProvider.current.result_detail),
      leading: ButtonBackWhite(context),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20, top: 10),
          child: GestureDetector(
            onTap: () => {value.getLaboratoryResultsAsPdf()},
            child: SvgPicture.asset(
              R.image.ic_ios_share,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, VisitDetailScreenVm value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? MediaQuery.of(context).size.width * 0.10 : 0,
      ),
      child: Column(
        children: [
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              tabButton(
                onPressed: () {
                  return value.togglePathologySelected();
                },
                text: LocaleProvider.current.pathology_result,
                isActive: value.pathologySelected,
                visibility: widget.countOfPathologyResults > 0 ? true : false,
              ),
              tabButton(
                onPressed: () {
                  return value.toggleRadiologySelected();
                },
                text: LocaleProvider.current.radiology_result,
                isActive: value.radiologySelected,
                visibility: widget.countOfRadiologyResults > 0 ? true : false,
              ),
              tabButton(
                onPressed: () {
                  return value.toggleLaboratorySelected();
                },
                text: LocaleProvider.current.laboratory_result,
                isActive: value.laboratorySelected,
                visibility: widget.countOfLaboratoryResult > 0 ? true : false,
              )
            ],
          ),

          //
          value.progress == LoadingProgress.LOADING
              ? Center(child: progress())
              : value.progress == LoadingProgress.DONE &&
                      value.laboratorySelected
                  ? Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: value.laboratoryResults.length,
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Image.asset(
                                              R.image.hospital_results_red,
                                              height: 25,
                                              width: 25,
                                            ),
                                          ),
                                          /*Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            getFormattedDate(value.laboratoryResults[index]?.takenAt ?? ""),
                                            style: TextStyle(
                                                color: R.color.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )*/
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    LocaleProvider.of(context)
                                                        .test_name,
                                                    style: TextStyle(
                                                        color: R.color.grey,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    LocaleProvider
                                                        .current.value,
                                                    style: TextStyle(
                                                        color: R.color.grey,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(
                                                      value
                                                              .laboratoryResults[
                                                                  index]
                                                              ?.name ??
                                                          "-",
                                                      style: TextStyle(
                                                          color: R.color.black,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.zero,
                                                    child: Text(
                                                      ("${value?.laboratoryResults?.elementAt(index)?.value?.toString() ?? "-"}" +
                                                          " " +
                                                          "${value?.laboratoryResults?.elementAt(index)?.unit?.toString() ?? "-"}"),
                                                      style: TextStyle(
                                                          color: R.color.black,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      LocaleProvider.of(context)
                                                          .group_name,
                                                      style: TextStyle(
                                                          color: R.color.grey,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      LocaleProvider.of(context)
                                                          .approved_date,
                                                      style: TextStyle(
                                                          color: R.color.grey,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.zero,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      value
                                                              .laboratoryResults[
                                                                  index]
                                                              ?.group ??
                                                          "-",
                                                      style: TextStyle(
                                                          color: R.color.black,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      value
                                                                  .laboratoryResults[
                                                                      index]
                                                                  .state ==
                                                              6
                                                          ? getFormattedDateWithTime(value
                                                                  ?.laboratoryResults
                                                                  ?.elementAt(
                                                                      index)
                                                                  ?.approvedAt
                                                                  ?.toIso8601String() ??
                                                              "-")
                                                          : "-",
                                                      style: TextStyle(
                                                          color: R.color.black,
                                                          fontSize: 18),
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
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        color: Colors.white,
                      ),
                    )
                  : value.progress == LoadingProgress.DONE &&
                          value.pathologySelected
                      ? Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: value.pathologyResults.length,
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Image.asset(
                                                  R.image.hospital_results_red,
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  value.pathologyResults[index]
                                                      .procedures,
                                                  style: TextStyle(
                                                      color: R.color.grey,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, top: 4),
                                            child: Text(
                                              value.pathologyResults[index]
                                                  .status,
                                              style: TextStyle(
                                                  color: R.color.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            color: Colors.white,
                          ),
                        )
                      : value.progress == LoadingProgress.DONE &&
                              value.radiologySelected
                          ? Expanded(
                              child: Container(
                                child: ListView.builder(
                                  itemCount: value.radiologyResult.length,
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Stack(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Image.asset(
                                                      R.image
                                                          .hospital_results_red,
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      getFormattedDate(value
                                                              .radiologyResult[
                                                                  index]
                                                              ?.takenAt ??
                                                          ""),
                                                      style: TextStyle(
                                                          color: R.color.grey,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            LocaleProvider.of(
                                                                    context)
                                                                .test_name,
                                                            style: TextStyle(
                                                                color: R
                                                                    .color.grey,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            child: Text(
                                                              value
                                                                      .radiologyResult[
                                                                          index]
                                                                      ?.name ??
                                                                  "-",
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .black,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .group_name,
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .approved_date,
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.zero,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Text(
                                                              value
                                                                      .radiologyResult[
                                                                          index]
                                                                      ?.group ??
                                                                  "-",
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .black,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              value
                                                                          .radiologyResult[
                                                                              index]
                                                                          .reportState ==
                                                                      6
                                                                  ? getFormattedDateWithTime(value
                                                                          .radiologyResult[
                                                                              index]
                                                                          ?.approvedAt ??
                                                                      "-")
                                                                  : "-",
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .black,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      child: value.radiologyResult[index].reportState ==
                                                              6
                                                          ? button(
                                                              text: LocaleProvider
                                                                  .current
                                                                  .show_result,
                                                              onPressed: () {
                                                                value.showResult(
                                                                    value
                                                                        .radiologyResult[
                                                                            index]
                                                                        .name,
                                                                    value
                                                                        .radiologyResult[
                                                                            index]
                                                                        .reportLink);
                                                              })
                                                          : passiveButton(
                                                              text: LocaleProvider
                                                                  .current
                                                                  .show_result,
                                                              onPressed: () {}),
                                                      padding:
                                                          EdgeInsets.all(16),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: value
                                                                  .radiologyResult[
                                                                      index]
                                                                  .report !=
                                                              null
                                                          ? button(
                                                              text: LocaleProvider
                                                                  .current
                                                                  .show_report,
                                                              onPressed: () {
                                                                value.getRadiologyResultsAsPdf(value
                                                                    .radiologyResult[
                                                                        index]
                                                                    .id);
                                                              })
                                                          : passiveButton(
                                                              text: LocaleProvider
                                                                  .current
                                                                  .show_report,
                                                              onPressed: () {}),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                color: Colors.white,
                              ),
                            )
                          : Container()
        ],
      ),
    );
  }
}
