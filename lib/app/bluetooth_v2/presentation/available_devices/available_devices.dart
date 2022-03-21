import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../bluetooth_v2.dart';

class DeviceListingScreen extends StatefulWidget {
  const DeviceListingScreen({Key? key}) : super(key: key);

  @override
  State<DeviceListingScreen> createState() => _DeviceListingScreenState();
}

class _DeviceListingScreenState extends State<DeviceListingScreen> {
  @override
  void initState() {
    context.read<DeviceSearchCubit>().startSearching(["MIBFS"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RbioStackedScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.device_connections,
        ),
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
                ),
                itemCount: deviceSearchState.devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        context
                            .read<DeviceSelectedCubit>()
                            .connect(deviceSearchState.devices[index]);
                      },
                      title: Text(
                        deviceSearchState.devices[index].name,
                        style: context.xHeadline3,
                      ),
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
}
