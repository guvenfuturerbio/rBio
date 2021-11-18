import 'package:flutter/material.dart';
import 'package:onedosehealth/features/take_appointment/create_appointment/widgets/history_doctor_image_widget.dart';
import 'package:onedosehealth/features/take_appointment/create_online_appointment/viewmodel/create_online_appointment_screen_vm.dart';
import 'package:onedosehealth/features/take_appointment/create_online_appointment/widgets/create_online_appo_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';

class CreateOnlineAppointmentScreen extends StatefulWidget {
  const CreateOnlineAppointmentScreen({Key key}) : super(key: key);

  @override
  _CreateOnlineAppointmentScreenState createState() =>
      _CreateOnlineAppointmentScreenState();
}

class _CreateOnlineAppointmentScreenState
    extends State<CreateOnlineAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
            context, LocaleProvider.current.title_appointment),
      ),

      //
      body: Consumer<CreateOnlineAppointmentVm>(
        builder: (
          BuildContext context,
          CreateOnlineAppointmentVm val,
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
                  CreateOnlineAppoWidget(
                      context: context,
                      header: LocaleProvider.current.appo_for,
                      hint: LocaleProvider.current.pls_select_person,
                      itemList: ["EYC", "Kişi 1", "Kişi 2"],
                      val: val,
                      whichField: Fields.BEGIN,
                      progress: LoadingProgress.DONE,
                      isOnline: false),

                  //
                  CreateOnlineAppoWidget(
                      context: context,
                      header: LocaleProvider.current.hosp_selection,
                      hint: LocaleProvider.current.pls_select_hosp,
                      itemList: [LocaleProvider.current.online_appo],
                      val: val,
                      whichField: Fields.TENANTS,
                      progress: val.progress,
                      isOnline: true),

                  //
                  IgnorePointer(
                    ignoring: !val.hospitalSelected,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                      opacity: val.hospitalSelected ? 1 : 0,
                      child: val.departmentProgress == LoadingProgress.LOADING
                          ? RbioLoading()
                          : CreateOnlineAppoWidget(
                              context: context,
                              header: LocaleProvider.current.depart_selection,
                              hint: LocaleProvider.current.pls_select_depart,
                              itemList: val.filterDepartmentResponse == null
                                  ? []
                                  : val.filterDepartmentResponse,
                              val: val,
                              whichField: Fields.DEPARTMENT,
                              progress: val.departmentProgress,
                              isOnline: false),
                    ),
                  ),

                  //
                  IgnorePointer(
                    ignoring: !val.departmentSelected || !val.hospitalSelected,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                      opacity: val.departmentSelected && val.hospitalSelected
                          ? 1
                          : 0,
                      child: val.doctorProgress == LoadingProgress.LOADING
                          ? RbioLoading()
                          : CreateOnlineAppoWidget(
                              context: context,
                              header: LocaleProvider.current.doctor_selection,
                              hint: LocaleProvider.current.pls_select_doctor,
                              itemList: val.filterResourcesResponse == null
                                  ? []
                                  : val.filterResourcesResponse,
                              val: val,
                              whichField: Fields.DOCTORS,
                              progress: val.doctorProgress,
                              isOnline: false),
                    ),
                  ),

                  //
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Visibility(
                              visible: val.doctorSelected,
                              child: Center(
                                  child: RbioElevatedButton(
                                      title: LocaleProvider.current.create_appo,
                                      onTap: () {
                                        Atom.to(PagePaths
                                            .CREATE_APPOINTMENT_EVENTS);
                                      }))),
                        ),
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
                                      title: LocaleProvider
                                          .current.depart_analyse),
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
              return RbioError();

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
