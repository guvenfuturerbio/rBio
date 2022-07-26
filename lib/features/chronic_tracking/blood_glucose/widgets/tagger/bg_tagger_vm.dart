import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../core/core.dart';
import '../../model/model.dart';

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

  void onChangeDate(DateTime value) {
    data.time = value.millisecondsSinceEpoch;
    notifyListeners();
  }

  void changeTag(int tag) {
    data.tag = tag;
    notifyListeners();
  }

  void changePic(XFile file, String fileName) {
    data.imageFile = file;
    data.imageURL = fileName;
  }

  void permissionDeniedDialog() {
    showConfirmationAlertDialog(
      context,
      LocaleProvider.current.warning,
      LocaleProvider.current.allow_permission_gallery,
      TextButton(
        style: TextButton.styleFrom(
          primary: context.xCurrentTheme.white,
        ),
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
