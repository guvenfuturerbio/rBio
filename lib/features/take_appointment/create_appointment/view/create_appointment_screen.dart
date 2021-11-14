import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_vm.dart';
import '../widgets/create_appo_widget.dart';
import '../widgets/history_doctor_image_widget.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({Key key}) : super(key: key);

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
            context, LocaleProvider.current.title_appointment),
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
                      "Favoriler",
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
                  CreateAppoWidget(
                    context: context,
                    header: "Randevu alınacak kişi:",
                    hint: "Please select",
                    itemList: ["EYC", "Kişi 1", "Kişi 2"],
                    val: val,
                    whichField: Fields.BEGIN,
                    progress: LoadingProgress.DONE,
                  ),

                  //
                  CreateAppoWidget(
                    context: context,
                    header: "Hastane seçimi:",
                    hint: "Please select hospital",
                    itemList: val.tenantsFilterResponse == null
                        ? []
                        : val.tenantsFilterResponse,
                    val: val,
                    whichField: Fields.TENANTS,
                    progress: val.progress,
                  ),

                  //
                  IgnorePointer(
                    ignoring: !val.hospitalSelected,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                      opacity: val.hospitalSelected ? 1 : 0,
                      child: val.departmentProgress == LoadingProgress.LOADING
                          ? RbioLoading()
                          : CreateAppoWidget(
                              context: context,
                              header: "Bölüm seçimi:",
                              hint: "Please select department",
                              itemList: val.filterDepartmentResponse == null
                                  ? []
                                  : val.filterDepartmentResponse,
                              val: val,
                              whichField: Fields.DEPARTMENT,
                              progress: val.departmentProgress),
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
                          : CreateAppoWidget(
                              context: context,
                              header: "Doktor seçimi:",
                              hint: "Please select doctor",
                              itemList: val.filterResourcesResponse == null
                                  ? []
                                  : val.filterResourcesResponse,
                              val: val,
                              whichField: Fields.DOCTORS,
                              progress: val.doctorProgress),
                    ),
                  ),

                  //
                  Spacer(flex: 3),

                  //
                  Center(
                    child: Text(
                      "Hangi bölüme gideceğimiz bilmiyorum",
                      style: context.xHeadline5,
                    ),
                  ),

                  //
                  Expanded(
                    child: SizedBox(
                      height: Atom.height * .05,
                      child: Center(
                        child: RbioElevatedButton(
                          onTap: val.departmentSelected &&
                                  val.hospitalSelected &&
                                  val.doctorSelected
                              ? () {
                                  Atom.to(PagePaths.CREATE_APPOINTMENT_EVENTS);
                                }
                              : null,
                          title: "Bölüm Analizi",
                        ),
                      ),
                    ),
                  ),

                  //
                  Spacer(),
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
