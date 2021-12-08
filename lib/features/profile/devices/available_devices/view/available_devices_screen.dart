part of '../../devices.dart';

class AvailableDevices extends StatelessWidget {
  const AvailableDevices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
        appbar: RbioAppBar(
          title: RbioAppBar.textTitle(
              context, LocaleProvider.current.supported_devices),
        ),
        body: ChangeNotifierProvider<AvailableDevicesVm>(
          create: (_) => AvailableDevicesVm(),
          child: Consumer<AvailableDevicesVm>(
            builder: (_, val, __) {
              return GridView.count(
                padding: EdgeInsets.only(top: 95),
                childAspectRatio: 5 / 3,
                crossAxisCount: 2,
                children: val.items
                    .map((item) => deviceTypeContainer(context, item))
                    .toList(),
              );
            },
          ),
        ));
  }

  Widget deviceTypeContainer(
      BuildContext context, DeviceConnectionType device) {
    return new GestureDetector(
      onTap: device.enable
          ? () {
              Atom.to(PagePaths.SELECTED_DEVICE,
                  queryParameters: {'device_type': device.deviceType.name});
            }
          : null,
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Card(
            elevation: 4,
            color: device.enable ? null : R.color.bg_gray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 2, child: Image.asset(device.imagePath)),
                  Expanded(
                    flex: 3,
                    child: Text(device.name ?? LocaleProvider.current.unknown,
                        style: context.xHeadline2),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
