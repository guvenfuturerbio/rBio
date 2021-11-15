import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../generated/l10n.dart';
import '../../../helper/resources.dart';
import '../../../widgets/utils.dart';
import 'file_viewer_page_view_model.dart';

class FileViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    String filePath = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => FileViewerPageViewModel(filePath: filePath),
      child: Consumer<FileViewerPageViewModel>(
        builder: (context, value, child) {
          return Scaffold(
              appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(
                  title: value?.title ?? " ",
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () => {shareFile(context, filePath)},
                      child: Platform.isIOS
                          ? SvgPicture.asset(R.image.ios_share)
                          : SvgPicture.asset(R.image.android_share),
                    ),
                  )
                ],
                leading: ButtonBackWhite(context),
              ),
              body: value.fileType == FileType.PDF
                  ? Container(
                      child: SfPdfViewer.file(File(filePath),
                          canShowPaginationDialog: false))
                  : Container(
                      child: PhotoView(
                        imageProvider: FileImage(File(filePath)),
                      ),
                      decoration: BoxDecoration(),
                    ));
        },
      ),
    );
  }

  void shareFile(BuildContext context, String path) async {
    await FlutterShare.shareFile(
      title: LocaleProvider.current.share,
      text: " ",
      filePath: path,
    );
  }
}
