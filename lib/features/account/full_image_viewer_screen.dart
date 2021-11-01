import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/core.dart';

class FullImageViewerScreen extends StatelessWidget {
  String title;
  String imagePath;

  FullImageViewerScreen({
    Key key,
    this.imagePath,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      title = Atom.queryParameters['title'];
      imagePath = Atom.queryParameters['imagePath'];
    } catch (_) {
      return QueryParametersError();
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: PhotoView(imageProvider: FileImage(File(imagePath))),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leading: IconButton(
        onPressed: () {
          Atom.historyBack();
        },
        icon: SvgPicture.asset(R.image.ic_back_white),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () => {shareFile(context, this.imagePath)},
            child: Platform.isIOS
                ? SvgPicture.asset(R.image.ic_ios_share)
                : SvgPicture.asset(R.image.ic_android_share),
          ),
        )
      ],
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
