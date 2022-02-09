part of '../devices.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.devices,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => DevicesVm(),
        child: Consumer<DevicesVm>(
          builder: (BuildContext context, DevicesVm vm, Widget? child) {
            return _buildBody(context, vm);
          },
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(BuildContext context, DevicesVm vm) {
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

  Widget _buildListView(DevicesVm vm) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: vm.devices.length,
      itemBuilder: (context, index) {
        final device = vm.devices[index];

        return Column(
          children: [
            DeviceCard(
              background: getIt<ITheme>().cardBackgroundColor,
              image: device.deviceType == null
                  ? const SizedBox()
                  : UtilityManager()
                          .getDeviceImageFromType(device.deviceType!) ??
                      const SizedBox(),
              name: '${device.manufacturerName}\n${device.serialNumber ?? ''}',
              trailing: Row(
                children: [
                  InkWell(
                    onTap: () {
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
                          content: GuvenAlert.buildDescription(LocaleProvider
                              .current.ble_delete_paired_device_approv),
                          actions: [
                            GuvenAlert.buildBigMaterialAction(
                              LocaleProvider.current.cancel,
                              () => Atom.dismiss(),
                            ),
                            GuvenAlert.buildBigMaterialAction(
                              LocaleProvider.current.yes,
                              () => vm.deletePairedDevice(
                                device.deviceId ?? '',
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.cancel,
                      color: R.color.darkRed,
                      size: R.sizes.iconSize,
                    ),
                  ),
                ],
              ),
            ),

            //
            _buildVerticalGap()
          ],
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

  Widget _buildVerticalGap() => SizedBox(height: Atom.height * 0.015);
}
