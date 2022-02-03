part of '../../devices.dart';

class AvailableDevices extends StatelessWidget {
  const AvailableDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.supported_devices,
      ),
    );
  }

  Widget _buildBody() {
    return ChangeNotifierProvider<AvailableDevicesVm>(
      create: (_) => AvailableDevicesVm(),
      child: Consumer<AvailableDevicesVm>(
        builder: (
          BuildContext context,
          AvailableDevicesVm vm,
          Widget child,
        ) {
          return context.xTextScaleType == TextScaleType.Small
              ? GridView.count(
                  padding: EdgeInsets.only(
                    top: RbioStackedScaffold.kHeight(context),
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  childAspectRatio: 5 / 4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  children: vm.items
                      .map((item) => _buildCard(context, item, true))
                      .toList(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: RbioStackedScaffold.kHeight(context),
                    bottom: R.sizes.defaultBottomValue,
                  ),
                  children: vm.items
                      .map((item) => _buildCard(context, item, false))
                      .toList(),
                );
        },
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    DeviceConnectionType device,
    bool isGridItem,
  ) {
    return GestureDetector(
      onTap: device.enable
          ? () {
              Atom.to(
                PagePaths.SELECTED_DEVICE,
                queryParameters: {'device_type': device.deviceType.name},
              );
            }
          : null,
      child: Container(
        padding: isGridItem
            ? EdgeInsets.symmetric(horizontal: 4)
            : EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          elevation: 4,
          color: device.enable ? null : R.color.bg_gray,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    device.imagePath,
                  ),
                ),

                //
                R.sizes.wSizer4,

                //
                Expanded(
                  flex: 3,
                  child: Text(
                    device.name ?? LocaleProvider.current.unknown,
                    style: context.xHeadline3,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
