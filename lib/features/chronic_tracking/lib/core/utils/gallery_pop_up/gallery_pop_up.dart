import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../../extension/size_extension.dart';
import '../../../helper/strings.dart';
import '../stepper/stepper.dart' as core;
import 'gallery_pop_up_vm.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key key, this.images})
      : assert(images != null),
        super(key: key);
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryPopUpVm(context),
      child: Consumer<GalleryPopUpVm>(
        builder: (_, value, __) => Dialog(
          child: Stack(
            children: [
              PhotoViewGallery(
                gaplessPlayback: true,
                scrollPhysics: ClampingScrollPhysics(),
                onPageChanged: value.changeIndex,
                pageOptions: [
                  ...images.map((e) => PhotoViewGalleryPageOptions(
                      scaleStateController: value.controller,
                      minScale: PhotoViewComputedScale.contained,
                      imageProvider: e.contains(RegExp(Strings.urlDetect))
                          ? NetworkImage(e)
                          : FileImage(File(e))))
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: context.HEIGHT * .03),
                    child: core.Stepper(
                      length: images.length,
                      currentIndex: value.currentIndex,
                    )),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 'dialog');
                    },
                    child: Icon(
                      Icons.close,
                      size: context.ASPECTRATIO * 75,
                      color: R.color.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
