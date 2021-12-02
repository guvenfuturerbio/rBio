import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/rbio_appbar.dart';
import '../../../../model/model.dart';
import '../viewmodel/symptoms_result_page_vm.dart';

class SymptomsResultPage extends StatefulWidget {
  SymptomsResultPage(
      {Key key,
      this.symptoms,
      this.gender,
      this.year_of_birth,
      this.isFromVoice});

  List<GetBodySymptomsResponse> symptoms;
  String gender;
  String year_of_birth;
  bool isFromVoice;

  @override
  State<SymptomsResultPage> createState() => _SymptomsResultPageState();
}

class _SymptomsResultPageState extends State<SymptomsResultPage> {
  @override
  void dispose() {
    RbioConfig.of(context).listBodySympRsp = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.symptoms = RbioConfig.of(context).listBodySympRsp;
      widget.gender = Atom.queryParameters['gender'];
      widget.year_of_birth = Atom.queryParameters['year_of_birth'];
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }
    return ChangeNotifierProvider(
      create: (context) => SymptomsResultPageVm(
        context: context,
        gender: this.widget.gender,
        selectedSymptoms: this.widget.symptoms,
        year_of_birth: this.widget.year_of_birth,
        isFromVoice: this.widget.isFromVoice,
      ),
      child: Consumer<SymptomsResultPageVm>(
        builder: (context, value, child) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).results,
              ),
            ),
            body: _buildResultList(context, value),
          );
        },
      ),
    );
  }

  Widget _buildResultList(BuildContext context, SymptomsResultPageVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();
        break;

      case LoadingProgress.DONE:
        return value.specialisations.length == 0
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 9,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleProvider.of(context).free_counseling),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearPercentIndicator(
                                  animation: true,
                                  progressColor: R.color.online_appointment,
                                  backgroundColor:
                                      R.color.grey.withOpacity(0.2),
                                  lineHeight: 20,
                                  animationDuration: 1100,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  percent: 0.95,
                                ),
                                Text(
                                  '% 95.0',
                                  style: context.xHeadline2.copyWith(
                                      color: getIt<ITheme>().mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      LocaleProvider.of(context).no_symptom_result,
                      style: context.xHeadline3.copyWith(
                          color: getIt<ITheme>()
                              .textColorSecondary
                              .withOpacity(0.5)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            : Center(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: value.specialisations.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${value.specialisations[index].name}',
                                style: context.xHeadline2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LinearPercentIndicator(
                                    animation: true,
                                    progressColor: getIt<ITheme>().mainColor,
                                    backgroundColor:
                                        R.color.grey.withOpacity(0.2),
                                    lineHeight: 20,
                                    animationDuration: 1100,
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    percent:
                                        (value.specialisations[index].accuracy /
                                            100),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: getIt<ITheme>().mainColor,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        //
                                        child: FlatButton(
                                          onPressed: () async {
                                            await value.loadNavigationData(value
                                                .specialisations[index].id);
                                            if (value.toNavigateDoctorsPageId !=
                                                null) {
                                              if (value.specialisations[index]
                                                      .id ==
                                                  null) {
                                                Atom.to(
                                                  PagePaths.RESOURCES,
                                                  queryParameters: {
                                                    'tenantId': '3',
                                                    'departmentId': '379',
                                                    'departmentName':
                                                        LocaleProvider.of(
                                                                context)
                                                            .free_consultation_appointment,
                                                    'fromOnlineAppo': 'false',
                                                  },
                                                );
                                              } else {
                                                Atom.to(PagePaths.RESOURCES,
                                                    queryParameters: {
                                                      'tenantId': '4',
                                                      'departmentId':
                                                          '${value.toNavigateDoctorsPageId}',
                                                      'departmentName': value
                                                          .specialisations[
                                                              index]
                                                          .name,
                                                      'fromOnlineAppo': 'false',
                                                    });
                                              }
                                            } else {
                                              Atom.to(
                                                PagePaths.RESOURCES,
                                                queryParameters: {
                                                  'tenantId': '3',
                                                  'departmentId': '379',
                                                  'departmentName': LocaleProvider
                                                          .of(context)
                                                      .free_consultation_appointment,
                                                  'fromOnlineAppo': 'false',
                                                },
                                              );
                                            }
                                          },
                                          child: Text(
                                            LocaleProvider.of(context)
                                                .create_appo,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.xHeadline4.copyWith(
                                                color:
                                                    getIt<ITheme>().textColor),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '%' +
                                        value.specialisations[index].accuracy
                                            .toStringAsFixed(1),
                                    style: context.xHeadline1.copyWith(
                                        color: getIt<ITheme>().mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
}
