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
    } catch (e) {
      return const RbioRouteError();
    }

    return RbioStackedScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.device_connections,
        ),
      ),

      //
      body: ChangeNotifierProvider(
        create: (BuildContext context) => SelectedDeviceVm(deviceType!),
        child: Consumer4<BleScannerOps, BleConnectorOps, BleReactorOps,
            SelectedDeviceVm>(
          builder: (
            _,
            _bleScannerOps,
            _bleConnectorOps,
            _bleReactorOps,
            _selectedDeviceVm,
            __,
          ) {
            return ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: R.sizes.stackedTopPaddingValue(context),
              ),
              children: [
                //
                Card(
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
                            style: Atom.context.xHeadline1
                                .copyWith(color: getIt<ITheme>().mainColor),
                          ),
                        ),

                        //
                        ..._selectedDeviceVm
                            .getPairOrder()
                            .entries
                            .map((data) => pairOrder(data.key, data.value))
                            .toList()
                      ],
                    ),
                  ),
                ),

                //
                ..._bleScannerOps.discoveredDevices.map(
                  (DiscoveredDevice device) {
                    final pairedDevices = _bleScannerOps.pairedDevices;
                    if (pairedDevices == null) return const SizedBox();

                    return _selectedDeviceVm.isFocusedDevice(device) &&
                            !pairedDevices.contains(device.id)
                        ? DeviceCard(
                            onTap: () => _selectedDeviceVm.connectDevice(
                                _bleConnectorOps, _bleScannerOps, device),
                            background: _bleConnectorOps
                                        .getStatus(device.id)
                                        ?.connectionState ==
                                    DeviceConnectionState.connected
                                ? getIt<ITheme>().mainColor
                                : _bleConnectorOps
                                            .getStatus(device.id)
                                            ?.connectionState ==
                                        DeviceConnectionState.connecting
                                    ? R.color.high
                                    : Colors.white,
                            image: UtilityManager().getDeviceImageFromType(
                                    _selectedDeviceVm.deviceType) ??
                                const SizedBox(),
                            name: device.name,
                          )
                        : const SizedBox();
                  },
                ).toList()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget pairOrder(String sequence, String text) {
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
                color: getIt<ITheme>().mainColor,
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
