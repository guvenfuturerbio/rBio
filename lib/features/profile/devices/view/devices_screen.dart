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
      backgroundColor: getIt<IAppConfig>().theme.mainColor,
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
    return BlocProvider<DeviceStatusCubit>(
      create: (context) => DeviceStatusCubit(getIt())..readStatus(device),
      child: BlocBuilder<DeviceStatusCubit, DeviceStatus?>(
        builder: (context, deviceStatus) {
          Widget deviceCard({
            Widget? pillarSmallTrigger,
          }) =>
              DeviceCard(
                name: device.name,
                background: _getBackgroundColorV2(deviceStatus),
                image: UtilityManager()
                        .getDeviceImageFromType(device.deviceType!) ??
                    const SizedBox(),
                onTap: () async {
                  if (deviceStatus == DeviceStatus.connected) {
                    context.read<DeviceSelectedCubit>().disconnect(device);
                  } else if (deviceStatus == DeviceStatus.disconnected) {
                    BlocProvider.of<DeviceSelectedCubit>(context)
                        .connect(device);
                  }
                },
                trailing: Row(
                  children: [
                    pillarSmallTrigger ?? const SizedBox(),

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
                            backgroundColor:
                                getIt<IAppConfig>().theme.cardBackgroundColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            title: GuvenAlert.buildTitle(
                              LocaleProvider.current.warning,
                            ),
                            content: GuvenAlert.buildDescription(
                              LocaleProvider
                                  .current.ble_delete_paired_device_approv,
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
                        color: getIt<IAppConfig>().theme.darkRed,
                        size: R.sizes.iconSize * 1.25,
                      ),
                    ),
                  ],
                ),
              );

          if (device.deviceType == DeviceType.pillarSmall) {
            return BlocBuilder<PillarSmallCubit, PillarSmallStatus>(
              builder: (context, pillarSmallState) {
                return deviceCard(
                  pillarSmallTrigger: IconButton(
                    onPressed: () {
                      context.read<PillarSmallCubit>().trigger();
                    },
                    icon: Icon(
                      Icons.turn_slight_right,
                      size: R.sizes.iconSize * 1.25,
                    ),
                  ),
                );
              },
            );
          } else {
            return deviceCard();
          }
        },
      ),
    );
  }

  Color _getBackgroundColorV2(DeviceStatus? deviceStatus) {
    switch (deviceStatus) {
      case DeviceStatus.connecting:
        return getIt<IAppConfig>().theme.high;

      case DeviceStatus.connected:
        return getIt<IAppConfig>().theme.mainColor;

      case DeviceStatus.disconnected:
      case DeviceStatus.disconnecting:
      default:
        return getIt<IAppConfig>().theme.cardBackgroundColor;
    }
  }

  Widget _buildV1Card(BuildContext context, PairedDevice device, DevicesVm vm) {
    return DeviceCard(
      background: getIt<IAppConfig>().theme.cardBackgroundColor,
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
                  backgroundColor:
                      getIt<IAppConfig>().theme.cardBackgroundColor,
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
              color: getIt<IAppConfig>().theme.darkRed,
              size: R.sizes.iconSize * 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
