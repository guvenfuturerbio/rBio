part of '../devices.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
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
      floatingActionButton: _buildFab(context),
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

  Widget _buildFab(BuildContext context) {
    return RbioSVGFAB.primaryColor(
      context,
      imagePath: R.image.add,
      onPressed: () {
        Atom.to(PagePaths.allDevices);
      },
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
                background: _getBackgroundColorV2(context, deviceStatus),
                image:
                    Utils.instance.getDeviceImageFromType(device.deviceType!) ??
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
                            backgroundColor: context.xCardColor,
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
                                context,
                                LocaleProvider.current.cancel,
                                () => Atom.dismiss(),
                              ),
                              GuvenAlert.buildBigMaterialAction(
                                context,
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
            return BlocProvider<PillarSmallCubit>(
              create: (context) => PillarSmallCubit(getIt()),
              child: BlocBuilder<PillarSmallCubit, bool>(
                builder: (context, pillarSmallState) {
                  return deviceCard(
                    pillarSmallTrigger: IconButton(
                      onPressed: () {
                        context.read<PillarSmallCubit>().trigger(device);
                      },
                      icon: Icon(
                        Icons.turn_slight_right,
                        size: R.sizes.iconSize * 1.25,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return deviceCard();
          }
        },
      ),
    );
  }

  Color _getBackgroundColorV2(
    BuildContext context,
    DeviceStatus? deviceStatus,
  ) {
    switch (deviceStatus) {
      case DeviceStatus.connecting:
        return getIt<IAppConfig>().theme.high;

      case DeviceStatus.connected:
        return context.xPrimaryColor;

      case DeviceStatus.disconnected:
      case DeviceStatus.disconnecting:
      default:
        return context.xCardColor;
    }
  }

  Widget _buildV1Card(BuildContext context, PairedDevice device, DevicesVm vm) {
    return DeviceCard(
      background: context.xCardColor,
      image: Utils.instance.getDeviceImageFromType(device.deviceType!) ??
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
                  backgroundColor: context.xCardColor,
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
                      context,
                      LocaleProvider.current.cancel,
                      () => Atom.dismiss(),
                    ),
                    GuvenAlert.buildBigMaterialAction(
                      context,
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
