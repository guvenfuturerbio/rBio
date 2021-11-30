import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/create_appointment_summary_vm.dart';

class CreateAppointmentSummaryScreen extends StatefulWidget {
  String patientId;
  String patientName;
  int tenantId;
  String tenantName;
  int departmentId;
  String departmentName;
  int resourceId;
  String resourceName;
  String date;
  String from;
  String to;
  bool forOnline;

  CreateAppointmentSummaryScreen({Key key}) : super(key: key);

  @override
  _CreateAppointmentSummaryScreenState createState() =>
      _CreateAppointmentSummaryScreenState();
}

class _CreateAppointmentSummaryScreenState
    extends State<CreateAppointmentSummaryScreen> {
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
      widget.date = Atom.queryParameters['date'];
      widget.from = Atom.queryParameters['from'];
      widget.to = Atom.queryParameters['to'];
      widget.forOnline = Atom.queryParameters['forOnline'] == 'true';
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<CreateAppointmentSummaryVm>(
      create: (context) => CreateAppointmentSummaryVm(
        mContext: context,
        patientId: PatientSingleton().getPatient().id,
        tenantId: widget.tenantId,
        departmentId: widget.departmentId,
        resourceId: widget.resourceId,
        forOnline: widget.forOnline,
        from: widget.from,
        to: widget.to,
      ),
      child: Consumer(
        builder: (
          BuildContext context,
          CreateAppointmentSummaryVm vm,
          Widget child,
        ) {
          return RbioLoadingOverlay(
            isLoading: vm.showOverlayLoading,
            opacity: 0,
            progressIndicator: RbioLoading.progressIndicator(),
            child: RbioScaffold(
              appbar: RbioAppBar(
                title: RbioAppBar.textTitle(
                  context,
                  LocaleProvider.current.create_appo,
                ),
              ),
              body: _buildBody(vm),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(CreateAppointmentSummaryVm vm) => SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Text(
                LocaleProvider.current.appointment_details,
                textAlign: TextAlign.start,
                style: context.xHeadline1,
              ),

              //
              SizedBox(
                height: 12,
              ),

              //
              _buildInfoCard(vm),
            ],
          ),
        ),
      );

  Widget _buildInfoCard(CreateAppointmentSummaryVm vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPassiveText(LocaleProvider.current.patient_name),
          _buildActiveText(widget.patientName),
          _buildVerticalGap(),

          //
          _buildPassiveText(LocaleProvider.current.tenant_name),
          _buildActiveText(widget.tenantName),
          _buildVerticalGap(),

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
                    //
                    _buildPassiveText(LocaleProvider.current.doctor_name),
                    _buildActiveText(widget.resourceName),
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
                    //
                    _buildPassiveText(LocaleProvider.current.depart_name),
                    _buildActiveText(widget.departmentName),
                  ],
                ),
              ),
            ],
          ),

          //
          _buildVerticalGap(),

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
                    //
                    _buildPassiveText(LocaleProvider.current.hint_date),
                    _buildActiveText(
                        DateTime.parse(widget.date).xFormatTime1()),
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
                    //
                    _buildPassiveText(LocaleProvider.current.time),
                    _buildActiveText(
                        '${widget.from.substring(11, 16)} - ${widget.to.substring(11, 16)}'),
                  ],
                ),
              ),
            ],
          ),

          //
          _buildVerticalGap(),
          _buildVerticalGap(),

          //
          if (widget.forOnline &&
              vm.getVideoCallPriceResponse != null &&
              vm.getVideoCallPriceResponse.patientPrice != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '${vm.getVideoCallPriceResponse.patientPrice} TL',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.xHeadline1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: getIt<ITheme>().mainColor,
                  ),
                ),
                _buildHorizontalGap(),
              ],
            ),
          ],

          _buildVerticalGap(),

          //
          SizedBox(
            width: double.infinity,
            child: RbioElevatedButton(
              title: LocaleProvider.current.btn_confirm,
              onTap: () {
                vm.saveAppointment(
                  price:
                      vm?.getVideoCallPriceResponse?.patientPrice?.toString(),
                  forOnline: widget.forOnline,
                  forFree:
                      (vm?.getVideoCallPriceResponse?.patientPrice ?? 0) < 1
                          ? true
                          : false,
                );
              },
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: 8);

  Widget _buildHorizontalGap() => SizedBox(width: 12);

  Widget _buildActiveText(String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline3,
      );

  Widget _buildPassiveText(String text) => Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.xHeadline4.copyWith(
          color: getIt<ITheme>().textColorPassive,
        ),
      );
}
