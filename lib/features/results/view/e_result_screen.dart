import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../cubit/results_cubit.dart';
import '../model/model.dart';

class EResultScreen extends StatelessWidget {
  const EResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsCubit(getIt(), getIt())..fetchVisits(),
      child: const EResultView(),
    );
  }
}

class EResultView extends StatelessWidget {
  const EResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
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

  Widget _buildBody() {
    return BlocBuilder<ResultsCubit, ResultsState>(
      builder: (context, state) {
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
              margin: const EdgeInsets.only(top: 8, right: 8),
              child: GuvenDateRange(
                startCurrentDate: state.startDate,
                onStartDateChange: (date) {
                  if (!state.startDate.xIsSameDate(date)) {
                    context.read<ResultsCubit>().setStartDate(date);
                  }
                },
                endCurrentDate: state.endDate,
                onEndDateChange: (date) {
                  if (!state.endDate.xIsSameDate(date)) {
                    context.read<ResultsCubit>().setEndDate(date);
                  }
                },
                startMinDate: DateTime(1900).getStartOfTheDay,
                startMaxDate: DateTime.now().getStartOfTheDay,
                endMinDate: DateTime.now().getStartOfTheDay,
                endMaxDate: DateTime.now()
                    .add(const Duration(days: 365))
                    .getStartOfTheDay,
              ),
            ),

            //
            const SizedBox(height: 12.0),

            //
            Expanded(
              child: _buildStateToWidget(state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStateToWidget(ResultsState state) {
    switch (state.status) {
      case RbioLoadingProgress.initial:
        return const SizedBox();

      case RbioLoadingProgress.loadInProgress:
        return const RbioLoading();

      case RbioLoadingProgress.success:
        return state.visits.isNotEmpty
            ? _buildListView(state.visits)
            : RbioEmptyText(
                title: LocaleProvider.current.no_result_selected_date,
              );

      case RbioLoadingProgress.failure:
        return const RbioBodyError();
    }
  }

  Widget _buildListView(List<VisitResponse> visits) {
    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: visits.length,
      itemBuilder: (BuildContext context, int index) {
        final item = visits[index];

        return RbioCardAppoCard.result(
          date: visits[index].openingDate?.xGetUTCLocalDateTime() ?? '',
          departmentName: visits[index].department ?? '',
          doctorName: visits[index].physician ?? '',
          tenantName: getTenantName(item.tenantId),
          openDetailTap: (item.hasLaboratoryResults ?? false) ||
                  (item.hasRadiologyResults ?? false) ||
                  (item.hasPathologyResults ?? false)
              ? () {
                  Atom.to(
                    PagePaths.visitDetail,
                    queryParameters: {
                      'countOfRadiologyResults':
                          visits[index].countOfRadiologyResults.toString(),
                      'countOfPathologyResults':
                          visits[index].countOfPathologyResults.toString(),
                      'countOfLaboratoryResult':
                          visits[index].countOfLaboratoryResults.toString(),
                      'patientId': visits[index].patientId.toString(),
                      'visitId': visits[index].id.toString(),
                    },
                  );
                }
              : () {},
        );
      },
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
}
