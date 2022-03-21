import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class DeviceListingScreen extends StatelessWidget {
  DeviceType? deviceType;

  DeviceListingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final deviceTypeStr = Atom.queryParameters['device_type'];
      if (deviceTypeStr != null && deviceType == null) {
        deviceType = deviceTypeStr.toType;
        _startScan(context);
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
        actions: [
          IconButton(
            onPressed: () => _restartScan(context),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      //
      body: BlocBuilder<DeviceSearchCubit, DeviceSearchState>(
        builder: (context, deviceSearchState) {
          switch (deviceSearchState.status) {
            case DeviceSearchStatus.initial:
              return const SizedBox();

            case DeviceSearchStatus.searching:
              return const RbioLoading();

            case DeviceSearchStatus.done:
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: R.sizes.stackedTopPaddingValue(context),
                  bottom: R.sizes.defaultBottomValue,
                ),
                itemCount: deviceSearchState.devices.length,
                itemBuilder: (BuildContext context, int index) {
                  final discoveredDevice = deviceSearchState.devices[index];

                  return BlocProvider<DeviceStatusCubit>(
                    create: (context) => DeviceStatusCubit(getIt())
                      ..readStatus(discoveredDevice),
                    child: BlocConsumer<DeviceStatusCubit, DeviceStatus?>(
                      listener: (context, deviceStatusState) =>
                          _deviceStatusListen(
                        context,
                        deviceStatusState,
                        discoveredDevice,
                      ),
                      builder: (context, deviceStatusState) {
                        return Card(
                          key: ValueKey(index),
                          elevation: R.sizes.defaultElevation,
                          shape: RoundedRectangleBorder(
                            borderRadius: R.sizes.borderRadiusCircular,
                          ),
                          color: _getBackColor(deviceStatusState),
                          child: ListTile(
                            onTap: () => _deviceOnTap(
                              context,
                              deviceStatusState,
                              discoveredDevice,
                            ),
                            title: Text(
                              discoveredDevice.name,
                              style: context.xHeadline3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              discoveredDevice.id,
                              style: context.xHeadline4,
                            ),
                            trailing: Visibility(
                              visible:
                                  deviceStatusState == DeviceStatus.connected,
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );

            case DeviceSearchStatus.error:
              return const RbioBodyError();
          }
        },
      ),
    );
  }

  void _startScan(BuildContext context) {
    context.read<DeviceSearchCubit>().startSearching(deviceType!);
  }

  Future<void> _restartScan(BuildContext context) async {
    context.read<DeviceSearchCubit>().stopScan();
    await Future.delayed(const Duration(milliseconds: 250));
    _startScan(context);
  }

  void _deviceOnTap(
    BuildContext context,
    DeviceStatus? deviceStatusState,
    DeviceEntity discoveredDevice,
  ) {
    if (deviceStatusState == null ||
        deviceStatusState == DeviceStatus.disconnected) {
      context.read<DeviceSelectedCubit>().connect(discoveredDevice);
    }
  }

  void _deviceStatusListen(
    BuildContext context,
    DeviceStatus? deviceStatusState,
    DeviceEntity discoveredDevice,
  ) {
    if (deviceStatusState == DeviceStatus.connected) {
      Utils.instance.showSnackbar(
        context,
        LocaleProvider.current.pair_successful,
        backColor: getIt<ITheme>().mainColor,
      );
      context
          .read<MiScaleReadValuesCubit>()
          .readValue(discoveredDevice, "Weight");
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Atom.to(PagePaths.main, isReplacement: true);
        },
      );
    }
  }

  Color _getBackColor(DeviceStatus? deviceStatus) {
    switch (deviceStatus) {
      case DeviceStatus.connecting:
        return R.color.high;

      case DeviceStatus.connected:
        return getIt<ITheme>().mainColor;

      case DeviceStatus.disconnecting:
      case DeviceStatus.disconnected:
      default:
        return Colors.white;
    }
  }
}
