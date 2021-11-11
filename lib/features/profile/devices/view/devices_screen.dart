import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../viewmodel/devices_vm.dart';

class DevicesScreen extends StatefulWidget {
  DevicesScreen({Key key}) : super(key: key);

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) {
        Provider.of<DevicesVm>(context, listen: false).getAll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(context, LocaleProvider.current.devices),
      ),
      body: Consumer<DevicesVm>(
        builder: (context, value, child) {
          return _buildBody(value);
        },
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(DevicesVm vm) {
    switch (vm.state) {
      case LoadingProgress.DONE:
        return ListView.builder(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          padding: R.sizes.screenPadding(context),
          itemCount: vm.devices.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                RbioUserTile(
                  name: '${vm.devices[index].title}',
                  onTap: () {},
                  imageUrl: vm.devices[index].image,
                  leadingImage: UserLeadingImage.Rectangle,
                  trailingIcon: UserTrailingIcons.Cancel,
                  width: Atom.width,
                ),

                //
                _buildVerticalGap(),
              ],
            );
          },
        );

      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.ERROR:
        return Center(child: QueryParametersError());

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
