import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../core/core.dart';

class BgTaggerVm extends ChangeNotifier {
  BgTaggerVm({
    required this.context,
    this.isEdit = false,
    required this.data,
    required this.isManual,
    required this.key,
  });

  final int? key;
  final BuildContext context;
  final GlucoseData data;
  final bool isEdit;
  final bool isManual;
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(data.time);

  void onChanged(String value) {
    data.level = value == '' ? '0' : value;
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
    late PermissionStatus photoPerm, cameraPerm;
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
        }
      } catch (e) {
        LoggerUtils.instance.e(e);
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

      final PickedFile? pickedFile = await picker.getImage(source: imageSource);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });

      if (pickedFile != null) {
        final fileName = basename(pickedFile.path);
        final file = File(fileName);
        await file.copy('${getIt<GuvenSettings>().appDocDirectory}/$fileName');
        changePic(pickedFile, fileName);
      } else {
        LoggerUtils.instance.e('No image selected.');
      }
    } catch (e, stk) {
      LoggerUtils.instance.e(e);
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
        style: TextButton.styleFrom(primary: getIt<IAppConfig>().theme.white),
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

  Future<void> rightAction(String note) async {
    if (data.level != "" && data.level != "0") {
      data.note = note;
      data.userId = getIt<ProfileStorageImpl>().getFirst().id;
      data.tag = data.tag ?? 3;

      await getIt<GlucoseStorageImpl>().write(data, shouldSendToServer: true);
      if (data.imageURL != null && data.imageURL != "") {
        getIt<GlucoseStorageImpl>().updateImage(data.imageURL!, data.key);
      }
    }
    Atom.dismiss();
  }

  Future<void> update(String note) async {
    data.note = note;
    if (data.imageURL != null && data.imageURL != "") {
      getIt<GlucoseStorageImpl>().updateImage(data.imageURL!, key);
    } else {
      await getIt<GlucoseStorageImpl>().update(data, key);
    }

    Atom.dismiss();
  }
}
