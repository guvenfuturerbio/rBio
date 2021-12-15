import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class DoctorVideoCallEditScreen extends StatefulWidget {
  DoctorVideoCallEditScreen({Key key}) : super(key: key);

  @override
  _DoctorVideoCallEditScreenState createState() =>
      _DoctorVideoCallEditScreenState();
}

class _DoctorVideoCallEditScreenState extends State<DoctorVideoCallEditScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar() => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          'Tedavi Süreci',
        ),
      );

  Widget _buildBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildUserCard(),

          //
          _buildTimeRow(),

          //
          Padding(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 8,
              bottom: 8,
            ),
            child: Text(
              'Notlar',
              textAlign: TextAlign.start,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: getIt<ITheme>().cardBackgroundColor,
                borderRadius: R.sizes.borderRadiusCircular,
              ),
            ),
          ),

          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: RbioElevatedButton(
                  title: 'Geri',
                ),
              ),

              //
              Expanded(
                child: RbioElevatedButton(
                  title: 'Kaydet',
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildUserCard() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getIt<ITheme>().cardBackgroundColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(R.image.circlevatar),
            backgroundColor: getIt<ITheme>().cardBackgroundColor,
          ),

          //
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ayşe Yıldırım' ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.xHeadline5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //
          SvgPicture.asset(
            R.image.arrow_down_icon,
            height: 10,
          ),
        ],
      ),
    );
  }

  Padding _buildTimeRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              'Görüntülü Görüşme',
              textAlign: TextAlign.start,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          Expanded(
            child: Text(
              '01/01/2021 - 09:00',
              textAlign: TextAlign.end,
              style: context.xHeadline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
