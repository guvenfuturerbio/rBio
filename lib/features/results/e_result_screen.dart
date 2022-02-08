import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'e_result_vm.dart';

class EResultScreen extends StatelessWidget {
  const EResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EResultScreenVm>(
      builder: (BuildContext context, EResultScreenVm value, Widget? child) {
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
          margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
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
        const SizedBox(height: 12.0),

        //
        Expanded(
          child: _buildStateToWidget(context, vm),
        ),
      ],
    );
  }

  String getTenantName(int? tenantId) {
    if (tenantId == 1) {
      return LocaleProvider.current.guven_hospital_ayranci;
    } else if (tenantId == 7) {
      return LocaleProvider.current.guven_cayyolu_campus;
    }

    return LocaleProvider.current.online_hospital;
  }

  Widget _buildStateToWidget(BuildContext context, EResultScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        {
          return vm.visits.isNotEmpty
              ? _buildListView(vm)
              : RbioEmptyText(
                  title: LocaleProvider.current.no_result_selected_date,
                );
        }

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildListView(EResultScreenVm vm) {
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: vm.visits.length,
      itemBuilder: (BuildContext context, int index) {
        final item = vm.visits[index];

        return RbioCardAppoCard.result(
          date: DateTime.parse(item.openingDate ?? '').xFormatTime2(),
          departmentName: vm.visits[index].department ?? '',
          doctorName: vm.visits[index].physician ?? '',
          tenantName: getTenantName(item.tenantId),
          openDetailTap: (item.hasLaboratoryResults ?? false) ||
                  (item.hasRadiologyResults ?? false) ||
                  (item.hasPathologyResults ?? false)
              ? () {
                  Atom.to(
                    PagePaths.visitDetail,
                    queryParameters: {
                      'countOfRadiologyResults':
                          vm.visits[index].countOfRadiologyResults.toString(),
                      'countOfPathologyResults':
                          vm.visits[index].countOfPathologyResults.toString(),
                      'countOfLaboratoryResult':
                          vm.visits[index].countOfLaboratoryResults.toString(),
                      'patientId': vm.visits[index].patientId.toString(),
                      'visitId': vm.visits[index].id.toString(),
                    },
                  );
                }
              : () {},
        );
      },
    );
  }
}
