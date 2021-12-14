import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class DoctorHomeScreen extends StatelessWidget {
  DoctorHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.chronic_track,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        //
        _buildCard(
          context,
          R.image.ct_blood_glucose,
          LocaleProvider.current.bg_measurement_tracking,
          () {
            Atom.to(PagePaths.BLOOD_GLUCOSE_PATIENT_LIST);
          },
        ),

        //
        _buildCard(
          context,
          R.image.ct_body_scale,
          LocaleProvider.current.weight_tracking,
          () {},
        ),

        //
        _buildCard(
          context,
          R.image.ct_blood_pressure,
          LocaleProvider.current.blood_pressure_tracking,
          () {},
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
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //
            SizedBox(height: 8),

            //
            SvgPicture.asset(
              image,
              fit: BoxFit.scaleDown,
              height: Atom.height * .1,
            ),

            //
            SizedBox(
              height: 50,
            ),

            //
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                SizedBox(width: 12),

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
                SizedBox(width: 15),

                //
                RbioBadge(
                  image: R.image.chat_icon,
                ),

                //
                SizedBox(width: 12),
              ],
            ),

            //
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
