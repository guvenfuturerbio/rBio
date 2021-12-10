import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../chronic_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import '../../utils/widgets.dart';
import '../appointment/doctor_appointment_screen.dart';
import '../patients_page/patient_page.dart';
import 'doctor_home_vm.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key key}) : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  PageController pageController;

  @override
  void initState() {
    // NotificationHandler().initializeFCMNotification(context);
    // PushedNotificationHandler().initializeGCM();
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      preferredSize: Size.fromHeight(context.HEIGHT * .18),
      title: titleAppBarWhite(
        title: 'Kronik Takip',
      ),
      actions: [
        InkWell(
          onTap: () {
            Atom.historyBack();
          },
          child: SvgPicture.asset(R.image.logout_icon),
        )
      ],
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider<DoctorHomeVm>(
      create: (context) => DoctorHomeVm(
        context: context,
        pageController: pageController,
      ),
      child: Consumer<DoctorHomeVm>(
        builder: (
          BuildContext context,
          DoctorHomeVm value,
          Widget child,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              SizedBox(
                height: context.HEIGHT * .15,
              ),

              //
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.HEIGHT * .03),
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
                      },
                    ),
                    InkWell(
                      child: tabButton(
                          context: context,
                          text: LocaleProvider.current.patients,
                          isSelected: value.patientSelected),
                      onTap: () {
                        value.setSelectedPatient();
                      },
                    )
                  ],
                ),
              ),

              //
              Expanded(child: bodyPageView(context)),
            ],
          );
        },
      ),
    );
  }

  Widget bodyPageView(BuildContext context) => PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          DoctorAppointmentScreen(),
          PatientPage(),
        ],
      );

  Widget tabButton({BuildContext context, String text, bool isSelected}) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.05,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: tabTextSize,
            color: isSelected ? R.color.white : R.color.mainColor,
          ),
        ),
        decoration: isSelected ? activeDecoration() : decoration(),
      );

  BoxDecoration activeDecoration() {
    return BoxDecoration(
      color: R.color.regularBlue,
      gradient: LinearGradient(
        colors: [R.color.mainColor, R.color.mainColor],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: Offset(5, 10),
        )
      ],
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: R.color.regularBlue,
      gradient: LinearGradient(
        colors: [Colors.white, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(50),
          blurRadius: 15,
          spreadRadius: 0,
          offset: Offset(5, 10),
        ),
      ],
    );
  }
}
