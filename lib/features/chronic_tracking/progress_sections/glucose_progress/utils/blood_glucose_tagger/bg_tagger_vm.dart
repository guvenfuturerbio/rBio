import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../core/core.dart';

class BgTaggerVm extends ChangeNotifier {
  BgTaggerVm({
    this.context,
    this.isEdit = false,
    this.data,
    this.isManual,
    this.key,
  }) {
    controller.text = data.level ?? '';
    noteController.text = data.note ?? '';
  }

  final key;
  final BuildContext context;
  final GlucoseData data;
  final bool isEdit;
  final bool isManual;
  final TextEditingController controller = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime get date => data.time == null
      ? DateTime.now()
      : DateTime.fromMillisecondsSinceEpoch(data.time);

  void onChanged(String value) {
    data.level = controller.text == '' ? '0' : controller.text;
    notifyListeners();
  }

  onChangeDate(DateTime value) {
    data.time = value.millisecondsSinceEpoch;
    notifyListeners();
  }

  changeTag(int tag) {
    data.tag = tag;
    notifyListeners();
  }

  void getPhotoFromSource(ImageSource imageSource) async {
    var photoPerm, cameraPerm;
    final picker = ImagePicker();

    try {
      try {
        if (imageSource == ImageSource.gallery) {
          photoPerm = await Permission.storage.request();

          if (Platform.isAndroid) {
            photoPerm = await Permission.storage.request();
          }
        } else {
          cameraPerm = await Permission.camera.request();
          print(cameraPerm);
        }
      } catch (e) {
        print(e);
      }

      if (photoPerm == PermissionStatus.denied ||
          photoPerm == PermissionStatus.permanentlyDenied) {
        permissionDeniedDialog();
        return;
      } else if (cameraPerm == PermissionStatus.denied ||
          cameraPerm == PermissionStatus.permanentlyDenied) {
        permissionDeniedDialog();
        return;
      }

      final PickedFile pickedFile = await picker.getImage(source: imageSource);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
      final fileName = basename(pickedFile.path);
      final file = File(fileName);
      await file.copy('${getIt<GuvenSettings>().appDocDirectory}/$fileName');
      if (pickedFile != null) {
        changePic(pickedFile, fileName);
      } else {
        print('No image selected.');
      }
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  changePic(PickedFile file, String fileName) {
    data.imageFile = file;
    data.imageURL = fileName;
  }

  void permissionDeniedDialog() {
    UtilityManager().showConfirmationAlertDialog(
      context,
      LocaleProvider.current.warning,
      LocaleProvider.current.allow_permission_gallery,
      TextButton(
        style: TextButton.styleFrom(primary: R.color.white),
        child: Text(LocaleProvider.current.confirm),
        onPressed: () async {
          Navigator.pop(context, 'dialog');
          AppSettings.openAppSettings();
        },
      ),
    );
  }

  void leftAction() {
    Atom.dismiss();
  }

  Future<void> rightAction() async {
    if (data.level != "" && data.level != "0") {
      data.note = noteController.text ?? "";
      data.userId = getIt<ProfileStorageImpl>().getFirst().id ?? 0;
      data.tag = data.tag ?? 3;

      await getIt<GlucoseStorageImpl>().write(data, shouldSendToServer: true);
      if (data.imageURL != null && data.imageURL != "") {
        await getIt<GlucoseStorageImpl>().updateImage(data.imageURL, data.key);
      }
    }
    Atom.dismiss();
  }

  Future<void> update() async {
    data.note = noteController.text ?? "";
    if (data.imageURL != null && data.imageURL != "") {
      getIt<GlucoseStorageImpl>().updateImage(data.imageURL, key);
    } else {
      await getIt<GlucoseStorageImpl>().update(data, key);
    }

    Atom.dismiss();
  }
}
