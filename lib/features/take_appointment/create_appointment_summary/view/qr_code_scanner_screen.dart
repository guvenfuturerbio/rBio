import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/core.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  String? code;
  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    formats: [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
  );

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      bodyPadding: EdgeInsets.zero,
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
    return MobileScanner(
      allowDuplicates: false,
      controller: controller,
      fit: BoxFit.contain,
      onDetect: (barcode, args) {
        if (barcode.rawValue != null && code != barcode.rawValue) {
          code = barcode.rawValue!;
          Navigator.of(context).pop(code);
        }
      },
    );
  }
}
