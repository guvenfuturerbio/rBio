part of '../view/chat_screen.dart';

class ImagePreviewDialog extends StatelessWidget {
  final String image;

  const ImagePreviewDialog({Key key, this.image})
      : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: R.sizes.borderRadiusCircular,
        ),
        child: ClipRRect(
          borderRadius: R.sizes.borderRadiusCircular,
          child: Stack(
            children: [
              PhotoViewGallery(
                gaplessPlayback: true,
                scrollPhysics: ClampingScrollPhysics(),
                onPageChanged: (index) {},
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    minScale: PhotoViewComputedScale.contained,
                    imageProvider: NetworkImage(image),
                  ),
                ],
                loadingBuilder: (context, event) {
                  return RbioLoading();
                },
              ),

              //
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Atom.dismiss();
                  },
                  icon: Icon(
                    Icons.close,
                    size: R.sizes.iconSize,
                    color: getIt<ITheme>().iconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
