import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  RbioAppBar _buildAppbar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.followers,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          RbioUserTile(
            name: "Endokronoloji Cüneyt Akın",
            leadingImage: UserLeadingImage.circle,
            trailingIcon: UserTrailingIcons.cancel,
            onTap: () {},
            width: Atom.width,
          ),

          //
          _buildVerticalGap(),

          //
          RbioUserTile(
            name: "İnsan Kaynakları Müdürü",
            leadingImage: UserLeadingImage.circle,
            trailingIcon: UserTrailingIcons.cancel,
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
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
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
