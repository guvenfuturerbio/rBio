import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../features/profile/devices/devices.dart';
import 'paired_device_listing_vm.dart';

class PairedDeviceListingScreen extends StatelessWidget {
  const PairedDeviceListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.devices,
        ),
      ),
      body: ChangeNotifierProvider<PairedDeviceListingVm>(
        create: (_) => PairedDeviceListingVm(),
        child: Consumer<PairedDeviceListingVm>(
          builder:
              (BuildContext context, PairedDeviceListingVm vm, Widget? child) {
            return _buildBody(context, vm);
          },
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(BuildContext context, PairedDeviceListingVm vm) {
    switch (vm.state) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return vm.devices.isNotEmpty
            ? _buildListView(vm)
            : RbioEmptyText(title: LocaleProvider.current.add_new_device);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }

  Widget _buildListView(PairedDeviceListingVm vm) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      itemCount: vm.devices.length,
      itemBuilder: (BuildContext context, int index) {
        final device = vm.devices[index];

        return DeviceCard(
          background: getIt<ITheme>().cardBackgroundColor,
          image: UtilityManager().getDeviceImageFromType(device.deviceType!) ??
              const SizedBox(),
          name: device.name,
          trailing: Row(
            children: [
              //
              IconButton(
                onPressed: () {
                  LoggerUtils.instance.i(device.toJson());
                },
                icon: Icon(
                  Icons.info,
                  size: R.sizes.iconSize * 1.25,
                ),
              ),

              //
              IconButton(
                onPressed: () {
                  Atom.show(
                    GuvenAlert(
                      backgroundColor: getIt<ITheme>().cardBackgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 25,
                      ),
                      title: GuvenAlert.buildTitle(
                        LocaleProvider.current.warning,
                      ),
                      content: GuvenAlert.buildDescription(
                        LocaleProvider.current.ble_delete_paired_device_approv,
                      ),
                      actions: [
                        GuvenAlert.buildBigMaterialAction(
                          LocaleProvider.current.cancel,
                          () => Atom.dismiss(),
                        ),
                        GuvenAlert.buildBigMaterialAction(
                          LocaleProvider.current.yes,
                          () => vm.deletePairedDevice(
                            device.id,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.cancel,
                  color: R.color.darkRed,
                  size: R.sizes.iconSize * 1.25,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(PagePaths.allDevices);
      },
      child: Center(
        child: SvgPicture.asset(
          R.image.add,
          width: R.sizes.iconSize2,
        ),
      ),
    );
  }
}
