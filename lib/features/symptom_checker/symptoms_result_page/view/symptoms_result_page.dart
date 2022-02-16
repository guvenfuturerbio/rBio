import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/symptoms_result_page_vm.dart';

class SymptomsResultPage extends StatefulWidget {
  late List<GetBodySymptomsResponse>? symptoms;
  late String? gender;
  late String? yearOfBirth;
  late bool? isFromVoice;

  SymptomsResultPage({
    Key? key,
    this.symptoms,
    this.gender,
    this.yearOfBirth,
    this.isFromVoice,
  }) : super(key: key);

  @override
  State<SymptomsResultPage> createState() => _SymptomsResultPageState();
}

class _SymptomsResultPageState extends State<SymptomsResultPage> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.symptoms = RbioConfig.of(context)?.listBodySympRsp
          as List<GetBodySymptomsResponse>;
      widget.gender = Atom.queryParameters['gender'];
      widget.yearOfBirth = Atom.queryParameters['year_of_birth'];
      widget.isFromVoice = Atom.queryParameters['isFromVoice'] == 'true';
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider(
      create: (context) => SymptomsResultPageVm(
        context: context,
        gender: widget.gender as String,
        selectedSymptoms: widget.symptoms as List<GetBodySymptomsResponse>,
        yearOfBirth: widget.yearOfBirth as String,
        isFromVoice: widget.isFromVoice as bool,
      ),
      child: Consumer<SymptomsResultPageVm>(
        builder: (context, value, child) {
          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildResultList(context, value),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).results,
      ),
    );
  }

  Widget _buildResultList(BuildContext context, SymptomsResultPageVm value) {
    switch (value.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return value.specialisations.isEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: R.sizes.defaultElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                LocaleProvider.of(context).free_counseling,
                                style: context.xHeadline2,
                              ),
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
                                  barRadius: const Radius.circular(25),
                                  animationDuration: 1100,
                                  percent: 0.95,
                                  trailing: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: getIt<ITheme>().mainColor,
                                        borderRadius:
                                            R.sizes.borderRadiusCircular,
                                      ),
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      //
                                      child: RbioTextButton(
                                        onPressed: () {
                                          Atom.to(
                                            PagePaths.createAppointment,
                                            queryParameters: {
                                              'forOnline': true.toString(),
                                              'fromSearch': false.toString(),
                                              'fromSymptom': true.toString(),
                                              'tenantId': '256',
                                              'departmentId': '132',
                                              'departmentName': LocaleProvider
                                                      .of(context)
                                                  .free_consultation_appointment,
                                            },
                                          );
                                        },
                                        child: Text(
                                          LocaleProvider.of(context)
                                              .create_appo,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.xHeadline4.copyWith(
                                              color: getIt<ITheme>().textColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
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
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: value.specialisations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: R.sizes.defaultElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: R.sizes.borderRadiusCircular,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Text(
                            value.specialisations[index].id == 15
                                ? LocaleProvider
                                    .current.free_consultation_appointment
                                : '${value.specialisations[index].name}',
                            style: context.xHeadline2,
                          ),

                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LinearPercentIndicator(
                                animation: true,
                                progressColor: getIt<ITheme>().mainColor,
                                backgroundColor: R.color.grey.withOpacity(0.2),
                                lineHeight: 20,
                                animationDuration: 1100,
                                barRadius: const Radius.circular(25),
                                percent:
                                    (value.specialisations[index].accuracy /
                                        100),
                                trailing: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getIt<ITheme>().mainColor,
                                      borderRadius:
                                          R.sizes.borderRadiusCircular,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: RbioTextButton(
                                      onPressed: () async {
                                        await value.loadNavigationData(value
                                            .specialisations[index].id as int);
                                        if (value.toNavigateDoctorsPageId !=
                                            null) {
                                          if (value.specialisations[index].id ==
                                              null) {
                                            Atom.to(
                                              PagePaths.createAppointment,
                                              queryParameters: {
                                                'forOnline': true.toString(),
                                                'fromSearch': false.toString(),
                                                'fromSymptom': true.toString(),
                                                'tenantId': '256',
                                                'departmentId': '132',
                                                'departmentName': LocaleProvider
                                                        .of(context)
                                                    .free_consultation_appointment,
                                              },
                                            );
                                          } else {
                                            Atom.to(PagePaths.createAppointment,
                                                queryParameters: {
                                                  'forOnline': false.toString(),
                                                  'fromSearch':
                                                      false.toString(),
                                                  'fromSymptom':
                                                      true.toString(),
                                                  'tenantId': '1',
                                                  'departmentId':
                                                      '${value.toNavigateDoctorsPageId}',
                                                  'departmentName': value
                                                      .specialisations[index]
                                                      .name as String,
                                                });
                                          }
                                        } else {
                                          Atom.to(
                                            PagePaths.createAppointment,
                                            queryParameters: {
                                              'forOnline': true.toString(),
                                              'fromSearch': false.toString(),
                                              'fromSymptom': true.toString(),
                                              'tenantId': '256',
                                              'departmentId': '132',
                                              'departmentName': LocaleProvider
                                                      .of(context)
                                                  .free_consultation_appointment,
                                            },
                                          );
                                        }
                                      },
                                      child: Text(
                                        LocaleProvider.of(context).create_appo,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.xHeadline4.copyWith(
                                          color: getIt<ITheme>().textColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //
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
                  );
                },
              );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
