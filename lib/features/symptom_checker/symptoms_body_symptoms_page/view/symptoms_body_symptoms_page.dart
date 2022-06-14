import 'package:flutter/material.dart';
import 'package:onedosehealth/features/symptom_checker/symptoms_result_page/model/get_body_symptoms_response.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../symptoms_body_sublocations_page/viewmodel/symptoms_body_sublocations_vm.dart';
import '../viewmodel/symptoms_body_symptoms_page_vm.dart';

class BodySymptomsSelectionPage extends StatefulWidget {
  List<GetBodySymptomsResponse>? selectedBodySymptoms;
  late int? selectedGenderId;
  late String? yearOfBirth;
  GetBodyLocationResponse? selectedBodyLocation;
  late bool? isFromVoice;
  BodySublocationsVm? myPv;

  BodySymptomsSelectionPage({
    Key? key,
    this.selectedBodySymptoms,
    this.selectedGenderId,
    this.yearOfBirth,
    this.selectedBodyLocation,
    this.isFromVoice,
    this.myPv,
  }) : super(key: key);

  @override
  _BodySymptomsSelectionPageState createState() =>
      _BodySymptomsSelectionPageState();
}

class _BodySymptomsSelectionPageState extends State<BodySymptomsSelectionPage> {
  @override
  void dispose() {
    try {
      AppInheritedWidget.of(context)?.bodyLocationRsp = null;
      AppInheritedWidget.of(context)?.listBodySympRsp = [];
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.i(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.selectedBodyLocation =
          AppInheritedWidget.of(context)?.bodyLocationRsp;
      widget.myPv = AppInheritedWidget.of(context)?.sublocationVm;
      widget.selectedBodySymptoms =
          AppInheritedWidget.of(context)?.listBodySympRsp ?? [];
      widget.selectedGenderId =
          int.parse(Atom.queryParameters['selectedGenderId'] as String);
      widget.yearOfBirth = Atom.queryParameters['yearOfBirth'] as String;
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      return const RbioRouteError();
    }

    return ChangeNotifierProvider(
      create: (context) => BodySymptomSelectionVm(
        context: context,
        genderId: widget.selectedGenderId!,
        symptomList:
            widget.myPv!.selectedSymptoms as List<GetBodySymptomsResponse>,
        yearOfBirth: widget.yearOfBirth!,
        isFromVoice: widget.isFromVoice,
        myPv: widget.myPv,
      ),
      child: Consumer<BodySymptomSelectionVm>(
        builder: (context, value, child) {
          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).my_symptoms,
      ),
    );
  }

  Widget _buildBody(BuildContext context, BodySymptomSelectionVm value) {
    return Column(
      children: [
        //
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 2, top: 15),
                      child: Text(
                        widget.selectedGenderId == 0
                            ? LocaleProvider.of(context).gender_male
                            : widget.selectedGenderId == 1
                                ? LocaleProvider.of(context).gender_female
                                : widget.selectedGenderId == 2
                                    ? LocaleProvider.of(context).boy
                                    : LocaleProvider.of(context).girl,
                        style: context.xHeadline3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: getIt<IAppConfig>().theme.mainColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.selectedBodyLocation!.name!,
                          style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: getIt<IAppConfig>().theme.mainColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 30.0),
                        child: Text(
                          LocaleProvider.of(context).your_complaints,
                          style: context.xHeadline3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: getIt<IAppConfig>()
                                  .theme
                                  .textColorSecondary
                                  .withOpacity(0.5)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: value.selectedBodySymptoms.length * 35.0 >
                              MediaQuery.of(context).size.height * 0.25
                          ? MediaQuery.of(context).size.height * 0.25
                          : value.selectedBodySymptoms.length * 35.0,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 8),
                          itemCount: value.selectedBodySymptoms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${value.selectedBodySymptoms[index].name}',
                                      style: context.xHeadline3.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: getIt<IAppConfig>()
                                              .theme
                                              .mainColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          await value.removeSemptomFromList(
                                              value
                                                  .selectedBodySymptoms[index]);
                                          await widget.myPv!
                                              .removeSemptomFromList(widget
                                                  .myPv!
                                                  .selectedSymptoms![index]);
                                          await value.fetchProposedSymptoms(
                                              value.selectedBodySymptoms,
                                              widget.selectedGenderId,
                                              widget.yearOfBirth);
                                        },
                                        child: const Icon(Icons.close)),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                )
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: RbioElevatedButton(
                            onTap: () {
                              Atom.historyBack();
                            },
                            title: LocaleProvider.of(context).add_symptom),
                      ),
                    ),
                    value.proposedProgress == LoadingProgress.loading
                        ? const RbioLoading()
                        : _buildProposedList(value, context),
                  ],
                ),
              ],
            ),
          ),
        ),

        //
        RbioElevatedButton(
          onTap: value.selectedBodySymptoms.isNotEmpty
              ? () async {
                  AppInheritedWidget.of(context)?.listBodySympRsp =
                      value.selectedBodySymptoms;
                  getIt<IAppConfig>()
                      .platform
                      .adjustManager
                      ?.trackEvent(MySymptomsPage4DepartmentAnalysisEvent());
                  getIt<FirebaseAnalyticsManager>().logEvent(
                    SikayetlerimSayfa4BolumAnaliziYapin(
                      getIt<UserNotifier>().firebaseEmail,
                      widget.selectedGenderId == 0 ||
                              widget.selectedGenderId == 2
                          ? 'M'
                          : 'F',
                      widget.yearOfBirth!.toString(),
                      widget.myPv?.bodyLocNames.toString(),
                      widget.myPv?.bodyLocNamesList.length.toString(),
                    ),
                  );
                  Atom.to(
                    PagePaths.symptomResultPage,
                    queryParameters: {
                      'gender': widget.selectedGenderId == 0 ||
                              widget.selectedGenderId == 2
                          ? 'male'
                          : 'female',
                      'body_part': widget.myPv!.bodyLocNames!,
                      'body_part_length':
                          widget.myPv!.bodyLocNamesList.length.toString(),
                      'year_of_birth': widget.yearOfBirth!,
                      'isFromVoice': false.toString(),
                    },
                  );
                }
              : null,
          title: LocaleProvider.of(context).analyze_department,
          infinityWidth: true,
        ),

        //
        R.sizes.defaultBottomPadding,
      ],
    );
  }

  Widget _buildProposedList(
      BodySymptomSelectionVm value, BuildContext context) {
    switch (value.proposedProgress) {
      case LoadingProgress.loading:
        return const RbioLoading();
      case LoadingProgress.done:
        return Visibility(
          visible: value.proposedSymptomList.isNotEmpty ? true : false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  LocaleProvider.current.proposed_symptom,
                  style: context.xHeadline1.copyWith(
                      color: getIt<IAppConfig>().theme.textColorSecondary),
                ),
              ),
              SizedBox(
                height: value.proposedSymptomList.length * 35.0 >
                        MediaQuery.of(context).size.height * 0.25
                    ? MediaQuery.of(context).size.height * 0.25
                    : value.proposedSymptomList.length * 35.0,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 7),
                    itemCount: value.proposedSymptomList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 6,
                                child: Text(
                                  '${value.proposedSymptomList[index].name}',
                                  style: context.xHeadline3.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          getIt<IAppConfig>().theme.mainColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () async {
                                      widget.myPv!.addSemptomToList(
                                          value.proposedSymptomList[index]);
                                      await value.addSemptomToList(
                                          value.proposedSymptomList[index]);
                                      await value.fetchProposedSymptoms(
                                          value.selectedBodySymptoms,
                                          widget.selectedGenderId,
                                          widget.yearOfBirth);
                                    },
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
