import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class FollowersScreen extends StatefulWidget {
  FollowersScreen({Key key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  PreferredSizeWidget _buildAppbar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(context, LocaleProvider.current.followers),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      padding: R.sizes.screenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          RbioUserTile(
            name: "Endokronoloji Cüneyt Akın",
            leadingImage: UserLeadingImage.Circle,
            trailingIcon: UserTrailingIcons.Cancel,
            onTap: () {},
            width: Atom.width,
          ),

          //
          _buildVerticalGap(),

          //
          RbioUserTile(
            name: "İnsan Kaynakları Müdürü",
            leadingImage: UserLeadingImage.Circle,
            trailingIcon: UserTrailingIcons.Cancel,
            onTap: () {},
            width: Atom.width,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {},
      child: Center(
        child: SvgPicture.asset(
          R.image.add,
          width: R.sizes.iconSize2,
        ),
      ),
    );
  }
}
