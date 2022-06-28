import 'package:flutter/material.dart';
import 'package:onedosehealth/app/bluetooth_v2/bluetooth_v2.dart';
import 'package:onedosehealth/features/results/cubit/results_cubit.dart';

import '../../../../core/core.dart';

class EResultScreen extends StatelessWidget {
  const EResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsCubit(getIt())..fetchVisits(),
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
        return state.when(
            initial: () => const SizedBox(),
            loadInProgress: () => const RbioLoading(),
            success: (result) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    Text(
                      LocaleProvider.current.date_filter,
                      style: context.xHeadline1,
                    ),

                    //  startMinDate: DateTime(1900).getStartOfTheDay,
                    //     startMaxDate: DateTime.now().getStartOfTheDay,
                    //     endMinDate: DateTime.now().getStartOfTheDay,
                    //     endMaxDate:
                    //         DateTime.now().add(const Duration(days: 365)).getStartOfTheDay,

                    //
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      child: GuvenDateRange(
                        startCurrentDate: result.startDate!,
                        onStartDateChange: (date) {
                          if (!result.startDate!.xIsSameDate(date)) {
                            context.read<ResultsCubit>().setStartDate(date);
                          }
                        },
                        endCurrentDate: result.endDate ?? DateTime.now(),
                        onEndDateChange: (date) {
                          if (!result.endDate!.xIsSameDate(date)) {
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
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: R.sizes.defaultBottomValue,
                        ),
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: result.visits!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = result.visits![index];

                          return RbioCardAppoCard.result(
                            date: result.visits?[index].openingDate
                                    ?.xGetUTCLocalDateTime() ??
                                '',
                            //DateTime.parse(item.openingDate ?? '').xFormatTime2(),
                            departmentName:
                                result.visits?[index].department ?? '',
                            doctorName: result.visits?[index].physician ?? '',
                            tenantName: getTenantName(item.tenantId),
                            openDetailTap: (item.hasLaboratoryResults ??
                                        false) ||
                                    (item.hasRadiologyResults ?? false) ||
                                    (item.hasPathologyResults ?? false)
                                ? () {
                                    Atom.to(
                                      PagePaths.visitDetail,
                                      queryParameters: {
                                        'countOfRadiologyResults': result
                                            .visits![index]
                                            .countOfRadiologyResults
                                            .toString(),
                                        'countOfPathologyResults': result
                                            .visits![index]
                                            .countOfPathologyResults
                                            .toString(),
                                        'countOfLaboratoryResult': result
                                            .visits![index]
                                            .countOfLaboratoryResults
                                            .toString(),
                                        'patientId': result
                                            .visits![index].patientId
                                            .toString(),
                                        'visitId':
                                            result.visits![index].id.toString(),
                                      },
                                    );
                                  }
                                : () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
            failure: () => const RbioBodyError());
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

  // Widget _buildStateToWidget(BuildContext context, EResultScreenVm vm) {
  //   switch (vm.progress) {
  //     case LoadingProgress.loading:
  //       return const RbioLoading();

  //     case LoadingProgress.done:
  //       {
  //         return vm.visits.isNotEmpty
  //             ? _buildListView(vm)
  //             : RbioEmptyText(
  //                 title: LocaleProvider.current.no_result_selected_date,
  //               );
  //       }

  //     case LoadingProgress.error:
  //       return const RbioBodyError();

  //     default:
  //       return const SizedBox();
  //   }
  // }

  // Widget _buildListView(EResultScreenVm vm) {

  // }

}
