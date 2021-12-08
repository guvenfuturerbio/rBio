part of '../../devices.dart';

class SelectedDevicesScreen extends StatelessWidget {
  const SelectedDevicesScreen({Key key, this.deviceType}) : super(key: key);
  final DeviceType deviceType;

  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
        appbar: RbioAppBar(
          title: TitleAppBarWhite(
              title: LocaleProvider.current.device_connections),
        ),
        body: ChangeNotifierProvider(
          create: (_) => SelectedDeviceVm(
              deviceType: Atom.queryParameters['device_type'].toType),
          child: Consumer4<BleScannerOps, BleConnectorOps, BleReactorOps,
                  SelectedDeviceVm>(
              builder: (_, _bleScannerOps, _bleConnectorOps, _bleReactorOps,
                  _selectedDeviceVm, __) {
            return ListView(
              padding: EdgeInsets.only(top: 95),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(children: [
                      Center(
                        child: Text(
                          LocaleProvider.current.pair_steps,
                          style: Atom.context.xHeadline1
                              .copyWith(color: getIt<ITheme>().mainColor),
                        ),
                      ),
                      ..._selectedDeviceVm
                          .getPairOrder()
                          .entries
                          .map((data) => pairOrder(data.key, data.value))
                          .toList()
                    ]),
                  ),
                ),
                ..._bleScannerOps.discoveredDevices
                    .map((device) => _selectedDeviceVm
                                .isFocusedDevice(device) &&
                            !_bleScannerOps.pairedDevices.contains(device.id)
                        ? DeviceCard(
                            onTap: () => _selectedDeviceVm.connectDevice(
                                _bleConnectorOps, _bleScannerOps, device),
                            background: _bleConnectorOps
                                        ?.getStatus(device.id)
                                        ?.connectionState ==
                                    DeviceConnectionState.connected
                                ? getIt<ITheme>().mainColor
                                : _bleConnectorOps
                                            ?.getStatus(device.id)
                                            ?.connectionState ==
                                        DeviceConnectionState.connecting
                                    ? R.color.high
                                    : Colors.white,
                            image: UtilityManager().getDeviceImageFromType(
                                _selectedDeviceVm.deviceType),
                            name: device.name,
                          )
                        : SizedBox())
                    .toList()
              ],
            );
          }),
        ));
  }

  Widget pairOrder(String sequence, String text) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(sequence,
                  style: Atom.context.xHeadline1
                      .copyWith(color: getIt<ITheme>().mainColor)),
            ),
            Expanded(child: Text(text, style: Atom.context.xHeadline3))
          ],
        )

        /* RichText(
          textScaleFactor: Atom.context.TEXTSCALE,
          text: TextSpan(
            text: '$sequence - ',
            style: Atom.context.xHeadline1
                .copyWith(color: getIt<ITheme>().mainColor),
            children: <TextSpan>[
              TextSpan(text: text, style: Atom.context.xHeadline3),
            ],
          ),
        ) */
        );
  }
}
