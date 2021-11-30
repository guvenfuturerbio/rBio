import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
      return RbioRouteError();
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
          return RbioScaffold(
            appbar: _buildAppBar(value),
            body: _buildBody(value),
          );
        },
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar(VisitDetailScreenVm value) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.result_detail,
      ),
      actions: [
        InkWell(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(8, 8, 14, 8),
            child: SvgPicture.asset(
              R.image.ic_ios_share,
              width: R.sizes.iconSize3,
            ),
          ),
          onTap: () {
            value.shareFile();
          },
        ),
      ],
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody(VisitDetailScreenVm vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        _buildTab(vm),

        //
        Expanded(
          child: _buildStateToWidget(vm),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildTab
  Widget _buildTab(VisitDetailScreenVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildTabButton(
          onPressed: () => vm.togglePathologySelected(),
          text: LocaleProvider.current.pathology_result,
          isActive: vm.pathologySelected,
          visibility: widget.countOfPathologyResults > 0 ? true : false,
        ),
        _buildTabButton(
          onPressed: () => vm.toggleRadiologySelected(),
          text: LocaleProvider.current.radiology_result,
          isActive: vm.radiologySelected,
          visibility: widget.countOfRadiologyResults > 0 ? true : false,
        ),
        _buildTabButton(
          onPressed: () => vm.toggleLaboratorySelected(),
          text: LocaleProvider.current.laboratory_result,
          isActive: vm.laboratorySelected,
          visibility: widget.countOfLaboratoryResult > 0 ? true : false,
        )
      ],
    );
  }
  // #endregion

  // #region _buildTabButton
  Widget _buildTabButton({
    VoidCallback onPressed,
    bool visibility,
    String text,
    bool isActive,
  }) {
    return Visibility(
      visible: visibility,
      child: Expanded(
        child: InkWell(
          onTap: () => onPressed(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.all(8),
            padding: const EdgeInsets.all(10.0),
            decoration: _getTabButtonDecoration(isActive),
            child: Text(
              text,
              style: context.xHeadline3.copyWith(
                color: isActive
                    ? getIt<ITheme>().textColor
                    : getIt<ITheme>().textColorSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
  // #endregion

  // #region _getTabButtonDecoration
  BoxDecoration _getTabButtonDecoration(bool isActive) {
    return BoxDecoration(
      color: isActive ? getIt<ITheme>().mainColor : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildStateToWidget
  Widget _buildStateToWidget(VisitDetailScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildDone(vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
  // #endregion

  // #region _buildDone
  Widget _buildDone(VisitDetailScreenVm vm) {
    if (vm.laboratorySelected) {
      if (vm.laboratoryFileBytes == null) {
        return RbioLoading();
      }

      return SfPdfViewer.memory(
        base64.decode(vm.laboratoryFileBytes),
        canShowPaginationDialog: false,
      );

      // return ListView.builder(
      //   scrollDirection: Axis.vertical,
      //   physics: BouncingScrollPhysics(),
      //   padding: EdgeInsets.only(top: 12),
      //   itemCount: vm.laboratoryResults.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       width: double.infinity,
      //       padding: EdgeInsets.all(8),
      //       margin: EdgeInsets.only(bottom: 20),
      //       decoration: BoxDecoration(
      //         color: getIt<ITheme>().cardBackgroundColor,
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.min,
      //         children: <Widget>[
      //           //
      //           Padding(
      //             padding: EdgeInsets.only(left: 10),
      //             child: Image.asset(
      //               R.image.hospital_results_red,
      //               height: 25,
      //               width: 25,
      //             ),
      //           ),

      //           //
      //           Padding(
      //             padding: EdgeInsets.all(10),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               mainAxisSize: MainAxisSize.min,
      //               children: <Widget>[
      //                 //
      //                 Row(
      //                   children: [
      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         LocaleProvider.of(context).test_name,
      //                         style: context.xHeadline4.copyWith(
      //                           color: getIt<ITheme>().textColorPassive,
      //                         ),
      //                       ),
      //                     ),

      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         LocaleProvider.current.value,
      //                         style: context.xHeadline4.copyWith(
      //                           color: getIt<ITheme>().textColorPassive,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),

      //                 //
      //                 Row(
      //                   children: [
      //                     Expanded(
      //                       child: Text(
      //                         vm.laboratoryResults[index]?.name ?? "-",
      //                         style: context.xHeadline3,
      //                       ),
      //                     ),

      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         ("${vm?.laboratoryResults?.elementAt(index)?.value?.toString() ?? "-"}" +
      //                             " " +
      //                             "${vm?.laboratoryResults?.elementAt(index)?.unit?.toString() ?? "-"}"),
      //                         style: context.xHeadline3,
      //                       ),
      //                     ),
      //                   ],
      //                 ),

      //                 //
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 6),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: <Widget>[
      //                       Expanded(
      //                         child: Text(
      //                           LocaleProvider.of(context).group_name,
      //                           style: context.xHeadline4.copyWith(
      //                             color: getIt<ITheme>().textColorPassive,
      //                           ),
      //                         ),
      //                       ),

      //                       //
      //                       Expanded(
      //                         child: Text(
      //                           LocaleProvider.of(context).approved_date,
      //                           style: context.xHeadline4.copyWith(
      //                             color: getIt<ITheme>().textColorPassive,
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),

      //                 //
      //                 Row(
      //                   children: <Widget>[
      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         vm.laboratoryResults[index]?.group ?? "-",
      //                         style: context.xHeadline3,
      //                       ),
      //                     ),

      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         vm.laboratoryResults[index].state == 6
      //                             ? getFormattedDateWithTime(vm
      //                                     ?.laboratoryResults
      //                                     ?.elementAt(index)
      //                                     ?.approvedAt
      //                                     ?.toIso8601String() ??
      //                                 "-")
      //                             : "-",
      //                         style: context.xHeadline3,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
    } else if (vm.pathologySelected) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemCount: vm.pathologyResults.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //
                Wrap(
                  children: <Widget>[
                    //
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        R.image.hospital_results_red,
                        height: 25,
                        width: 25,
                      ),
                    ),

                    //
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        vm.pathologyResults[index].procedures,
                        style: context.xHeadline4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 4),
                  child: Text(
                    vm.pathologyResults[index].status,
                    style: context.xHeadline4.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else if (vm.radiologySelected) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 12),
        itemCount: vm.radiologyResult.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    //
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        R.image.hospital_results_red,
                        height: 25,
                        width: 25,
                      ),
                    ),

                    //
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        getFormattedDate(
                            vm.radiologyResult[index]?.takenAt ?? ""),
                        style: context.xHeadline4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //
                      Text(
                        LocaleProvider.of(context).test_name,
                        style: context.xHeadline4.copyWith(
                          color: getIt<ITheme>().textColorPassive,
                        ),
                      ),

                      //
                      Text(
                        vm.radiologyResult[index]?.name ?? "-",
                        style: context.xHeadline3,
                      ),

                      //
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).group_name,
                                style: context.xHeadline4.copyWith(
                                  color: getIt<ITheme>().textColorPassive,
                                ),
                              ),
                            ),

                            //
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).approved_date,
                                style: context.xHeadline4.copyWith(
                                  color: getIt<ITheme>().textColorPassive,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //
                          Expanded(
                            child: Text(
                              vm.radiologyResult[index]?.group ?? "-",
                              style: context.xHeadline3,
                            ),
                          ),

                          //
                          Expanded(
                            child: Text(
                              vm.radiologyResult[index].reportState == 6
                                  ? getFormattedDateWithTime(
                                      vm.radiologyResult[index]?.approvedAt ??
                                          "-")
                                  : "-",
                              style: context.xHeadline3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, right: 8),
                        child: vm.radiologyResult[index].reportState == 6
                            ? button(
                                text: LocaleProvider.current.show_result,
                                onPressed: () {
                                  vm.showResult(vm.radiologyResult[index].name,
                                      vm.radiologyResult[index].reportLink);
                                },
                              )
                            : passiveButton(
                                text: LocaleProvider.current.show_result,
                                onPressed: () {},
                              ),
                      ),
                    ),

                    //
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: vm.radiologyResult[index].report != null &&
                                vm.radiologyResult[index].reportState == 6
                            ? button(
                                text: LocaleProvider.current.show_report,
                                onPressed: () {
                                  vm.getRadiologyResultsAsPdf(
                                      vm.radiologyResult[index].id);
                                },
                              )
                            : passiveButton(
                                text: LocaleProvider.current.show_report,
                                onPressed: () {},
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }
  // #endregion
}
