import 'package:image_picker/image_picker.dart';

abstract class ImageManager {
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
    CameraDevice? cameraDevice,
  });
  Future<PickedFile?> getImage({
    required ImageSource source,
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
    CameraDevice? cameraDevice,
  });

  Future<PickedFile?> getPickedImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) {
    return getImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      cameraDevice: preferredCameraDevice,
    );
  }
}

class ImageManagerImpl extends ImageManager {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
    CameraDevice? cameraDevice,
  }) {
    try {
      return imagePicker.pickImage(
        source: source,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        preferredCameraDevice: cameraDevice ?? CameraDevice.rear,
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<PickedFile?> getImage({
    required ImageSource source,
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
    CameraDevice? cameraDevice,
  }) {
    try {
      // ignore: deprecated_member_use
      return imagePicker.getImage(
        source: source,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        preferredCameraDevice: cameraDevice ?? CameraDevice.rear,
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
