import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/core.dart';

class FullPdfViewerScreen extends StatelessWidget {
  String title;
  String pdfPath;

  FullPdfViewerScreen({
    Key key,
    this.pdfPath,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      title = Uri.decodeFull(Atom.queryParameters['title']);
      pdfPath = Uri.decodeFull(Atom.queryParameters['pdfPath']);
    } catch (_) {
      return RbioRouteError();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => {shareFile(context, this.pdfPath)},
              child: Platform.isIOS
                  ? SvgPicture.asset(R.image.ic_ios_share)
                  : SvgPicture.asset(R.image.ic_android_share),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Atom.historyBack();
          },
          icon: SvgPicture.asset(R.image.ic_back_white),
        ),
      ),

      //
      body: Container(
        child: SfPdfViewer.file(File(pdfPath), canShowPaginationDialog: false),
      ),
    );
  }

  void shareFile(BuildContext context, String path) async {
    await FlutterShare.shareFile(
      title: LocaleProvider.of(context).share,
      text: title,
      filePath: path,
    );
  }
}
