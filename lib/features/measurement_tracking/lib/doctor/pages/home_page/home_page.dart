import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../extension/size_extension.dart';
import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../notification_handler.dart';
import '../../../pages/signup&login/login_page/login_page.dart';
import '../../../widgets/custom_app_bar/custom_app_bar.dart';
import '../../notifiers/user_notifiers.dart';
import '../../utils/widgets.dart';
import '../patients_page/patient_page.dart';
import 'home_page_view_model.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePage createState() => _DoctorHomePage();
}

class _DoctorHomePage extends State<DoctorHomePage> {
  @override
  void initState() {
    NotificationHandler().initializeFCMNotification(context);
    // PushedNotificationHandler().initializeGCM();
    super.initState();
  }

  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            preferredSize: Size.fromHeight(context.HEIGHT * .18),
            title: titleAppBarWhite(
                title: Provider.of<UserNotifiers>(context, listen: false)
                        ?.userName ??
                    ""),
            actions: [
              InkWell(
                onTap: () {
                  UserNotifiers().deleteData();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (contextTrans) => LoginPage()),
                    ModalRoute.withName(Routes.LOGIN_PAGE),
                  );
                },
                child: SvgPicture.asset(R.image.logout_icon),
              )
            ]),
        extendBodyBehindAppBar: true,
        body: ChangeNotifierProvider(
          create: (context) => HomePageViewModel(
              context: context, pageController: pageController),
          child: Consumer<HomePageViewModel>(
            builder: (context, value, child) {
              return Column(
                children: [
                  SizedBox(
                    height: context.HEIGHT * .15,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: context.HEIGHT * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            child: tabButton(
                                context: context,
                                text: LocaleProvider.current.appointments,
                                isSelected: value.appointmentSelected),
                            onTap: () {
                              value.setSelectedAppointment();
                            }),
                        InkWell(
                            child: tabButton(
                                context: context,
                                text: LocaleProvider.current.patients,
                                isSelected: value.patientSelected),
                            onTap: () {
                              value.setSelectedPatient();
                            })
                      ],
                    ),
                  ),
                  Expanded(child: bodyPageView(context)),
                ],
              );
            },
          ),
        ));
  }

  Widget bodyPageView(BuildContext context) => PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[Container(), PatientPage()],
        controller: pageController,
      );
}
