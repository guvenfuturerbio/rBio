// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/core.dart';
import '../cubit/visit_detail_cubit.dart';

class VisitDetailScreen extends StatelessWidget {
  int? countOfRadiologyResults;
  int? countOfPathologyResults;
  int? countOfLaboratoryResult;
  int? visitId;
  int? patientId;
  VisitDetailScreen(
      {this.countOfLaboratoryResult,
      this.countOfPathologyResults,
      this.countOfRadiologyResults,
      this.visitId,
      this.patientId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      countOfRadiologyResults =
          int.parse(Atom.queryParameters['countOfRadiologyResults']!);
      countOfPathologyResults =
          int.parse(Atom.queryParameters['countOfPathologyResults']!);
      countOfLaboratoryResult =
          int.parse(Atom.queryParameters['countOfLaboratoryResult']!);
      visitId = int.parse(Atom.queryParameters['visitId']!);
      patientId = int.parse(Atom.queryParameters['patientId']!);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }
    return BlocProvider(
      create: (context) => VisitDetailCubit(getIt(),
          countOfLaboratoryResults: countOfLaboratoryResult!,
          countOfPathologyResults: countOfPathologyResults!,
          countOfRadiologyResults: countOfRadiologyResults!,
          visitId: visitId!,
          patientId: patientId!),
      child: VisitDetailView(
        countOfLaboratoryResult: countOfLaboratoryResult,
        countOfPathologyResults: countOfPathologyResults,
        countOfRadiologyResults: countOfRadiologyResults,
        visitId: visitId,
        patientId: patientId,
      ),
    );
  }
}

class VisitDetailView extends StatefulWidget {
  int? countOfRadiologyResults;
  int? countOfPathologyResults;
  int? countOfLaboratoryResult;
  int? visitId;
  int? patientId;

  VisitDetailView({
    Key? key,
    this.countOfRadiologyResults,
    this.countOfPathologyResults,
    this.countOfLaboratoryResult,
    this.visitId,
    this.patientId,
  }) : super(key: key);

  @override
  _VisitDetailViewState createState() => _VisitDetailViewState();
}

