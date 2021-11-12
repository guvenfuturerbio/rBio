import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<EResultScreenVm>(
      builder: (BuildContext context, EResultScreenVm value, Widget child) {
        return Scaffold(
          appBar: RbioAppBar(
            title:
                RbioAppBar.textTitle(context, LocaleProvider.current.results),
          ),
          body: _buildBody(value),
        );
      },
    );
  }

  Widget _buildBody(EResultScreenVm vm) {
    return Padding(
      padding: R.sizes.screenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Text(
            LocaleProvider.current.date_filter,
            style: context.xHeadline1,
          ),

          //
          Container(
            margin: EdgeInsets.only(left: 8, top: 8, right: 8),
            child: GuvenDateRange(
              startCurrentDate: vm.startDate,
              onStartDateChange: (date) {
                vm.setStartDate(date);
              },
              endCurrentDate: vm.endDate,
              onEndDateChange: (date) {
                vm.setEndDate(date);
              },
            ),
          ),

          //
          SizedBox(height: 12.0),

          //
          Expanded(child: _buildStateToWidget(vm)),
        ],
      ),
    );
  }

  String getTenantName(int tenantId) {
    if (tenantId == 1) {
      return LocaleProvider.current.guven_hospital_ayranci;
    } else if (tenantId == 7) {
      return LocaleProvider.current.guven_cayyolu_campus;
    }

    return LocaleProvider.current.online_hospital;
  }

  Widget _buildStateToWidget(EResultScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.DONE:
        {
          return vm.visits.length > 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: vm.visits.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RbioCardAppoCard.result(
                      date: getFormattedDate(vm.visits[index].openingDate),
                      departmentName: vm.visits[index].department ?? '',
                      doctorName: vm.visits[index].physician ?? '',
                      tenantName: getTenantName(vm.visits[index].tenantId),
                      onTap: vm.visits[index].hasLaboratoryResults ||
                              vm.visits[index].hasRadiologyResults ||
                              vm.visits[index].hasPathologyResults
                          ? () {
                              Atom.to(
                                PagePaths.VISIT_DETAIL,
                                queryParameters: {
                                  'countOfRadiologyResults': vm
                                      .visits[index].countOfRadiologyResults
                                      .toString(),
                                  'countOfPathologyResults': vm
                                      .visits[index].countOfPathologyResults
                                      .toString(),
                                  'countOfLaboratoryResult': vm
                                      .visits[index].countOfLaboratoryResults
                                      .toString(),
                                  'patientId':
                                      vm.visits[index].patientId.toString(),
                                  'visitId': vm.visits[index].id.toString(),
                                },
                              );
                            }
                          : null,
                    );
                  },
                )
              : Center(
                  child: Text(
                    LocaleProvider.current.no_result_selected_date,
                    textAlign: TextAlign.center,
                    style: context.xHeadline1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
        }

      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.ERROR:
        return RbioError();

      default:
        return SizedBox();
    }
  }
}
