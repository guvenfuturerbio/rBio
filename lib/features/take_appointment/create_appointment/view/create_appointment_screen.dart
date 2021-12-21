import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';
import '../widgets/create_appo_widget.dart';
import '../widgets/history_doctor_image_widget.dart';

// ignore: must_be_immutable
class CreateAppointmentScreen extends StatelessWidget {
  bool forOnline;

  CreateAppointmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentVm>(
      create: (context) => CreateAppointmentVm(
        context: context,
        forOnline: forOnline,
      ),
      child: Consumer<CreateAppointmentVm>(
        builder: (
          BuildContext context,
          CreateAppointmentVm vm,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.current.title_appointment,
              ),
            ),
            body: _buildBody(context, vm),
          );
        },
      ),
    );
  }

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

  Widget _buildSuccess(BuildContext context, CreateAppointmentVm vm) {
    return Column(
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
                  (item) => historyDoctorItem(
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
          itemList:
              vm.tenantsFilterResponse == null ? [] : vm.tenantsFilterResponse,
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
        Expanded(
          child: vm.doctorSelected
              ? Center(
                  child: RbioElevatedButton(
                    title: LocaleProvider.current.create_appo,
                    onTap: () {
                      _openCreateAppointmentsEvents(vm);
                    },
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
        ),
      ],
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
