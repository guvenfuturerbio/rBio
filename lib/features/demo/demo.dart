import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

class QRCodeGeneratorScreen extends StatefulWidget {
  QRCodeGeneratorScreen({required this.name, required this.id, Key? key})
      : super(key: key);
  String name;
  String id;

  @override
  State<QRCodeGeneratorScreen> createState() => _QRCodeGeneratorScreenState();
}

class _QRCodeGeneratorScreenState extends State<QRCodeGeneratorScreen> {
  String? text;
  GlobalKey globalKey = GlobalKey();
  Future<void> _captureAndSharePng() async {
    try {
      final boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (kIsWeb) {
        html.Blob blob = html.Blob([pngBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download = 'deneme' + '.png';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/image.png').create();
        await file.writeAsBytes(pngBytes!);
        await FlutterShare.shareFile(
            title: 'deneme', filePath: file.path, fileType: 'image/png');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    text = '{"name":${widget.name}:","id":${widget.id}}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () async {
              await _captureAndSharePng();
            },
            icon: kIsWeb ? const Icon(Icons.download) : const Icon(Icons.share))
      ]),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: text!,
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
