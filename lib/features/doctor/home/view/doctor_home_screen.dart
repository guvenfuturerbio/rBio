import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.chronic_track,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        //
        _buildCard(
          context,
          R.image.bloodGlucose,
          LocaleProvider.current.bg_measurement_tracking,
          () {
            Atom.to(
              PagePaths.doctorPatientList,
              queryParameters: {
                'type': PatientType.bg.xRawValue,
              },
            );
          },
        ),

        //
        _buildCard(
          context,
          R.image.bodyScale,
          LocaleProvider.current.bmi_tracking,
          () {
            Atom.to(
              PagePaths.doctorPatientList,
              queryParameters: {
                'type': PatientType.scale.xRawValue,
              },
            );
          },
        ),

        //
        _buildCard(
          context,
          R.image.bloodPressure,
          LocaleProvider.current.blood_pressure_tracking,
          () {
            Atom.to(
              PagePaths.doctorPatientList,
              queryParameters: {
                'type': PatientType.bp.xRawValue,
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String image,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //
            R.widgets.hSizer8,

            //
            SvgPicture.asset(
              image,
              fit: BoxFit.scaleDown,
              height: Atom.height * .1,
            ),

            //
            const SizedBox(
              height: 50,
            ),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                R.widgets.wSizer12,

                //
                Expanded(
                  child: Text(
                    title,
                    style: context.xHeadline3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //
                RbioBadge(
                  image: R.image.attentionSvg,
                ),

                //
                R.widgets.wSizer16,

                //
                RbioBadge(
                  image: R.image.chat,
                ),

                //
                R.widgets.wSizer12,
              ],
            ),

            //
            R.widgets.hSizer8,
          ],
        ),
      ),
    );
  }
}
