import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

part 'widget/setup_dialog.dart';

class DeviceSearchScreen extends StatelessWidget {
  DeviceSearchScreen({Key? key}) : super(key: key);

  DeviceType? deviceType;

  @override
  Widget build(BuildContext context) {
    try {
      final deviceTypeStr = Atom.queryParameters['device_type'];
      if (deviceTypeStr != null) {
        deviceType = deviceTypeStr.xDeviceType;

        if (deviceType == DeviceType.miScale) {
          final heightCheck = Utils.instance.checkUserHeight();
          if (heightCheck) {
            return DeviceSearchView(deviceType: deviceType!);
          }
        } else {
          return DeviceSearchView(deviceType: deviceType!);
        }

        return RbioScaffold(
          appbar: RbioAppBar(
            context: context,
          ),
          body: Container(),
        );
      }

      return RbioScaffold(
        appbar: RbioAppBar(context: context),
        body: Container(),
      );
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }
  }
}

class DeviceSearchView extends StatefulWidget {
  final DeviceType deviceType;

  const DeviceSearchView({
    Key? key,
    required this.deviceType,
  }) : super(key: key);

  @override
  _DeviceSearchViewState createState() => _DeviceSearchViewState();
}

class _DeviceSearchViewState extends State<DeviceSearchView> {
  void _showSetupDialog() {
    Future(
      () {
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return DeviceSetupDialog(deviceType: widget.deviceType);
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSetupDialog();
      _restartScan(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _setInitState(context);
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
      context: context,
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
            _setInitState(context);
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
          R.widgets.stackedTopPadding(context),
          R.widgets.hSizer32,

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
    BlocProvider.of<DeviceSearchCubit>(context)
        .startSearching(widget.deviceType);
  }

  void _stopScan(BuildContext context) {
    BlocProvider.of<DeviceSearchCubit>(context).stopScan();
  }

  void _setInitState(BuildContext context) {
    BlocProvider.of<DeviceSearchCubit>(context).setInitState();
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
      Utils.instance.showSuccessSnackbar(
        context,
        LocaleProvider.current.pair_successful,
      );

      await getIt<BluetoothLocalManager>().savePairedDevices(device);

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
        return getIt<IAppConfig>().theme.high;

      case DeviceStatus.connected:
        return context.xPrimaryColor;

      case DeviceStatus.disconnected:
      case DeviceStatus.disconnecting:
      default:
        return context.xCardColor;
    }
  }
}
