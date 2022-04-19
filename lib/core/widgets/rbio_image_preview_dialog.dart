import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../core.dart';

class RbioImagePreviewDialog extends StatelessWidget {
  final String? image;
  final File? fileImage;

  const RbioImagePreviewDialog({
    Key? key,
    this.image,
    this.fileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Stack(
          children: [
            PhotoViewGallery(
              gaplessPlayback: true,
              scrollPhysics: const ClampingScrollPhysics(),
              onPageChanged: (index) {},
              pageOptions: [
                PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: fileImage == null
                      ? NetworkImage(image!)
                      : FileImage(fileImage!) as ImageProvider<Object>,
                ),
              ],
              loadingBuilder: (context, event) {
                return const RbioLoading();
              },
            ),

            //
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white12,
                  onPressed: () {
                    Atom.dismiss();
                  },
                  child: Icon(
                    Icons.close,
                    size: R.sizes.iconSize,
                    color: getIt<IAppConfig>().theme.iconColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
