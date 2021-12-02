import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';
import '../widgets/create_appo_widget.dart';
import '../widgets/history_doctor_image_widget.dart';

class CreateAppointmentScreen extends StatefulWidget {
  bool forOnline;

  CreateAppointmentScreen({Key key}) : super(key: key);

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentVm>(
      create: (context) => CreateAppointmentVm(
        context: context,
        forOnline: widget.forOnline,
      ),
      child: RbioScaffold(
        appbar: RbioAppBar(
          title: RbioAppBar.textTitle(
            context,
            LocaleProvider.current.title_appointment,
          ),
        ),

        //
        body: Consumer<CreateAppointmentVm>(
          builder: (
            BuildContext context,
            CreateAppointmentVm val,
            Widget child,
          ) {
            switch (val.progress) {
              case LoadingProgress.LOADING:
                return RbioLoading();

              case LoadingProgress.DONE:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        children: [
                          historyDoctorItem("Bengi Yılmaz", "deneme"),
                          SizedBox(
                            width: Atom.width * .03,
                          ),
                          historyDoctorItem("Cüneyt Akın", "deneme"),
                        ],
                      ),
                    ),

                    //
                    val.relativeProgress == LoadingProgress.LOADING
                        ? RbioLoading()
                        : CreateAppoWidget(
                            context: context,
                            header: LocaleProvider.current.appo_for,
                            hint: LocaleProvider.current.pls_select_person,
                            itemList: val.relativeResponse == null
                                ? []
                                : val.relativeResponse.patientRelatives,
                            val: val,
                            whichField: Fields.RELATIVE,
                            progress: val.relativeProgress,
                          ),

                    //
                    CreateAppoWidget(
                      context: context,
                      header: LocaleProvider.current.hosp_selection,
                      hint: widget.forOnline
                          ? LocaleProvider.current.get_online_appointment
                          : LocaleProvider.current.pls_select_hosp,
                      itemList: val.tenantsFilterResponse == null
                          ? []
                          : val.tenantsFilterResponse,
                      val: val,
                      whichField: Fields.TENANTS,
                      progress: val.progress,
                      isOnline: widget.forOnline,
                    ),

                    //
                    IgnorePointer(
                      ignoring: !val.hospitalSelected,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 1300),
                        curve: Curves.ease,
                        opacity: val.hospitalSelected ? 1 : 0,
                        child: val.departmentProgress == LoadingProgress.LOADING
                            ? RbioLoading()
                            : CreateAppoWidget(
                                context: context,
                                header: LocaleProvider.current.depart_selection,
                                hint: LocaleProvider.current.pls_select_depart,
                                itemList: val.filterDepartmentResponse == null
                                    ? []
                                    : val.filterDepartmentResponse,
                                val: val,
                                whichField: Fields.DEPARTMENT,
                                progress: val.departmentProgress,
                              ),
                      ),
                    ),

                    //
                    IgnorePointer(
                      ignoring:
                          !val.departmentSelected || !val.hospitalSelected,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 1300),
                        curve: Curves.ease,
                        opacity: val.departmentSelected && val.hospitalSelected
                            ? 1
                            : 0,
                        child: val.doctorProgress == LoadingProgress.LOADING
                            ? RbioLoading()
                            : CreateAppoWidget(
                                context: context,
                                header: LocaleProvider.current.doctor_selection,
                                hint: LocaleProvider.current.pls_select_doctor,
                                itemList: val.filterResourcesResponse == null
                                    ? []
                                    : val.filterResourcesResponse,
                                val: val,
                                whichField: Fields.DOCTORS,
                                progress: val.doctorProgress,
                              ),
                      ),
                    ),

                    //
                    Expanded(
                      child: Column(
                        children: [
                          //
                          Expanded(
                            child: Visibility(
                              visible: val.doctorSelected,
                              child: Center(
                                child: RbioElevatedButton(
                                  title: LocaleProvider.current.create_appo,
                                  onTap: () {
                                    Atom.to(
                                      PagePaths.CREATE_APPOINTMENT_EVENTS,
                                      queryParameters: {
                                        'patientId': Uri.encodeFull(val.dropdownValueRelative.id),
                                        'patientName': Uri.encodeFull(
                                            '${val.dropdownValueRelative.name} ${val.dropdownValueRelative.surname}'),
                                        'tenantId': val.dropdownValueTenant.id
                                            .toString(),
                                        'tenantName': Uri.encodeFull(val
                                            .dropdownValueTenant.title
                                            .toString()),
                                        'departmentId': val
                                            .dropdownValueDepartment.id
                                            .toString(),
                                        'departmentName': Uri.encodeFull(val
                                            .dropdownValueDepartment.title
                                            .toString()),
                                        'resourceId': val.dropdownValueDoctor.id
                                            .toString(),
                                        'resourceName': Uri.encodeFull(val
                                            .dropdownValueDoctor.title
                                            .toString()),
                                        'forOnline':
                                            widget.forOnline.toString(),
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          //
                          Expanded(
                            child: Column(
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
                                  height: Atom.height * .05,
                                  child: Center(
                                    child: RbioElevatedButton(
                                      onTap: () {
                                        Atom.to(PagePaths.SYMPTOM_MAIN_MENU);
                                      },
                                      title:
                                          LocaleProvider.current.depart_analyse,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

              case LoadingProgress.ERROR:
                return RbioBodyError();

              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
