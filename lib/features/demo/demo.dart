import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/core.dart';

class QRCodeGeneratorScreen extends StatefulWidget {
  const QRCodeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeGeneratorScreen> createState() => _QRCodeGeneratorScreenState();
}

class _QRCodeGeneratorScreenState extends State<QRCodeGeneratorScreen> {
  GlobalKey globalKey = GlobalKey();
  String _dataString = "Hello from this QR";
  TextEditingController controller = TextEditingController();

  Future<void> _captureAndSharePng() async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext
            ?.findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        Uint8List? pngBytes = byteData?.buffer.asUint8List();

        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/image.png').create();
        await file.writeAsBytes(pngBytes!);
        debugPrint('>>>>><PATH: ${file.path}');
        await FlutterShare.shareFile(
            title: 'deneme', filePath: file.path, fileType: 'image/png');
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _captureAndSharePng();
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(45),
              child: RbioTextFormField(
                hintText: 'Değer girin',
                controller: controller,
              ),
            ),
            RbioElevatedButton(
              title: 'Generate QR CODe',
              onTap: () {
                _captureAndSharePng();
                setState(() {
                  _dataString = controller.text;
                });
              },
            ),
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: _dataString,
                version: QrVersions.auto,
                size: 200.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
