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
                    switch (_selectedDeviceVm.deviceType) {
                      case DeviceType.accuChek:
                      case DeviceType.contourPlusOne:
                      case DeviceType.miScale:
                      case DeviceType.manuel:
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
                      case DeviceType.omronBloodPressureArm:
                      case DeviceType.omronBloodPressureWrist:
                      case DeviceType.omronScale:
                        return StreamBuilder<List<int>>(
                            stream: _selectedDeviceVm.isOmronFocused(device),
                            builder: (_, value) {
                              LoggerUtils.instance.w(value.connectionState);
                              if (value.connectionState ==
                                  ConnectionState.waiting) {
                                return FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Card(
                                    elevation: R.sizes.defaultElevation,
                                    color: getIt<ITheme>().cardBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          R.sizes.borderRadiusCircular,
                                    ),
                                    child: SizedBox(
                                      height: context.height * .1,
                                      child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: RbioLoading()),
                                    ),
                                  ),
                                );
                              } else {
                                if (value.hasData &&
                                    String.fromCharCodes(value.data!) ==
                                        'RS7 Intelli IT') {
                                  return DeviceCard(
                                    onTap: () =>
                                        _selectedDeviceVm.connectDevice(
                                            _bleConnectorOps,
                                            _bleScannerOps,
                                            device),
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
                                    image: UtilityManager()
                                            .getDeviceImageFromType(
                                                _selectedDeviceVm.deviceType) ??
                                        const SizedBox(),
                                    name: device.name,
                                  );
                                } else if (value.hasError) {
                                  return FractionallySizedBox(
                                    widthFactor: 1,
                                    child: Card(
                                      elevation: R.sizes.defaultElevation,
                                      color:
                                          getIt<ITheme>().cardBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            R.sizes.borderRadiusCircular,
                                      ),
                                      child: SizedBox(
                                        height: context.height * .1,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(value.error.toString())),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }
                            });
                    }
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
