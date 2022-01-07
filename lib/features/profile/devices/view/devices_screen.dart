part of '../devices.dart';

class DevicesScreen extends StatefulWidget {
  DevicesScreen({Key key}) : super(key: key);

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
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
          builder: (context, value, child) {
            return _buildBody(value);
          },
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody(DevicesVm vm) {
    switch (vm.state) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return vm.devices.length > 0
            ? ListView(
                shrinkWrap: true,
                children: [
                  ...vm.devices
                      .map((device) => Column(
                            children: [
                              DeviceCard(
                                background: getIt<ITheme>().cardBackgroundColor,
                                image: UtilityManager()
                                    .getDeviceImageFromType(device.deviceType),
                                name:
                                    '${device.manufacturerName}\n${device.serialNumber ?? ''}',
                                trailing: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.info,
                                          size: R.sizes.iconSize,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Atom.show(GuvenAlert(
                                              backgroundColor: getIt<ITheme>()
                                                  .cardBackgroundColor,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 25),
                                              title: GuvenAlert.buildTitle(
                                                LocaleProvider.current.warning,
                                              ),
                                              content: GuvenAlert.buildDescription(
                                                  '${LocaleProvider.current.ble_delete_paired_device_approv}'),
                                              actions: [
                                                GuvenAlert.buildBigMaterialAction(
                                                    '${LocaleProvider.current.cancel}',
                                                    () => Atom.dismiss()),
                                                GuvenAlert.buildBigMaterialAction(
                                                    '${LocaleProvider.current.yes}',
                                                    () => vm.deletePairedDevice(
                                                        device.deviceId))
                                              ]));
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: R.color.darkRed,
                                          size: R.sizes.iconSize,
                                        )),
                                  ],
                                ),
                              ),
                              _buildVerticalGap()
                            ],
                          ))
                      .toList()
                ],
              )
            : Center(
                child: Text(
                  LocaleProvider.current.add_new_device,
                  textAlign: TextAlign.center,
                  style: context.xHeadline1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: getIt<ITheme>().mainColor,
      onPressed: () {
        Atom.to(PagePaths.ALL_DEVICES);
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
