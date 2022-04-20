part of '../device_search_screen.dart';

class DeviceSetupDialog extends StatefulWidget {
  final DeviceType deviceType;

  const DeviceSetupDialog({
    Key? key,
    required this.deviceType,
  }) : super(key: key);

  @override
  State<DeviceSetupDialog> createState() => _DeviceSetupDialogState();
}

class _DeviceSetupDialogState extends State<DeviceSetupDialog> {
  late VideoPlayerController _controller;

  String _getVideoPath() {
    switch (widget.deviceType) {
      case DeviceType.accuCheck:
        return R.constants.accuCheckSetup;

      case DeviceType.contourPlusOne:
        return R.constants.contourPlusOneSetup;

      case DeviceType.miScale:
        return R.constants.miScaleSetup;

      case DeviceType.pillarSmall:
        return R.constants.miScaleSetup;

      case DeviceType.omronBloodPressureArm:
      case DeviceType.omronBloodPressureWrist:
      case DeviceType.omronScale:
      case DeviceType.manuel:
        break;
    }

    return "";
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(_getVideoPath())
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: R.sizes.screenPadding(context),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            _controller.value.isInitialized
                ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(),
                  ),

            //
            RbioElevatedButton(
              title: LocaleProvider.of(context).Ok,
              infinityWidth: true,
              showElevation: false,
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
