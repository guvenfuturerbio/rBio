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
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      itemCount: vm.devices.length,
      itemBuilder: (BuildContext context, int index) {
        final device = vm.devices[index];

        if (device.version == BluetoothDeviceVersion.v1) {
          return _buildV1Card(context, device.v1Device!, vm);
        } else {
          return _buildV2Card(context, device.v2Device!, vm);
        }
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

  Widget _buildV2Card(BuildContext context, DeviceEntity device, DevicesVm vm) {
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
                      () => vm.deletePairedDeviceV2(
                        context,
                        device,
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
  }

  Widget _buildV1Card(BuildContext context, PairedDevice device, DevicesVm vm) {
    return DeviceCard(
      background: getIt<ITheme>().cardBackgroundColor,
      image: UtilityManager().getDeviceImageFromType(device.deviceType!) ??
          const SizedBox(),
      name: '${device.manufacturerName}\n${device.serialNumber ?? ''}',
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
                      () => vm.deletePairedDeviceV1(
                        device.deviceId ?? '',
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
  }
}
