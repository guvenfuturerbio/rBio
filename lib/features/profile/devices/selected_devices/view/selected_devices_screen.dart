part of '../../devices.dart';

class SelectedDevicesScreen extends StatelessWidget {
  DeviceType? deviceType;

  SelectedDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final deviceTypeStr = Atom.queryParameters['device_type'];
      if (deviceTypeStr != null) {
        deviceType = deviceTypeStr.toType;
      }
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return RbioStackedScaffold(
      appbar: RbioAppBar(
        context: context,
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.device_connections,
        ),
      ),

      //
      body: ChangeNotifierProvider(
        create: (BuildContext context) => SelectedDeviceVm(deviceType!),
        child: Consumer2<BleReactorOps, SelectedDeviceVm>(
          builder: (
            _,
            _bleReactorOps,
            _selectedDeviceVm,
            __,
          ) {
            return BlocBuilder<BluetoothBloc, BluetoothV1State>(
              builder: (context, bluetoothState) {
                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: R.sizes.stackedTopPaddingValue(context),
                  ),
                  children: [
                    //
                    Card(
                      elevation: R.sizes.defaultElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: R.sizes.borderRadiusCircular,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                LocaleProvider.current.pair_steps,
                                style: Atom.context.xHeadline1.copyWith(
                                  color: context.xPrimaryColor,
                                ),
                              ),
                            ),

                            //
                            ..._selectedDeviceVm
                                .getPairOrder()
                                .entries
                                .map((data) =>
                                    pairOrder(context, data.key, data.value))
                                .toList()
                          ],
                        ),
                      ),
                    ),

                    //
                    ...bluetoothState.discoveredDevices.map(
                      (DiscoveredDevice device) {
                        final pairedDevices = bluetoothState.pairedDeviceIds;

                        if (_selectedDeviceVm.isFocusedDevice(device) &&
                            !pairedDevices.contains(device.id)) {
                          return DeviceCard(
                            onTap: () => _selectedDeviceVm.connectDevice(
                              bluetoothState,
                              device,
                            ),
                            background: getIt<BleConnector>()
                                        .getStatus(device.id)
                                        ?.connectionState ==
                                    DeviceConnectionState.connected
                                ? context.xPrimaryColor
                                : getIt<BleConnector>()
                                            .getStatus(device.id)
                                            ?.connectionState ==
                                        DeviceConnectionState.connecting
                                    ? getIt<IAppConfig>().theme.high
                                    : Colors.white,
                            image: Utils.instance.getDeviceImageFromType(
                                    _selectedDeviceVm.deviceType) ??
                                const SizedBox(),
                            name: device.name,
                          );
                        }

                        return const SizedBox();
                      },
                    ).toList()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget pairOrder(
    BuildContext context,
    String sequence,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          //
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              sequence,
              style: Atom.context.xHeadline1.copyWith(
                color: context.xPrimaryColor,
              ),
            ),
          ),

          //
          Expanded(
            child: Text(
              text,
              style: Atom.context.xHeadline3,
            ),
          ),
        ],
      ),
    );
  }
}
