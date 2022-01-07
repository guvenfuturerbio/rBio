import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';
import '../widgets/create_appo_widget.dart';

part '../widgets/history_doctor_card.dart';

// ignore: must_be_immutable
class CreateAppointmentScreen extends StatelessWidget {
  bool forOnline;
  bool fromSearch = false;
  int departmentId;
  //String departmentName;
  //String doctorName;
  int resourceId;
  int tenantId;

  CreateAppointmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      forOnline = Atom.queryParameters['forOnline'] == 'true';
      if (Atom.queryParameters['fromSearch'] == 'true') {
        this.fromSearch = true;
        this.tenantId = int.parse(Atom.queryParameters['tenantId']) ?? 0;
        this.departmentId =
            int.parse(Atom.queryParameters['departmentId']) ?? 0;
        this.resourceId = int.parse(Atom.queryParameters['resourceId']) ?? 0;
      } else {
        fromSearch = false;
      }
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentVm>(
      create: (context) => CreateAppointmentVm(
          context: context,
          forOnline: forOnline,
          fromSearch: fromSearch,
          tenantId: tenantId,
          departmentId: departmentId,
          resourceId: resourceId),
      child: Consumer<CreateAppointmentVm>(
        builder: (
          BuildContext context,
          CreateAppointmentVm vm,
          Widget child,
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
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildSuccess(context, vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
  // #endregion

  Widget _buildSuccess(BuildContext context, CreateAppointmentVm vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleProvider.current.favorites,
              style: context.xHeadline3,
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: vm.holderForFavorites
                  .map(
                    (item) => _buildHistoryDoctorCard(
                      context,
                      item.resources.first.resource,
                      vm,
                      vm.holderForFavorites.indexOf(item),
                    ),
                  )
                  .toList(),
            ),
          ),

          //
          vm.relativeProgress == LoadingProgress.LOADING
              ? RbioLoading()
              : CreateAppoWidget(
                  context: context,
                  header: LocaleProvider.current.appo_for,
                  hint: LocaleProvider.current.pls_select_person,
                  itemList: vm.relativeResponse == null
                      ? []
                      : vm.relativeResponse.patientRelatives,
                  val: vm,
                  whichField: Fields.RELATIVE,
                  progress: vm.relativeProgress,
                ),

          //
          CreateAppoWidget(
            context: context,
            header: LocaleProvider.current.hosp_selection,
            hint: forOnline
                ? LocaleProvider.current.get_online_appointment
                : LocaleProvider.current.pls_select_hosp,
            itemList: vm.tenantsFilterResponse == null
                ? []
                : vm.tenantsFilterResponse,
            val: vm,
            whichField: Fields.TENANTS,
            progress: vm.progress,
            isOnline: forOnline,
          ),

          //
          IgnorePointer(
            ignoring: !vm.hospitalSelected,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1300),
              curve: Curves.ease,
              opacity: vm.hospitalSelected ? 1 : 0,
              child: vm.departmentProgress == LoadingProgress.LOADING
                  ? RbioLoading()
                  : CreateAppoWidget(
                      context: context,
                      header: LocaleProvider.current.depart_selection,
                      hint: LocaleProvider.current.pls_select_depart,
                      itemList: vm.filterDepartmentResponse == null
                          ? []
                          : vm.filterDepartmentResponse,
                      val: vm,
                      whichField: Fields.DEPARTMENT,
                      progress: vm.departmentProgress,
                    ),
            ),
          ),

          //
          IgnorePointer(
            ignoring: !vm.departmentSelected || !vm.hospitalSelected,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 1300),
              curve: Curves.ease,
              opacity: vm.departmentSelected && vm.hospitalSelected ? 1 : 0,
              child: vm.doctorProgress == LoadingProgress.LOADING
                  ? RbioLoading()
                  : CreateAppoWidget(
                      context: context,
                      header: LocaleProvider.current.doctor_selection,
                      hint: LocaleProvider.current.pls_select_doctor,
                      itemList: vm.filterResourcesResponse == null
                          ? []
                          : vm.filterResourcesResponse,
                      val: vm,
                      whichField: Fields.DOCTORS,
                      progress: vm.doctorProgress,
                    ),
            ),
          ),

          //
          vm.doctorSelected
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RbioElevatedButton(
                        title: LocaleProvider.current.create_appo,
                        onTap: () {
                          _openCreateAppointmentsEvents(vm);
                        },
                      ),
                    ),
                    R.sizes.defaultBottomPadding,
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Center(
                        child: Text(
                          LocaleProvider.current.which_depart_i_go,
                          style: context.xHeadline3,
                        ),
                      ),
                    ),
                    SizedBox(
                      //height: Atom.height * .05,
                      child: Center(
                        child: RbioElevatedButton(
                          onTap: () {
                            Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
                          },
                          title: LocaleProvider.current.depart_analyse,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  void _openCreateAppointmentsEvents(CreateAppointmentVm val) {
    Atom.to(
      PagePaths.CREATE_APPOINTMENT_EVENTS,
      queryParameters: {
        'patientId': Uri.encodeFull(val.dropdownValueRelative.id),
        'patientName': Uri.encodeFull(
            '${val.dropdownValueRelative.name} ${val.dropdownValueRelative.surname}'),
        'tenantId': val.dropdownValueTenant.id.toString(),
        'tenantName': Uri.encodeFull(val.dropdownValueTenant.title.toString()),
        'departmentId': val.dropdownValueDepartment.id.toString(),
        'departmentName':
            Uri.encodeFull(val.dropdownValueDepartment.title.toString()),
        'resourceId': val.dropdownValueDoctor.id.toString(),
        'resourceName':
            Uri.encodeFull(val.dropdownValueDoctor.title.toString()),
        'forOnline': forOnline.toString(),
      },
    );
  }
}
