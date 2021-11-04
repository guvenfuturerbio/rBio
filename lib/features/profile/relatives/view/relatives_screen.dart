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
      widgetsBinding.addPostFrameCallback((_) {
        Provider.of<RelativesVm>(context, listen: false).getAll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(context, 'Çocuklarım'),
      ),
      body: Consumer<RelativesVm>(
        builder: (context, value, child) {
          return _buildBody(value);
        },
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(RelativesVm vm) {
    switch (vm.state) {
      case LoadingProgress.DONE:
        return ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: R.sizes.screenPadding,
          itemCount: vm.relatives.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                RbioUserTile(
                  name: '${vm.relatives[index].name} ${vm.relatives[index].surname}',
                  onTap: () {},
                  leadingImage: UserLeadingImage.Circle,
                  trailingIcon: UserTrailingIcons.RightArrow,
                ),

                //
                _buildVerticalGap(),
              ],
            );
          },
        );

      case LoadingProgress.ERROR:
        return Center(child: QueryParametersError());

      case LoadingProgress.LOADING:
        return Center(child: CircularProgressIndicator());

      default:
        return SizedBox();
    }
  }

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

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);
}
