import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../viewmodel/create_appointment_events_vm.dart';

part '../model/event.dart';
part '../model/event_selected_model.dart';
part '../widgets/list_body.dart';
part '../widgets/table_calendar.dart';

class CreateAppointmentEventsScreen extends StatefulWidget {
  late String patientName;
  late int tenantId;
  late String tenantName;
  late int departmentId;
  late String departmentName;
  late int resourceId;
  late String resourceName;
  late bool forOnline;

  CreateAppointmentEventsScreen({Key? key}) : super(key: key);

  @override
  _CreateAppointmentEventsScreenState createState() =>
      _CreateAppointmentEventsScreenState();
}

class _CreateAppointmentEventsScreenState
    extends State<CreateAppointmentEventsScreen> {
  late ValueNotifier<_EventSelectedModel?> completeNotifier =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    try {
      widget.patientName = Uri.decodeFull(Atom.queryParameters['patientName']!);
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']!);
      widget.tenantName = Uri.decodeFull(Atom.queryParameters['tenantName']!);
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']!);
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']!);
      widget.resourceId = int.parse(Atom.queryParameters['resourceId']!);
      widget.resourceName =
          Uri.decodeFull(Atom.queryParameters['resourceName']!);
      widget.forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return ChangeNotifierProvider<CreateAppointmentEventsVm>(
      create: (context) => CreateAppointmentEventsVm(
        mContext: context,
        tenantId: widget.tenantId,
        departmentId: widget.departmentId,
        resourceId: widget.resourceId,
        forOnline: widget.forOnline,
      ),
      child: Consumer<CreateAppointmentEventsVm>(
        builder: (
          BuildContext context,
          CreateAppointmentEventsVm val,
          Widget? child,
        ) {
          return RbioStackedScaffold(
            isLoading: val.centerLoading,
            appbar: RbioAppBar(
              context: context,
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).create_appointment_events,
              ),
            ),

            //
            body: _buildBody(val, context),
          );
        },
      ),
    );
  }

  Widget _buildBody(CreateAppointmentEventsVm val, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        R.widgets.stackedTopPadding(context),
        R.widgets.hSizer8,

        //
        if (val.availableDatesProgress == LoadingProgress.loading) ...[
          if (!val.centerLoading) ...[
            SizedBox(
              height: Atom.height * 0.35,
              child: const RbioLoading(),
            ),
          ]
        ] else if (val.availableDatesProgress == LoadingProgress.done) ...[
          _TableCalendar(
            val: val,
            completeNotifier: completeNotifier,
            focusedDay: val.initDate,
          ),
        ] else if (val.availableDatesProgress == LoadingProgress.error) ...[
          const Expanded(
            child: RbioBodyError(),
          ),
        ],

        //
        R.widgets.hSizer8,

        //
        if (val.slotsProgress == LoadingProgress.loading) ...[
          if (!val.centerLoading) ...[
            const Expanded(child: RbioLoading()),
          ]
        ] else if (val.slotsProgress == LoadingProgress.done) ...[
          Expanded(
            child: ListBody(
              completeNotifier: completeNotifier,
              vm: val,
              onSubmit: () {
                Atom.to(
                  PagePaths.createAppointmentSummary,
                  queryParameters: {
                    'patientName': Uri.encodeFull(widget.patientName),
                    'tenantId':
                        completeNotifier.value!.selected!.tenantId!.toString(),
                    'tenantName': Uri.encodeFull(widget.tenantName.toString()),
                    'departmentId': widget.departmentId.toString(),
                    'departmentName':
                        Uri.encodeFull(widget.departmentName.toString()),
                    'resourceId': widget.resourceId.toString(),
                    'resourceName':
                        Uri.encodeFull(widget.resourceName.toString()),
                    'date': val.selectedDate.toIso8601String(),
                    'from': completeNotifier.value!.selected!.from!.toString(),
                    'to': completeNotifier.value!.selected!.to!.toString(),
                    'forOnline': widget.forOnline.toString(),
                  },
                );
              },
            ),
          ),

          //
          R.widgets.defaultBottomPadding,
        ],
      ],
    );
  }
}
