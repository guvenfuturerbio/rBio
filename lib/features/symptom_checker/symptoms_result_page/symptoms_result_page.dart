import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/core/widgets/rbio_appbar.dart';
import 'package:onedosehealth/model/model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'symptoms_result_page_vm.dart';
import 'package:provider/provider.dart';

class SymptomsResultPage extends StatelessWidget {
  const SymptomsResultPage(
      {Key key,
      this.symptoms,
      this.gender,
      this.year_of_birth,
      this.isFromVoice});

  final List<GetBodySymptomsResponse> symptoms;
  final String gender;
  final String year_of_birth;
  final bool isFromVoice;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SymptomsResultPageVm(
          context: context,
          gender: this.gender,
          selectedSymptoms: this.symptoms,
          year_of_birth: this.year_of_birth,
          isFromVoice: this.isFromVoice),
      child: Consumer<SymptomsResultPageVm>(builder: (context, value, child) {
        return Scaffold(
          appBar: RbioAppBar(
            title: RbioAppBar.textTitle(
                context, LocaleProvider.of(context).results),
          ),
          body: value.progress == LoadingProgress.LOADING
              ? RbioLoading()
              : value.progress == LoadingProgress.DONE
                  ? value.specialisations.length == 0
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleProvider.of(context)
                                          .free_counseling),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          LinearPercentIndicator(
                                            animation: true,
                                            progressColor:
                                                R.color.online_appointment,
                                            backgroundColor:
                                                R.color.grey.withOpacity(0.2),
                                            lineHeight: 20,
                                            animationDuration: 1100,
                                            linearStrokeCap:
                                                LinearStrokeCap.roundAll,
                                            percent: 0.95,
                                            /*trailing: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: BlueGradient(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: FlatButton(
                                                  child: Text(
                                                    LocaleProvider.of(context)
                                                        .create_appo,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: R.color.white,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),*/
                                          ),
                                          Text(
                                            '% 95.0',
                                            style: TextStyle(
                                                color:
                                                    R.color.online_appointment,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
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
                                style: TextStyle(
                                    color: R.color.grey.withOpacity(0.5),
                                    fontSize: 18),
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
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${value.specialisations[index].name}'),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              LinearPercentIndicator(
                                                animation: true,
                                                progressColor:
                                                    R.color.online_appointment,
                                                backgroundColor: R.color.grey
                                                    .withOpacity(0.2),
                                                lineHeight: 20,
                                                animationDuration: 1100,
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                percent: (value
                                                        .specialisations[index]
                                                        .accuracy /
                                                    100),
                                                /*trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            BlueGradient(),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: FlatButton(
                                                      child: Text(
                                                        LocaleProvider.of(
                                                                context)
                                                            .create_appo,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                R.color.white,
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),*/
                                              ),
                                              Text(
                                                '%' +
                                                    value.specialisations[index]
                                                        .accuracy
                                                        .toStringAsFixed(1),
                                                style: TextStyle(
                                                    color: R.color
                                                        .online_appointment,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                  : Center(
                      child: Text('No Result'),
                    ),
        );
      }),
    );
  }
}
