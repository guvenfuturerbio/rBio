import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import 'gallery_pop_up_vm.dart';
import 'stepper/stepper.dart' as core;

class GalleryView extends StatelessWidget {
  final List<String> images;

  const GalleryView({
    Key? key,
    required this.images,
  }) : super(key: key);

  final String urlDetect =
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryPopUpVm(context),
      child: Consumer<GalleryPopUpVm>(
        builder: (_, value, __) {
          return Dialog(
            child: Stack(
              children: [
                //
                PhotoViewGallery(
                  gaplessPlayback: true,
                  scrollPhysics: const ClampingScrollPhysics(),
                  onPageChanged: value.changeIndex,
                  pageOptions: [
                    ...images.map(
                      (e) {
                        return PhotoViewGalleryPageOptions(
                          scaleStateController: value.controller,
                          minScale: PhotoViewComputedScale.contained,
                          imageProvider: getImageProvider(e),
                        );
                      },
                    ),
                  ],
                ),

                //
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: context.height * .03),
                    child: core.Stepper(
                      length: images.length,
                      currentIndex: value.currentIndex,
                    ),
                  ),
                ),

                //
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      value.close();
                    },
                    child: Icon(
                      Icons.close,
                      size: context.aspectRatio * 75,
                      color: R.color.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ImageProvider<Object>? getImageProvider(String e) {
    if (e.contains(RegExp(urlDetect))) {
      return NetworkImage(e);
    } else {
      return FileImage(File(e));
    }
  }
}
