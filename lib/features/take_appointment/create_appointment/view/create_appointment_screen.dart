import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';
import '../widgets/create_appo_widget.dart';

part '../widgets/history_doctor_card.dart';

class CreateAppointmentScreen extends StatelessWidget {
  late bool forOnline;
  late bool fromSearch = false;
  late bool fromSymptom = false;
  int? departmentId;
  int? resourceId;
  int? tenantId;

  CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      forOnline = Atom.queryParameters['forOnline'] == 'true';
      if (Atom.queryParameters['fromSearch'] == 'true') {
        fromSearch = true;
        tenantId = int.parse(Atom.queryParameters['tenantId']!);
        departmentId = int.parse(Atom.queryParameters['departmentId']!);
        resourceId = int.parse(Atom.queryParameters['resourceId']!);
      } else {
        fromSearch = false;
      }

      if (Atom.queryParameters['fromSymptom'] == 'true') {
        fromSymptom = true;
        tenantId = int.parse(Atom.queryParameters['tenantId']!);
        departmentId = int.parse(Atom.queryParameters['departmentId']!);
      } else {
        fromSymptom = false;
      }
    } catch (_) {
      return const RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentVm>(
      create: (context) => CreateAppointmentVm(
        mContext: context,
        forOnline: forOnline,
        fromSearch: fromSearch,
        fromSymptom: fromSymptom,
        tenantId: tenantId,
        departmentId: departmentId,
        resourceId: resourceId,
      ),
      child: Consumer<CreateAppointmentVm>(
        builder: (
          BuildContext context,
          CreateAppointmentVm vm,
          Widget? child,
        ) {
          return RbioScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(context, vm),
          );
        },
      ),
    );
  }

  // #region _buildAppBar
  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      leading: Align(
        alignment: Alignment.center,
        child: InkWell(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
            child: SvgPicture.asset(
              R.image.back,
              width: R.sizes.iconSize,
            ),
          ),
          onTap: () {
            fromSymptom ? Atom.to(PagePaths.main) : Atom.historyBack();
          },
        ),
      ),
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.title_appointment,
      ),
    );
  }
  // #endregion

  // #region _buildBody
  Widget _buildBody(BuildContext context, CreateAppointmentVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return _buildSuccess(context, vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
  // #endregion

  Widget _buildSuccess(BuildContext context, CreateAppointmentVm vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleProvider.current.recent_appointments,
                    style: context.xHeadline3,
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: vm.holderForFavorites
                        .map(
                          (item) => _buildHistoryDoctorCard(
                            context,
                            item.resources?.first.resource,
                            vm,
                            vm.holderForFavorites.indexOf(item),
                          ),
                        )
                        .toList(),
                  ),
                ),

                //
                vm.relativeProgress == LoadingProgress.loading
                    ? const RbioLoading()
                    : createAppoWidget(
                        context: context,
                        header: LocaleProvider.current.appo_for,
                        hint: LocaleProvider.current.pls_select_person,
                        itemList: vm.relativeResponse == null
                            ? []
                            : vm.relativeResponse!.patientRelatives,
                        val: vm,
                        whichField: Fields.relative,
                        progress: vm.relativeProgress,
                      ),

                //
                createAppoWidget(
                  context: context,
                  header: LocaleProvider.current.hosp_selection,
                  hint: forOnline
                      ? LocaleProvider.current.get_online_appointment
                      : LocaleProvider.current.pls_select_hosp,
                  itemList: vm.tenantsFilterResponse ?? [],
                  val: vm,
                  whichField: Fields.tenant,
                  progress: vm.progress,
                  isOnline: forOnline,
                ),

                //
                IgnorePointer(
                  ignoring: !vm.hospitalSelected,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1300),
                    curve: Curves.ease,
                    opacity: vm.hospitalSelected ? 1 : 0,
                    child: vm.departmentProgress == LoadingProgress.loading
                        ? const RbioLoading()
                        : createAppoWidget(
                            context: context,
                            header: LocaleProvider.current.depart_selection,
                            hint: LocaleProvider.current.pls_select_depart,
                            itemList: vm.filterDepartmentResponse!,
                            val: vm,
                            whichField: Fields.department,
                            progress: vm.departmentProgress,
                          ),
                  ),
                ),

                //
                IgnorePointer(
                  ignoring: !vm.departmentSelected || !vm.hospitalSelected,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1300),
                    curve: Curves.ease,
                    opacity:
                        vm.departmentSelected && vm.hospitalSelected ? 1 : 0,
                    child: vm.doctorProgress == LoadingProgress.loading
                        ? const RbioLoading()
                        : createAppoWidget(
                            context: context,
                            header: LocaleProvider.current.doctor_selection,
                            hint: LocaleProvider.current.pls_select_doctor,
                            itemList: vm.filterResourceResponse!,
                            val: vm,
                            whichField: Fields.doctors,
                            progress: vm.doctorProgress,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //
        Container(
          color: Colors.transparent,
          width: double.infinity,
          child: Column(
            children: [
              //
              ...vm.doctorSelected
                  ? [
                      RbioElevatedButton(
                        title: LocaleProvider.current.create_appo,
                        onTap: () async {
                          await _openCreateAppointmentsEvents(vm);
                        },
                        infinityWidth: true,
                      ),
                      R.sizes.defaultBottomPadding,
                    ]
                  : [
                      if (getIt<IAppConfig>().productType ==
                          ProductType.oneDose) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Center(
                            child: Text(
                              LocaleProvider.current.which_depart_i_go,
                              style: context.xHeadline3,
                            ),
                          ),
                        ),
                        RbioElevatedButton(
                          onTap: () {
                            Atom.to(PagePaths.symptomMainMenu);
                          },
                          title: LocaleProvider.current.depart_analyse,
                          infinityWidth: true,
                        ),
                        R.sizes.defaultBottomPadding,
                      ],
                    ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openCreateAppointmentsEvents(CreateAppointmentVm val) async {
    try {
      await getIt<FirebaseAnalyticsManager>().logEvent(
          RandevuOlusturRandevuAraEvent(
              getIt<UserNotifier>().firebaseEmail,
              val.dropdownValueTenant!.title.toString(),
              val.dropdownValueDepartment!.title.toString(),
              val.dropdownValueDoctor!.id));
      getIt<AdjustManager>().trackEvent(SearchCreateAppointmentEvent());
    } catch (e) {
      LoggerUtils.instance.wtf('wtf');
    }

    Atom.to(
      PagePaths.createAppointmentEvents,
      queryParameters: {
        'patientName': Uri.encodeFull(
            '${val.dropdownValueRelative?.name ?? ""} ${val.dropdownValueRelative?.surname}'),
        'tenantId': val.dropdownValueTenant!.id!.toString(),
        'tenantName': Uri.encodeFull(val.dropdownValueTenant!.title.toString()),
        'departmentId': val.dropdownValueDepartment!.id.toString(),
        'departmentName':
            Uri.encodeFull(val.dropdownValueDepartment!.title.toString()),
        'resourceId': val.dropdownValueDoctor!.id.toString(),
        'resourceName':
            Uri.encodeFull(val.dropdownValueDoctor!.title.toString()),
        'forOnline': forOnline.toString(),
      },
    );
  }
}
