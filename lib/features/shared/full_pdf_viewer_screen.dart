import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/core.dart';

class FullPdfViewerScreen extends StatelessWidget {
  String? title;
  String? pdfPath;

  FullPdfViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      title = Uri.decodeFull(Atom.queryParameters['title']!);
      pdfPath = Uri.decodeFull(Atom.queryParameters['pdfPath'] as String);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
        title: RbioAppBar.textTitle(context, title ?? "No title"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                if (pdfPath != null) {
                  shareFile(context, pdfPath!);
                }
              },
              child: Platform.isIOS
                  ? SvgPicture.asset(R.image.iosShare)
                  : SvgPicture.asset(R.image.androidShare),
            ),
          )
        ],
      ),

      //
      body: pdfPath == null
          ? const SizedBox()
          : SfPdfViewer.file(
              File(pdfPath!),
              canShowPaginationDialog: false,
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
