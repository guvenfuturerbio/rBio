import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/core.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key key}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  StreamSubscription<Barcode> streamSubscription;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        leading: RbioAppBar.defaultLeading(
          context,
          () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildQrView()),
          SizedBox(height: Atom.safeBottom),
        ],
      ),
    );
  }

  Widget _buildQrView() {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: getIt<ITheme>().mainColor,
        borderRadius: 20,
        borderLength: 15,
        borderWidth: 5,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(ctrl, p),
    );
  }

  String code;
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    streamSubscription = controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        if (scanData.code != null && code != scanData.code) {
          code = scanData.code;
          Navigator.of(context).pop(scanData.code);
        }
      }
    });
  }

  void _onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LocaleProvider.current.no_permission,
          ),
        ),
      );
    }
  }
}
