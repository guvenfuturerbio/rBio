import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scale_repository/scale_repository.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../core/core.dart';

class ScaleTaggerVm extends ChangeNotifier {
  late ScaleEntity scaleModel;

  final bool isManuel;
  final BuildContext context;
  late TextEditingController weightController;
  late TextEditingController bmiController;
  late TextEditingController bodyFatController;
  late TextEditingController boneMassController;
  late TextEditingController muscleController;
  late TextEditingController visceralController;
  late TextEditingController waterController;
  late TextEditingController noteController;

  late ScrollController scrollController;
  int? key;

  String errorMessage = '';

  final picker = ImagePicker();

  ScaleTaggerVm({
    required this.context,
    ScaleEntity? scale,
    this.isManuel = false,
    this.key,
  }) {
    scaleModel = scale ??
        ScaleEntity(
          isManuel: isManuel,
          dateTime: DateTime.now(),
          unit: ScaleUnit.kg,
          age: Utils.instance.getAge(),
          gender: Utils.instance.getGender(),
          height: Utils.instance.getHeight(),
        );
    _fillControllers(isInit: true);
    scrollController = ScrollController();
  }

  void _fillControllers({bool isInit = false}) {
    if (isInit) {
      weightController = TextEditingController(
        text: scaleModel.weight != null ? scaleModel.weight.toString() : '',
      );
      noteController = TextEditingController(
        text: scaleModel.note,
      );
    }

    _fillbodyScale();
  }

  void _fillbodyScale() {
    bodyFatController = TextEditingController(
      text: scaleModel.bodyFat != null
          ? scaleModel.bodyFat!.toStringAsFixed(1)
          : '',
    );

    boneMassController = TextEditingController(
      text: scaleModel.boneMass != null
          ? scaleModel.boneMass!.toStringAsFixed(1)
          : '',
    );

    muscleController = TextEditingController(
      text: scaleModel.muscle != null
          ? scaleModel.muscle!.toStringAsFixed(1)
          : '',
    );

    visceralController = TextEditingController(
      text: scaleModel.visceralFat != null
          ? scaleModel.visceralFat!.toStringAsFixed(1)
          : '',
    );

    waterController = TextEditingController(
      text:
          scaleModel.water != null ? scaleModel.water!.toStringAsFixed(1) : '',
    );

    bmiController = TextEditingController(
      text: scaleModel.bmi != null ? scaleModel.bmi!.toStringAsFixed(2) : '',
    );
  }

  void changeWeight(String val) {
    if (val.isEmpty) return;
    val = val[val.length - 1] == ',' ? val + "0" : val;
    val = val.replaceAll(",", ".");

    val != ''
        ? scaleModel.weight = (double.tryParse(val) ?? 0)
        : scaleModel.weight = null;

    if (scaleModel.weight != null) {
      scaleModel.calculateVariables();
    } else {
      scaleModel.bmi = null;
    }

    _fillControllers();
    notifyListeners();
  }

  void changeBmi(String val) {
    val != '' ? scaleModel.bmi = double.parse(val) : scaleModel.bmi = null;
    notifyListeners();
  }

  void changeBodyFat(String val) {
    val != ''
        ? scaleModel.bodyFat = double.parse(val)
        : scaleModel.bodyFat = null;
    notifyListeners();
  }

  void changeBoneMass(String val) {
    val != ''
        ? scaleModel.boneMass = double.parse(val)
        : scaleModel.boneMass = null;
    notifyListeners();
  }

  void changeMuscle(String val) {
    val != ''
        ? scaleModel.muscle = double.parse(val)
        : scaleModel.muscle = null;
    notifyListeners();
  }

  void changeVisceral(String val) {
    val != ''
        ? scaleModel.visceralFat = double.parse(val)
        : scaleModel.visceralFat = null;
    notifyListeners();
  }

  void changeWater(String val) {
    val != '' ? scaleModel.water = double.parse(val) : scaleModel.water = null;
    notifyListeners();
  }

  void changeDate(DateTime val) {
    scaleModel.dateTime = val;
    notifyListeners();
  }

  void addNote(String val) {
    scaleModel.note = val;
    notifyListeners();
  }

  Future getImage(BuildContext context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = LocaleProvider.current.how_to_get_photo;

        return Platform.isIOS
            ? CupertinoAlertDialog(
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
            : AlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 22),
                ),
                actions: <Widget>[
                  RbioTextButton(
                    child: Text(LocaleProvider.current.camera),
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.camera);
                    },
                  ),
                  RbioTextButton(
                    child: Text(LocaleProvider.current.gallery),
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.gallery);
                    },
                  ),
                ],
              );
      },
    );
  }

  void getPhotoFromSource(
    BuildContext context,
    ImageSource imageSource,
  ) async {
    dynamic photoPerm, cameraPerm;

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
        UtilityManager().showConfirmationAlertDialog(
          context,
          LocaleProvider.current.warning,
          LocaleProvider.current.allow_permission_gallery,
          RbioTextButton(
            child: Text(
              LocaleProvider.current.confirm,
              style: context.xHeadline3.copyWith(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              AppSettings.openAppSettings();
            },
          ),
        );
        return;
      } else if (cameraPerm == PermissionStatus.denied ||
          cameraPerm == PermissionStatus.permanentlyDenied) {
        UtilityManager().showConfirmationAlertDialog(
          context,
          LocaleProvider.current.warning,
          LocaleProvider.current.allow_permission_gallery,
          RbioTextButton(
            child: Text(
              LocaleProvider.current.confirm,
              style: context.xHeadline3.copyWith(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              AppSettings.openAppSettings();
            },
          ),
        );
        return;
      }

      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) {
          Navigator.of(context).pop();
        },
      );

      if (pickedFile != null) {
        final fileName = basename(pickedFile.path);
        await pickedFile
            .saveTo(('${getIt<GuvenSettings>().appDocDirectory}/$fileName'));
        if (scaleModel.images.isNotEmpty) {
          scaleModel.images.add(pickedFile.path);
        } else {
          scaleModel.images = [pickedFile.path];
        }
      }

      notifyListeners();
    } catch (e, stk) {
      LoggerUtils.instance.e(e);
      debugPrintStack(stackTrace: stk);
    }
  }

  Future<void> save() async {
    try {
      if (weightController.text == '') {
        throw Exception(LocaleProvider.current.required_area);
      }
      scaleModel.dateTime = DateTime.now();

      //
      AddScaleMasurementBody model = AddScaleMasurementBody(
        entegrationId: getIt<ProfileStorageImpl>().getFirst().id,
        occurrenceTime: scaleModel.dateTime,
        weight: scaleModel.weight,
        water: scaleModel.water,
        bmi: scaleModel.bmi,
        bodyFat: scaleModel.bodyFat,
        bmh: scaleModel.bmh,
        visceralFat: scaleModel.visceralFat,
        boneMass: scaleModel.boneMass,
        muscle: scaleModel.muscle,
        scaleUnit: scaleModel.unit.xScaleToInt,
        deviceUUID: scaleModel.deviceId,
        note: scaleModel.note,
        isManuel: scaleModel.isManuel,
      );
      await getIt<ScaleRepository>().addScaleMeasurement(model);
      Atom.dismiss();
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> update() async {
    // TODO
    // await getIt<ScaleStorageImpl>().update(scaleModel.scaleModel, key);
    Atom.dismiss();
  }

  void deleteImageFromIndex(int index) {
    scaleModel.images.removeAt(index);
    notifyListeners();
  }
}