class _VisitDetailViewState extends State<VisitDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitDetailCubit, VisitDetailState>(
      builder: (context, state) {
        return RbioStackedScaffold(
          isLoading: state.isLoading,
          appbar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.result_detail,
      ),
      actions: [
        InkWell(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            child: SvgPicture.asset(
              R.image.iosShare,
              width: R.sizes.iconSize3,
            ),
          ),
          onTap: () {
            context.read<VisitDetailCubit>().shareFile();
          },
        ),
      ],
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody(VisitDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        R.widgets.stackedTopPadding(context),
        //
        _buildTab(state),
        //
        Expanded(
          child: _buildStateToWidget(state),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildTab
  Widget _buildTab(VisitDetailState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildTabButton(
          onPressed: () => context
              .read<VisitDetailCubit>()
              .togglePathologySelected(state.pathologySelected),
          text: LocaleProvider.current.pathology_result,
          isActive: state.pathologySelected,
          visibility: widget.countOfPathologyResults! > 0 ? true : false,
        ),
        _buildTabButton(
          onPressed: () => context
              .read<VisitDetailCubit>()
              .toggleRadiologySelected(state.radiologySelected),
          text: LocaleProvider.current.radiology_result,
          isActive: state.radiologySelected,
          visibility: widget.countOfRadiologyResults! > 0 ? true : false,
        ),
        _buildTabButton(
          onPressed: () => context
              .read<VisitDetailCubit>()
              .toggleLaboratorySelected(state.laboratorySelected),
          text: LocaleProvider.current.laboratory_result,
          isActive: state.laboratorySelected,
          visibility: widget.countOfLaboratoryResult! > 0 ? true : false,
        )
      ],
    );
  }
  // #endregion

  // #region _buildTabButton
  Widget _buildTabButton({
    required VoidCallback onPressed,
    required bool visibility,
    required String text,
    required bool isActive,
  }) {
    return Visibility(
      visible: visibility,
      child: Expanded(
        child: InkWell(
          onTap: () => onPressed(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10.0),
            decoration: _getTabButtonDecoration(isActive),
            child: Text(
              text,
              style: context.xHeadline3.copyWith(
                color: isActive
                    ? getIt<IAppConfig>().theme.textColor
                    : getIt<IAppConfig>().theme.textColorSecondary,
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
      color: isActive ? getIt<IAppConfig>().theme.mainColor : Colors.white,
      borderRadius: R.sizes.borderRadiusCircular,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
  // #endregion

  // #region _buildStateToWidget
  Widget _buildStateToWidget(VisitDetailState state) {
    switch (state.status) {
      case RbioLoadingProgress.initial:
        return const SizedBox();

      case RbioLoadingProgress.loadInProgress:
        return const RbioLoading();

      case RbioLoadingProgress.success:
        return _buildDone(state);

      case RbioLoadingProgress.failure:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
  // #endregion

  // #region _buildDone
  Widget _buildDone(VisitDetailState state) {
    if (state.laboratorySelected) {
      if (state.laboratoryFileBytes == null) {
        return const RbioLoading();
      }

      return SfPdfViewer.memory(
        base64.decode(state.laboratoryFileBytes!),
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
      //         color: getIt<IAppConfig>().theme.cardBackgroundColor,
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
      //                           color: getIt<IAppConfig>().theme.textColorPassive,
      //                         ),
      //                       ),
      //                     ),

      //                     //
      //                     Expanded(
      //                       child: Text(
      //                         LocaleProvider.current.value,
      //                         style: context.xHeadline4.copyWith(
      //                           color: getIt<IAppConfig>().theme.textColorPassive,
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
      //                             color: getIt<IAppConfig>().theme.textColorPassive,
      //                           ),
      //                         ),
      //                       ),

      //                       //
      //                       Expanded(
      //                         child: Text(
      //                           LocaleProvider.of(context).approved_date,
      //                           style: context.xHeadline4.copyWith(
      //                             color: getIt<IAppConfig>().theme.textColorPassive,
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
    } else if (state.pathologySelected) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: state.pathologyResults.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: getIt<IAppConfig>().theme.cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
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
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        R.image.hospitalResultsRed,
                        height: 25,
                        width: 25,
                      ),
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        state.pathologyResults[index].procedures ?? '',
                        style: context.xHeadline3.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  child: Text(
                    state.pathologyResults[index].status ?? '',
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
    } else if (state.radiologySelected) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 12),
        itemCount: state.radiologyResults.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: getIt<IAppConfig>().theme.cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
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
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset(
                        R.image.hospitalResultsRed,
                        height: 25,
                        width: 25,
                      ),
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        state.radiologyResults[index].takenAt
                                ?.xGetUTCLocalDate() ??
                            "",
                        style: context.xHeadline4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //
                      Text(
                        LocaleProvider.of(context).test_name,
                        style: context.xHeadline4.copyWith(
                          color: getIt<IAppConfig>().theme.textColorPassive,
                        ),
                      ),

                      //
                      Text(
                        state.radiologyResults[index].name ?? "-",
                        style: context.xHeadline3,
                      ),

                      //
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).group_name,
                                style: context.xHeadline4.copyWith(
                                  color: getIt<IAppConfig>()
                                      .theme
                                      .textColorPassive,
                                ),
                              ),
                            ),

                            //
                            Expanded(
                              child: Text(
                                LocaleProvider.of(context).approved_date,
                                style: context.xHeadline4.copyWith(
                                  color: getIt<IAppConfig>()
                                      .theme
                                      .textColorPassive,
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
                              state.radiologyResults[index].group ?? "-",
                              style: context.xHeadline3,
                            ),
                          ),

                          //
                          Expanded(
                            child: Text(
                              state.radiologyResults[index].reportState == 6
                                  ? DateTime.parse((state
                                              .radiologyResults[index]
                                              .approvedAt ??
                                          ''))
                                      .xFormatTime3()
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
                        padding: const EdgeInsets.only(top: 8),
                        child: state.radiologyResults[index].reportState == 6
                            ? Utils.instance.button(
                                text: LocaleProvider.current.show_result,
                                width: 130,
                                onPressed: () {
                                  final name =
                                      state.radiologyResults[index].name;
                                  final reportLink =
                                      state.radiologyResults[index].reportLink;
                                  if (name != null && reportLink != null) {
                                    context.read<VisitDetailCubit>().showResult(
                                          name,
                                          reportLink,
                                        );
                                  }
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
                        padding: const EdgeInsets.only(top: 8, left: 10),
                        child: state.radiologyResults[index].report != null &&
                                state.radiologyResults[index].reportState == 6
                            ? Utils.instance.button(
                                text: LocaleProvider.current.show_report,
                                onPressed: () {
                                  final processId =
                                      state.radiologyResults[index].id;
                                  if (processId != null) {
                                    context
                                        .read<VisitDetailCubit>()
                                        .getRadiologyResultsAsPdf(
                                          processId,
                                        );
                                  }
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
      return const SizedBox();
    }
  }
  // #endregion

  Widget passiveButton({
    required String text,
    required Function onPressed,
    double height = 16,
    double width = 200,
  }) =>
      GradientButton(
        callback: onPressed(),
        increaseWidthBy: width,
        increaseHeightBy: height,
        shadowColor: Colors.black.withAlpha(50),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: getIt<IAppConfig>().theme.grey,
        ),
        gradient: LinearGradient(
          colors: [
            getIt<IAppConfig>().theme.mainColor.withAlpha(15),
            getIt<IAppConfig>().theme.mainColor.withAlpha(15)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
      );
}
