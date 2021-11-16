import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/models/appointment_models/doctor.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/appointment/appointment_page/appointment_page_view_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/appointment/doctors_page/doctors_page_view_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.department),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: ChangeNotifierProvider(
        create: (context) => DoctorsPageViewModel(context: context, id: id),
        child: Consumer<DoctorsPageViewModel>(
          builder: (context, value, child) {
            return Center(
              child: value.stage == Stage.DONE
                  ? _buildPosts(context, value.doctors)
                  : value.stage == Stage.LOADING
                      ? _shimmer(context)
                      : Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _shimmer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 300,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Shimmer.fromColors(
                  child: ListTile(
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                ),
              ],
            );
          },
        ))
      ],
    );
  }

  ListView _buildPosts(BuildContext context, List<Doctor> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Consumer<DoctorsPageViewModel>(builder: (context, value, child) {
          return Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                posts[index].employee.user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //subtitle: Text(posts[index].id.toString()),
              onTap: () {
                value.checkAppointedDoctor(posts[index]);
              },
            ),
          );
        });
      },
    );
  }
}
