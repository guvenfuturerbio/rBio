import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:share/share.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  GlobalKey globalKey = GlobalKey();
  String _dataString = "Hello from this QR";

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
        print('>>>>><PATH: ${file.path}');
        await FlutterShare.shareFile(
            title: 'deneme', filePath: file.path, fileType: 'image/png');
      } catch (e) {
        print(e.toString());
      }
    });
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              _captureAndSharePng();
            },
            icon: Icon(Icons.share))
      ]),
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
