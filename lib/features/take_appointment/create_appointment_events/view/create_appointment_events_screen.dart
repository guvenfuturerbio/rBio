import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/create_appointment_events_vm.dart';

part '../model/event_selected_model.dart';
part '../model/event.dart';
part '../widgets/list_body.dart';
part '../widgets/table_calendar.dart';

class CreateAppointmentEventsScreen extends StatefulWidget {
  String patientId;
  String patientName;
  int tenantId;
  String tenantName;
  int departmentId;
  String departmentName;
  int resourceId;
  String resourceName;
  bool forOnline;

  CreateAppointmentEventsScreen({Key key}) : super(key: key);

  @override
  _CreateAppointmentEventsScreenState createState() =>
      _CreateAppointmentEventsScreenState();
}

class _CreateAppointmentEventsScreenState
    extends State<CreateAppointmentEventsScreen> {
  ValueNotifier<_EventSelectedModel> completeNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    try {
      widget.patientId = Uri.decodeFull(Atom.queryParameters['patientId']);
      widget.patientName = Uri.decodeFull(Atom.queryParameters['patientName']);
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.tenantName = Uri.decodeFull(Atom.queryParameters['tenantName']);
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']);
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']);
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']);
      widget.resourceName =
          Uri.decodeFull(Atom.queryParameters['resourceName']);
      widget.forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentEventsVm>(
      create: (context) => CreateAppointmentEventsVm(
        context: context,
        tenantId: widget.tenantId,
        departmentId: widget.departmentId,
        resourceId: widget.resourceId,
        forOnline: widget.forOnline,
      ),
      child: Consumer<CreateAppointmentEventsVm>(builder: (
        BuildContext context,
        CreateAppointmentEventsVm val,
        Widget child,
      ) {
        return RbioScaffold(
          appbar: RbioAppBar(
            title: RbioAppBar.textTitle(
              context,
              LocaleProvider.of(context).create_appointment_events,
            ),
          ),

          //
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              _buildHeaderInfo(),

              //
              if (val.availableDatesProgress == LoadingProgress.LOADING) ...[
                SizedBox(
                  height: Atom.height * 0.35,
                  child: RbioLoading(),
                ),
              ] else if (val.availableDatesProgress ==
                  LoadingProgress.DONE) ...[
                _TableCalendar(
                  val: val,
                  completeNotifier: completeNotifier,
                  focusedDay: val.initDate,
                ),
              ],

              //
              const SizedBox(height: 8.0),

              //
              if (val.slotsProgress == LoadingProgress.LOADING) ...[
                Expanded(child: RbioLoading()),
              ] else if (val.slotsProgress == LoadingProgress.DONE) ...[
                Expanded(
                  child: ListBody(
                    completeNotifier: completeNotifier,
                    vm: val,
                    onSubmit: () {
                      Atom.to(
                        PagePaths.CREATE_APPOINTMENT_SUMMARY,
                        queryParameters: {
                          'patientId': Uri.encodeFull(widget.patientId),
                          'patientName': Uri.encodeFull(widget.patientName),
                          'tenantId': completeNotifier.value.selected.tenantId
                              .toString(),
                          'tenantName':
                              Uri.encodeFull(widget.tenantName.toString()),
                          'departmentId': widget.departmentId.toString(),
                          'departmentName':
                              Uri.encodeFull(widget.departmentName.toString()),
                          'resourceId': widget.resourceId.toString(),
                          'resourceName':
                              Uri.encodeFull(widget.resourceName.toString()),
                          'date': val.selectedDate.toIso8601String(),
                          'from':
                              completeNotifier.value.selected.from.toString(),
                          'to': completeNotifier.value.selected.to.toString(),
                          'forOnline': widget.forOnline.toString(),
                        },
                      );
                    },
                  ),
                ),
              ] else if (val.slotsProgress == LoadingProgress.ERROR) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      LocaleProvider.current.error,
                      style: context.xHeadline1.copyWith(),
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          _buildHeaderPassiveText(LocaleProvider.current.patient_name),
          _buildHeaderActiveText(widget.patientName),

          //
          _buildHeaderVerticalGap(),

          //
          _buildHeaderPassiveText(LocaleProvider.current.tenant_name),
          _buildHeaderActiveText(widget.tenantName),

          //
          _buildHeaderVerticalGap(),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildHeaderPassiveText(LocaleProvider.current.doctor_name),
                    _buildHeaderActiveText(widget.resourceName),
                  ],
                ),
              ),

              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildHeaderPassiveText(LocaleProvider.current.depart_name),
                    _buildHeaderActiveText(widget.departmentName),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderVerticalGap() => SizedBox(height: 8);

  Widget _buildHeaderActiveText(String text) => Text(
        text ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline3,
      );

  Widget _buildHeaderPassiveText(String text) => Text(
        text ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline4.copyWith(
          color: getIt<ITheme>().textColorPassive,
        ),
      );
}
