import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

part 'widget/setup_dialog.dart';

class DeviceListingScreen extends StatefulWidget {
  const DeviceListingScreen({Key? key}) : super(key: key);

  @override
  State<DeviceListingScreen> createState() => _DeviceListingScreenState();
}

class _DeviceListingScreenState extends State<DeviceListingScreen> {
  DeviceType? deviceType;

  @override
  void initState() {
    super.initState();
    Future(
      () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const DeviceSetupDialog();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      final deviceTypeStr = Atom.queryParameters['device_type'];
      if (deviceTypeStr != null) {
        deviceType = deviceTypeStr.xDeviceType;
        _restartScan(context);
      }
    } catch (e) {
      return const RbioRouteError();
    }

    return WillPopScope(
      onWillPop: () async {
        _stopScan(context);
        return true;
      },
      child: RbioStackedScaffold(
        appbar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.current.device_connections,
      ),
      leading: Align(
        alignment: Alignment.center,
        child: InkWell(
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
            child: SvgPicture.asset(
              R.image.back,
              width: R.sizes.iconSize,
            ),
          ),
          onTap: () {
            _stopScan(context);
            Atom.historyBack();
          },
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _restartScan(context),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<DeviceSearchCubit, DeviceSearchState>(
      builder: (context, deviceSearchState) {
        switch (deviceSearchState.status) {
          case DeviceSearchStatus.initial:
            return const SizedBox();

          case DeviceSearchStatus.searching:
            return const RbioLoading();

          case DeviceSearchStatus.done:
            return _buildSuccess(deviceSearchState.devices);

          case DeviceSearchStatus.error:
            return const RbioBodyError();
        }
      },
    );
  }

  Widget _buildSuccess(List<DeviceEntity> devices) {
    if (devices.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          R.sizes.stackedTopPadding(context),
          R.sizes.hSizer32,

          //
          RbioJumpingDots(
            fontSize: 30,
            dotSpacing: 10,
          ),
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: R.sizes.stackedTopPaddingValue(context),
        bottom: R.sizes.defaultBottomValue,
      ),
      itemCount: devices.length,
      itemBuilder: (BuildContext context, int index) {
        final discoveredDevice = devices[index];
        final hasExist = getIt<BluetoothLocalManager>()
            .hasDeviceAlreadyPaired(discoveredDevice);
        if (hasExist) {
          return const SizedBox();
        }

        return BlocProvider<DeviceStatusCubit>(
          create: (context) =>
              DeviceStatusCubit(getIt())..readStatus(discoveredDevice),
          child: BlocConsumer<DeviceStatusCubit, DeviceStatus?>(
            listener: (context, deviceStatusState) => _deviceStatusListen(
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
                    visible: deviceStatusState == DeviceStatus.connected,
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
  }

  void _startScan(BuildContext context) {
    context.read<DeviceSearchCubit>().startSearching(deviceType!);
  }

  void _stopScan(BuildContext context) {
    BlocProvider.of<DeviceSearchCubit>(context).stopScan();
  }

  Future<void> _restartScan(BuildContext context) async {
    _stopScan(context);
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

  Future<void> _deviceStatusListen(
    BuildContext context,
    DeviceStatus? deviceStatusState,
    DeviceEntity device,
  ) async {
    if (deviceStatusState == DeviceStatus.connected) {
      Utils.instance.showSnackbar(
        context,
        LocaleProvider.current.pair_successful,
        backColor: getIt<ITheme>().mainColor,
      );

      await getIt<BluetoothLocalManager>().savePairedDevices(device);

      switch (deviceType) {
        case DeviceType.miScale:
          {
            BlocProvider.of<MiScaleCubit>(context).readValue(device);
            break;
          }

        case DeviceType.accuChek:
        case DeviceType.contourPlusOne:
        case DeviceType.omronBloodPressureArm:
        case DeviceType.omronBloodPressureWrist:
        case DeviceType.omronScale:
        case DeviceType.manuel:
        default:
          break;
      }

      _stopScan(context);

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

      case DeviceStatus.disconnected:
      case DeviceStatus.disconnecting:
      default:
        return getIt<ITheme>().cardBackgroundColor;
    }
  }
}
