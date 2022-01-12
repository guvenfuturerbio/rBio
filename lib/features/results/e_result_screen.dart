import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'e_result_vm.dart';

class EResultScreen extends StatelessWidget {
  const EResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EResultScreenVm>(
      builder: (BuildContext context, EResultScreenVm value, Widget child) {
        return RbioScaffold(
          appbar: _buildAppBar(context),
          body: _buildBody(context, value),
        );
      },
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.results,
      ),
    );
  }

  Widget _buildBody(BuildContext context, EResultScreenVm vm) {
    return Column(
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
        Expanded(
          child: _buildStateToWidget(context, vm),
        ),
      ],
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

  Widget _buildStateToWidget(BuildContext context, EResultScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        {
          return vm.visits.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: vm.visits.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RbioCardAppoCard.result(
                      date: DateTime.parse(vm.visits[index].openingDate)
                          .xFormatTime2(),
                      departmentName: vm.visits[index].department ?? '',
                      doctorName: vm.visits[index].physician ?? '',
                      tenantName: getTenantName(vm.visits[index].tenantId),
                      openDetailTap: vm.visits[index].hasLaboratoryResults ||
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

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
}
