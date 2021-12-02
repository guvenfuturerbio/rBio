import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/chronic_tracking/progress_sections/scale_progress/utils/scale_measurements/scale_measurement_vm.dart';
import 'package:onedosehealth/model/ble_models/DeviceTypes.dart';
import 'package:onedosehealth/model/ble_models/paired_device.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../generated/l10n.dart';

class ScaleTaggerVm extends ChangeNotifier {
  ScaleMeasurementViewModel scaleModel;
  final bool isManuel;
  final BuildContext context;
  TextEditingController weightController;
  TextEditingController bmiController;
  TextEditingController bodyFatController;
  TextEditingController boneMassController;
  TextEditingController muscleController;
  TextEditingController visceralController;
  TextEditingController waterController;
  TextEditingController noteController;

  ScrollController scrollController;

  String errorMessage = '';

  final picker = ImagePicker();

  ScaleTaggerVm({this.context, this.scaleModel, this.isManuel = false}) {
    if (scaleModel == null) {
      scaleModel = ScaleMeasurementViewModel(
          scaleModel: ScaleModel(
              isManuel: isManuel,
              device: PairedDevice(
                      deviceId: 'manuel',
                      deviceType: DeviceType.MANUEL,
                      manufacturerName: 'manuel',
                      modelName: 'manuel',
                      serialNumber: 'manuel')
                  .toJson(),
              unit: ScaleUnit.KG));
    }
    _fillControllers(isInit: true);
    scrollController = ScrollController();
  }

  _fillControllers({bool isInit = false}) {
    if (isInit) {
      weightController = TextEditingController(
          text: scaleModel.weight != null
              ? scaleModel.weight.toStringAsFixed(1)
              : '');
      noteController = TextEditingController(text: scaleModel.note ?? '');
    }
    _fillbodyScale();
  }

  _fillbodyScale() {
    bodyFatController = TextEditingController(
        text: scaleModel.bodyFat != null
            ? scaleModel.bodyFat.toStringAsFixed(1)
            : '');
    boneMassController = TextEditingController(
        text: scaleModel.boneMass != null
            ? scaleModel.boneMass.toStringAsFixed(1)
            : '');
    muscleController = TextEditingController(
        text: scaleModel.muscle != null
            ? scaleModel.muscle.toStringAsFixed(1)
            : '');
    visceralController = TextEditingController(
        text: scaleModel.visceralFat != null
            ? scaleModel.visceralFat.toStringAsFixed(1)
            : '');
    waterController = TextEditingController(
        text: scaleModel.water != null
            ? scaleModel.water.toStringAsFixed(1)
            : '');
    bmiController = TextEditingController(
        text: scaleModel.bmi != null ? scaleModel.bmi.toStringAsFixed(0) : '');
  }

  changeWeight(String val) {
    try {
      val != ''
          ? scaleModel.weight = double.parse(val)
          : scaleModel.weight = null;
      if (scaleModel.weight != null) {
        scaleModel.calculateVariables();
      } else {
        scaleModel.bmi = null;
      }
      _fillControllers();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  changeBmi(String val) {
    val != '' ? scaleModel.bmi = double.parse(val) : scaleModel.bmi = null;
    notifyListeners();
  }

  changeBodyFat(String val) {
    val != ''
        ? scaleModel.bodyFat = double.parse(val)
        : scaleModel.bodyFat = null;
    notifyListeners();
  }

  changeBoneMass(String val) {
    val != ''
        ? scaleModel.boneMass = double.parse(val)
        : scaleModel.boneMass = null;
    notifyListeners();
  }

  changeMuscle(String val) {
    val != ''
        ? scaleModel.muscle = double.parse(val)
        : scaleModel.muscle = null;
    notifyListeners();
  }

  changeVisceral(String val) {
    val != ''
        ? scaleModel.visceralFat = double.parse(val)
        : scaleModel.visceralFat = null;
    notifyListeners();
  }

  changeWater(String val) {
    val != '' ? scaleModel.water = double.parse(val) : scaleModel.water = null;
    notifyListeners();
  }

  changeDate(DateTime val) {
    scaleModel.dateTime = val;
    notifyListeners();
  }

  addNote(String val) {
    scaleModel.note = val;
    notifyListeners();
  }

  Future getImage(BuildContext context) async {
    // Don't Touch this show dialog this workin fine!!!!

    await showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          String title = LocaleProvider.current.how_to_get_photo;
          return Platform.isIOS
              ? new CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(LocaleProvider.current.pick_a_photo_option),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text(
                        LocaleProvider.current.camera,
                      ),
                      isDefaultAction: true,
                      onPressed: () {
                        getPhotoFromSource(context, ImageSource.camera);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text(
                        LocaleProvider.current.gallery,
                      ),
                      isDefaultAction: true,
                      onPressed: () {
                        getPhotoFromSource(context, ImageSource.gallery);
                      },
                    ),
                  ],
                )
              : new AlertDialog(
                  title: Text(
                    title,
                    style: TextStyle(fontSize: 22),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(LocaleProvider.current.camera),
                      onPressed: () {
                        getPhotoFromSource(context, ImageSource.camera);
                      },
                    ),
                    FlatButton(
                      child: Text(LocaleProvider.current.gallery),
                      onPressed: () {
                        getPhotoFromSource(context, ImageSource.gallery);
                      },
                    )
                  ],
                );
        });
  }

  void getPhotoFromSource(
    BuildContext context,
    ImageSource imageSource,
  ) async {
    print(scaleModel.images.length);
    var photoPerm, cameraPerm;

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
        UtilityManager().showConfirmationAlertDialog(
            context,
            LocaleProvider.current.warning,
            LocaleProvider.current.allow_permission_gallery,
            FlatButton(
              child: Text(LocaleProvider.current.confirm),
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pop();
                AppSettings.openAppSettings();
              },
            ));
        return;
      } else if (cameraPerm == PermissionStatus.denied ||
          cameraPerm == PermissionStatus.permanentlyDenied) {
        UtilityManager().showConfirmationAlertDialog(
            context,
            LocaleProvider.current.warning,
            LocaleProvider.current.allow_permission_gallery,
            FlatButton(
              child: Text(LocaleProvider.current.confirm),
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pop();
                AppSettings.openAppSettings();
              },
            ));
        return;
      }
      final XFile pickedFile = await picker.pickImage(source: imageSource);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
      final fileName = basename(pickedFile.path);
      await pickedFile
          .saveTo(('${getIt<GuvenSettings>().appDocDirectory}/$fileName'));

      if (pickedFile != null) {
        print(pickedFile.path);
        if (scaleModel.images.isNotEmpty) {
          scaleModel.images.add(pickedFile.path);
        } else {
          scaleModel.images = [pickedFile.path];
        }
        print(pickedFile.path);
      } else {
        print('No image selected.');
      }
      print(scaleModel.images.length);

      notifyListeners();
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  void save() {
    try {
      if (weightController.text == '') {
        throw Exception('${LocaleProvider.current.required_area}');
      }
      print(scaleModel.bmi);
      if (scaleModel.dateTime == null) {
        scaleModel.dateTime = DateTime.now();
      }
      getIt<ScaleStorageImpl>()
          .write(scaleModel.scaleModel, shouldSendToServer: false);
      Atom.dismiss();
    } catch (e) {
      print(e);
    }
  }

  update() {
    print(scaleModel);
    getIt<ScaleStorageImpl>()
        .update(scaleModel.scaleModel, scaleModel.scaleModel.key);
    Atom.dismiss();
  }

  void deleteImageFromIndex(int index) {
    scaleModel.images.removeAt(index);
    notifyListeners();
  }
}
