// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';

class QrCodeScanScreen extends StatefulWidget {
  const QrCodeScanScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScanScreen> createState() => _QrCodeScanScreenState();
}

class _QrCodeScanScreenState extends State<QrCodeScanScreen> {
  String? text = 'Unknown';

  Future<void> initPlatformState() async {
    late String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  // String? result;
  void getPhotoFromSource(ImageSource imageSource) async {
    late PermissionStatus photoPerm;
    final picker = ImagePicker();

    try {
      try {
        if (imageSource == ImageSource.gallery) {
          photoPerm = await Permission.storage.request();

          if (Platform.isAndroid) {
            photoPerm = await Permission.storage.request();
          }
        }
      } catch (e, stackTrace) {
        getIt<IAppConfig>()
            .platform
            .sentryManager
            .captureException(e, stackTrace: stackTrace);
        LoggerUtils.instance.e(e);
      }

      if (photoPerm == PermissionStatus.denied ||
          photoPerm == PermissionStatus.permanentlyDenied) {
        //permissionDeniedDialog();
        return;
      }

      // ignore: deprecated_member_use
      final PickedFile? pickedFile = await picker.getImage(source: imageSource);

      if (pickedFile != null) {
        String? result = await Scan.parse(pickedFile.path);
        if (result != null) {
          setState(() {
            text = result;
          });
        } else {
          null;
        }
      } else {
        LoggerUtils.instance.e('No image selected.');
      }
    } catch (e, stk) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stk);
      LoggerUtils.instance.e(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RbioElevatedButton(
                title: 'ScanQrCode',
                onTap: () {
                  getPhotoFromSource(ImageSource.gallery);
                },
              ),
              Text(text!),
            ]),
      ),
    );
  }
}
