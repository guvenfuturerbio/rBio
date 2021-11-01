import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';
import 'e_result_vm.dart';

class EResultScreen extends StatefulWidget {
  const EResultScreen({Key key}) : super(key: key);

  @override
  _EResultScreenState createState() => _EResultScreenState();
}

class _EResultScreenState extends State<EResultScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EResultScreenVm>(
      create: (context) => EResultScreenVm(context: context),
      child: Consumer<EResultScreenVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: MainAppBar(
            context: context,
            title: getTitleBar(context, LocaleProvider.current.results),
            leading: ButtonBackWhite(context),
          ),
          body: kIsWeb
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 50,
                        left: Atom.size.width < 800
                            ? Atom.size.width * 0.03
                            : Atom.size.width * 0.10,
                        right: Atom.size.width < 800
                            ? Atom.size.width * 0.03
                            : Atom.size.width * 0.10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 12),
                                child: Text(
                                  LocaleProvider.current.date_filter,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              //
                              Container(
                                margin:
                                    EdgeInsets.only(left: 8, top: 8, right: 8),
                                child: GuvenDateRange(
                                  startCurrentDate: value.startDate,
                                  onStartDateChange: (date) {
                                    value.setStartDate(date);
                                  },
                                  endCurrentDate: value.endDate,
                                  onEndDateChange: (date) {
                                    value.setEndDate(date);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //
                        value.progress == LoadingProgress.LOADING
                            ? Center(child: progress())
                            : value.progress == LoadingProgress.ERROR
                                ? Center(
                                    child: Text(
                                      LocaleProvider
                                          .current.sorry_dont_transaction,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : value.visits.length > 0
                                    ? Container(
                                        child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: value.visits.length,
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, top: 10),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(8),
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Image.asset(
                                                              R.image
                                                                  .hospital_results_red,
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              getFormattedDate(value
                                                                  .visits[index]
                                                                  .openingDate),
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .hint_doctor,
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: Text(
                                                                value
                                                                    .visits[
                                                                        index]
                                                                    .physician,
                                                                style: TextStyle(
                                                                    color: R
                                                                        .color
                                                                        .black,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 5),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Text(
                                                                      LocaleProvider.of(
                                                                              context)
                                                                          .department,
                                                                      style: TextStyle(
                                                                          color: R
                                                                              .color
                                                                              .grey,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Text(
                                                                      value
                                                                          .visits[
                                                                              index]
                                                                          .department,
                                                                      style: TextStyle(
                                                                          color: R
                                                                              .color
                                                                              .black,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                value.visits[index].hasLaboratoryResults ||
                                                                        value
                                                                            .visits[
                                                                                index]
                                                                            .hasRadiologyResults ||
                                                                        value
                                                                            .visits[
                                                                                index]
                                                                            .hasPathologyResults
                                                                    ? button(
                                                                        height:
                                                                            10,
                                                                        width: Atom.size.width < 800
                                                                            ? Atom.size.width *
                                                                                0.3
                                                                            : Atom.size.width *
                                                                                0.5,
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .vRouter
                                                                              .to(
                                                                            PagePaths.VISIT_DETAIL,
                                                                            queryParameters: {
                                                                              'countOfRadiologyResults': value.visits[index].countOfRadiologyResults.toString(),
                                                                              'countOfPathologyResults': value.visits[index].countOfPathologyResults.toString(),
                                                                              'countOfLaboratoryResult': value.visits[index].countOfLaboratoryResults.toString(),
                                                                              'patientId': value.visits[index].patientId.toString(),
                                                                              'visitId': value.visits[index].id.toString(),
                                                                            },
                                                                          );
                                                                        },
                                                                        text: LocaleProvider
                                                                            .current
                                                                            .show_result)
                                                                    : passiveButton(
                                                                        height:
                                                                            10,
                                                                        width: Atom.size.width < 800
                                                                            ? Atom.size.width *
                                                                                0.3
                                                                            : Atom.size.width *
                                                                                0.5,
                                                                        text: LocaleProvider
                                                                            .current
                                                                            .show_result,
                                                                      )
                                                              ],
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
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
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
                                        //     color: Colors.white,
                                      )
                                    : Center(
                                        child: Text(
                                          LocaleProvider
                                              .current.no_result_selected_date,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 12),
                              child: Text(
                                LocaleProvider.current.date_filter,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //
                            Container(
                              margin:
                                  EdgeInsets.only(left: 8, top: 8, right: 8),
                              child: GuvenDateRange(
                                startCurrentDate: value.startDate,
                                onStartDateChange: (date) {
                                  value.setStartDate(date);
                                },
                                endCurrentDate: value.endDate,
                                onEndDateChange: (date) {
                                  value.setEndDate(date);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      value.progress == LoadingProgress.LOADING
                          ? Center(child: progress())
                          : value.progress == LoadingProgress.ERROR
                              ? Center(
                                  child: Text(
                                    LocaleProvider
                                        .current.sorry_dont_transaction,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              : value.visits.length > 0
                                  ? Expanded(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: value.visits.length,
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, top: 10),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(8),
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Image.asset(
                                                              R.image
                                                                  .hospital_results_red,
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              getFormattedDate(value
                                                                  .visits[index]
                                                                  .openingDate),
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              LocaleProvider.of(
                                                                      context)
                                                                  .hint_doctor,
                                                              style: TextStyle(
                                                                  color: R.color
                                                                      .grey,
                                                                  fontSize: 16),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: Text(
                                                                value
                                                                    .visits[
                                                                        index]
                                                                    .physician,
                                                                style: TextStyle(
                                                                    color: R
                                                                        .color
                                                                        .black,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(top: 5),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Text(
                                                                      LocaleProvider.of(
                                                                              context)
                                                                          .department,
                                                                      style: TextStyle(
                                                                          color: R
                                                                              .color
                                                                              .grey,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child: Text(
                                                                      value
                                                                          .visits[
                                                                              index]
                                                                          .department,
                                                                      style: TextStyle(
                                                                          color: R
                                                                              .color
                                                                              .black,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                value.visits[index].hasLaboratoryResults ||
                                                                        value
                                                                            .visits[
                                                                                index]
                                                                            .hasRadiologyResults ||
                                                                        value
                                                                            .visits[
                                                                                index]
                                                                            .hasPathologyResults
                                                                    ? button(
                                                                        height:
                                                                            10,
                                                                        width: Atom.size.width < 800
                                                                            ? Atom.size.width *
                                                                                0.3
                                                                            : Atom.size.width *
                                                                                0.5,
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .vRouter
                                                                              .to(
                                                                            PagePaths.VISIT_DETAIL,
                                                                            queryParameters: {
                                                                              'countOfRadiologyResults': value.visits[index].countOfRadiologyResults.toString(),
                                                                              'countOfPathologyResults': value.visits[index].countOfPathologyResults.toString(),
                                                                              'countOfLaboratoryResult': value.visits[index].countOfLaboratoryResults.toString(),
                                                                              'patientId': value.visits[index].patientId.toString(),
                                                                              'visitId': value.visits[index].id.toString(),
                                                                            },
                                                                          );
                                                                        },
                                                                        text: LocaleProvider
                                                                            .current
                                                                            .show_result)
                                                                    : passiveButton(
                                                                        height:
                                                                            10,
                                                                        width: Atom.size.width < 800
                                                                            ? Atom.size.width *
                                                                                0.3
                                                                            : Atom.size.width *
                                                                                0.5,
                                                                        text: LocaleProvider
                                                                            .current
                                                                            .show_result,
                                                                      )
                                                              ],
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
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
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
                                  : Center(
                                      child: Text(
                                        LocaleProvider
                                            .current.no_result_selected_date,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
