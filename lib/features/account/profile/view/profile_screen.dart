import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(context, 'Profile'),
      ),

      //
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      padding: R.sizes.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          RbioUserTile(
            name: "Ergün Yunus Cengiz",
            imageUrl: R.image.mockAvatar,
            leadingImage: UserLeadingImage.Circle,
            onTap: () {},
          ),

          //
          Container(
            height: Atom.height * 0.25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNumberTile(
                  2,
                  'Çocuklarım',
                  () {},
                ),
                _buildHorizontalGap(),
                _buildNumberTile(
                  2,
                  'Takipçilerim',
                  () {
                    Atom.to(PagePaths.FOLLOWERS);
                  },
                ),
                _buildHorizontalGap(),
                _buildNumberTile(
                  1,
                  'Takip Ettiklerim',
                  () {},
                ),
              ],
            ),
          ),

          //
          _buildVerticalGap(),

          //
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: getIt<ITheme>().cardBackgroundColor,
              borderRadius: R.sizes.borderRadiusCircular,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                _buildListItem('Kişisel Bilgiler'),
                _buildListItem('Sağlık Bilgilerim'),
                _buildListItem('Cihazlarım'),
                _buildListItem('Hatırlatıcılarım'),
                _buildListItem('İstek ve Önerilerim', isDivider: false),
              ],
            ),
          ),

          //
          _buildVerticalGap(),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);

  Widget _buildHorizontalGap() => SizedBox(width: Atom.width * 0.025);

  Widget _buildNumberTile(int number, String title, VoidCallback onTap) {
    return Expanded(
      child: ClipRRect(
        borderRadius: R.sizes.borderRadiusCircular,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //
            Positioned.fill(
              child: Container(
                color: getIt<ITheme>().cardBackgroundColor,
              ),
            ),

            //
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: Atom.width * 0.08,
                backgroundColor: getIt<ITheme>().secondaryColor,
                child: Text(
                  '$number',
                  style: context.xHeadline1.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: Atom.width * 0.020,
                  left: Atom.width * 0.015,
                  right: Atom.width * 0.015,
                ),
                child: Text(
                  title,
                  style: context.xHeadline3.copyWith(
                    color: getIt<ITheme>().textColorSecondary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),

            //
            Positioned.fill(
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String title, {bool isDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //
              Expanded(
                child: Text(
                  title,
                  style: context.xHeadline3,
                ),
              ),

              //
              SvgPicture.asset(
                R.image.ic_arrow_right,
                width: Atom.isWeb ? Atom.width * 0.005 : Atom.width * 0.025,
              ),
            ],
          ),
        ),

        //
        if (isDivider)
          Divider(
            thickness: 0,
            indent: 10,
            endIndent: 10,
            height: 0.0,
          ),
      ],
    );
  }
}
