import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

import '../../../../../../core/core.dart';

class FullPdfViewerScreen extends StatelessWidget {
  final String title;
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath, this.title);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          backgroundColor: R.color.darkBlue,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: SvgPicture.asset(R.image.back_icon)),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () => {shareFile(context, this.pdfPath)},
                  child: SvgPicture.asset(
                    R.image.export_icon,
                    width: 30,
                    height: 30,
                  )),
            )
          ],
        ),
        path: pdfPath);
  }

  void shareFile(BuildContext context, String path) async {
    await Share.shareFiles(
      [this.pdfPath],
      text: title,
    );
  }
}
