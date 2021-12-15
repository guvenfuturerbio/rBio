import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/relatives_vm.dart';

class RelativesScreen extends StatefulWidget {
  RelativesScreen({Key key}) : super(key: key);

  @override
  _RelativesScreenState createState() => _RelativesScreenState();
}

class _RelativesScreenState extends State<RelativesScreen> {
  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback(
        (_) {
          Provider.of<RelativesVm>(context, listen: false).getAll();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.kids,
        ),
      ),
      body: Consumer<RelativesVm>(
        builder: (
          BuildContext context,
          RelativesVm value,
          Widget child,
        ) {
          return _buildBody(value);
        },
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(RelativesVm vm) {
    switch (vm.state) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemCount: vm.response.patientRelatives.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                RbioUserTile(
                  name:
                      '${vm.response.patientRelatives[index].name} ${vm.response.patientRelatives[index].surname}',
                  onTap: () {},
                  leadingImage: UserLeadingImage.Circle,
                  trailingIcon: UserTrailingIcons.RightArrow,
                  width: Atom.width,
                ),

                //
                _buildVerticalGap(),
              ],
            );
          },
        );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(PagePaths.ADDPATIENTRELATIVES);
      },
      child: Center(
        child: SvgPicture.asset(
          R.image.add,
          width: R.sizes.iconSize2,
        ),
      ),
    );
  }

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);
}
