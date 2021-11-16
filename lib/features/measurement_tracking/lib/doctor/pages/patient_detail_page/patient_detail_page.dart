import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../resources/resources.dart';
import '../../utils/bg_measurement_list.dart';
import '../../utils/graph_header_section.dart';
import '../../utils/widgets.dart';
import '../chat/chat_controller.dart';
import '../chat/chat_window.dart';
import '../patients_page/patient_page_view_model.dart';
import 'patient_detail_page_view_model.dart';

class PatientDetailPage extends StatefulWidget {
  @override
  _PatientDetailPageState createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  ScrollController _controller = ScrollController();

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    int patientId = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
        create: (context) =>
            PatientDetailPageViewModel(context: context, patientId: patientId),
        child: Consumer<PatientDetailPageViewModel>(
          builder: (context, value, child) {
            return DropdownBanner(
              navigatorKey: _navigatorKey,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: CustomAppBar(
                      preferredSize: Size.fromHeight(context.HEIGHT * .18),
                      title: titleAppBarWhite(
                          title: value.patientDetail == null
                              ? ""
                              : value.patientDetail.name),
                      leading: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(R.image.back)),
                      actions: [
                        InkWell(
                          child: Icon(Icons.chat, color: Colors.white),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider<
                                                DoctorChatController>(
                                            create: (context) =>
                                                DoctorChatController(),
                                            child: DoctorChatWindow(
                                                patientId.toString(),
                                                value.patientDetail.name))));
                          },
                        )
                      ]),
                  extendBodyBehindAppBar: true,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.HEIGHT * .18,
                        ),
                        value.stateProcessPatientDetail == StateProcess.LOADING
                            ? Shimmer.fromColors(
                                child: patientDetail(
                                    context: context,
                                    targetRangePresses: () {},
                                    hyperEdit: () {}),
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100])
                            : patientDetail(
                                context: context,
                                patientDetail: value.patientDetail,
                                targetRangePresses: () {
                                  value.showNormalRangeEdit();
                                },
                                hypoEdit: () {
                                  value.showHypoEdit();
                                },
                                hyperEdit: () {
                                  value.showHyperEdit();
                                }),
                        if (!value.isDataLoading) ...{
                          BgGraphHeaderSection(
                              value: value, controller: _controller),
                          SizedBox(
                            height: context.HEIGHT * .3,
                            child: BgMeasurementListWidget(
                              bgMeasurements: value.bgMeasurements,
                              scrollController: _controller,
                              useStickyGroupSeparatorsValue: value.selected ==
                                          LocaleProvider.current.daily ||
                                      value.selected ==
                                          LocaleProvider.current.specific
                                  ? true
                                  : false,
                            ),
                          ),
                        } else ...{
                          Shimmer.fromColors(
                              child: patientDetail(
                                  context: context,
                                  targetRangePresses: () {},
                                  hyperEdit: () {}),
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100])
                        }
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}
