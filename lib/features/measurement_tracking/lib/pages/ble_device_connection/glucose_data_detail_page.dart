import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../database/datamodels/glucose_data.dart';
import '../../database/repository/glucose_repository.dart';
import '../../extension/size_extension.dart';
import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../widgets/utils.dart';
import '../home/home_page_view_model.dart';
import 'ble_reactive_singleton.dart';

class GlucoseDataDetailPage extends StatefulWidget {
  final GlucoseData glucoseData;
  GlucoseDataDetailPage({this.glucoseData});

  @override
  _GlucoseDataDetailPage createState() => _GlucoseDataDetailPage();
}

class _GlucoseDataDetailPage extends State<GlucoseDataDetailPage> {
  GlucoseData glucoseData;
  TextEditingController noteTextEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      glucoseData = new GlucoseData().fromGlucoseData(widget.glucoseData);
      measureDT = new DateTime.fromMillisecondsSinceEpoch(glucoseData.time);
    });
    _bgInputController = new TextEditingController();
    _bgInputController.text = widget.glucoseData.level.toString();
    noteTextEditingController.text = widget.glucoseData.note;
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController _bgInputController;
  Widget getPicker() {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        measureDT = newdate;
      },
      use24hFormat: true,
      maximumDate: DateTime.now(),
      minimumYear: DateTime.now().year,
      maximumYear: DateTime.now().year,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  DateTime measureDT = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Consumer<BLEHandler>(
        builder: (context, bleScanner, _) {
          return Container(
              padding: EdgeInsets.only(left: 4, right: 4, bottom: 16, top: 16),
              decoration: BoxDecoration(
                color: R.color.background,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  KeyboardAvoider(
                      child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          widget.glucoseData.manual
                              ? (glucoseData.tag == 3
                                  ? getSquareBg(_bgInputController)
                                  : getCircleBg(
                                      glucoseData, glucoseData.tag == 2))
                              : (glucoseData.tag == 3
                                  ? MeasurementSquare(
                                      glucoseData: glucoseData,
                                      isFill: true,
                                    )
                                  : MeasurementCircle(
                                      glucoseData: glucoseData,
                                      isFill: glucoseData.tag == 2)),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                          height: 260,
                                          child: CupertinoDatePicker(
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged:
                                                (DateTime newdate) {
                                              setState(() {
                                                measureDT = newdate;
                                              });
                                            },
                                            use24hFormat: true,
                                            maximumDate: DateTime.now(),
                                            minimumYear: DateTime.now().year,
                                            maximumYear: DateTime.now().year,
                                            minuteInterval: 1,
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                          ));
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 16, top: 16),
                                child: Card(
                                  color: R.color.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              "${UtilityManager().getReadableDate(measureDT)}"),
                                          Text(
                                              "${UtilityManager().getReadableHour(measureDT)}")
                                        ],
                                      )),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    glucoseData.tag = 1;
                                  });
                                },
                                child: Card(
                                  color: glucoseData.tag == 1
                                      ? R.color.defaultBlue
                                      : R.color.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              R.image.beforemeal_icon_black),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              LocaleProvider.current.before,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(LocaleProvider.current.meal,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 10))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    glucoseData.tag = 2;
                                  });
                                },
                                child: Card(
                                  color: glucoseData.tag == 2
                                      ? R.color.defaultBlue
                                      : R.color.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              R.image.aftermeal_icon_black),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(LocaleProvider.current.after,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 10)),
                                            Text(LocaleProvider.current.meal,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 10))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    glucoseData.tag = 3;
                                  });
                                },
                                child: Card(
                                  color: glucoseData.tag == 3
                                      ? R.color.defaultBlue
                                      : R.color.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                              R.image.fasting_icon_black),
                                        ),
                                        Text(LocaleProvider.current.other,
                                            style: TextStyle(fontSize: 10))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                getImage(context, glucoseData, bleScanner);
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(left: 8, top: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 250,
                                          height: 250,
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              height: 25,
                                              width: 25,
                                              child: glucoseData.imageURL == ""
                                                  ? SvgPicture.asset(
                                                      R.image.addphoto_icon,
                                                    )
                                                  : PhotoView(
                                                      imageProvider: FileImage(
                                                          File(GlucoseRepository()
                                                              .getImagePathOfImageURL(
                                                                  glucoseData
                                                                      .imageURL))),
                                                    ),
                                            ),
                                          )),
                                    ],
                                  ))),
                          Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Card(
                              color: R.color.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 4,
                              child: TextField(
                                  controller: noteTextEditingController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 8),
                                      hintText: LocaleProvider.current.notes,
                                      hintStyle: TextStyle(fontSize: 12),
                                      labelText: LocaleProvider.current.notes,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        //  when the TextFormField in unfocused
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        //  when the TextFormField in focused
                                      ),
                                      border: UnderlineInputBorder())),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (glucoseData.level != "" &&
                                  glucoseData.level != "0") {
                                glucoseData.note =
                                    noteTextEditingController.text ?? "";
                                GlucoseRepository()
                                    .updateGlucoseData(glucoseData, true);
                                if (glucoseData.imageURL != null &&
                                    glucoseData.imageURL != "") {
                                  bleScanner.updateMeasurementImageUrl(context,
                                      glucoseData.imageURL, glucoseData.time);
                                }
                              }
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 150,
                              padding: EdgeInsets.only(top: 16),
                              child: Card(
                                color: R.color.defaultBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 4,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      /*Container(
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                      R.image.power_icon),
                                                ),*/
                                      Center(
                                        child: Text(
                                          LocaleProvider.current.save,
                                          style: TextStyle(
                                              fontSize: context.TEXTSCALE * 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ));
        },
      ),
    );
  }

  String connState = "NO INFO";

  // HELPERS
  Widget getSquareBg(TextEditingController onChangedController) {
    return Container(
      alignment: Alignment.center,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: UtilityManager()
            .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              glucoseData.level)), //                   <--- border color
          width: 5.0,
        ),
      ), //             <--- BoxDecoration here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            child: Theme(
              data: ThemeData(primaryColor: Colors.black),
              child: getBgInputWidget(),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Text(
            "mg/dL",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget getBgInputWidget() {
    return TextFormField(
        enabled: widget.glucoseData.manual ?? true,
        controller: _bgInputController,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxLength: 3,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            glucoseData.level = value == "" ? "0" : value;
          });
        },
        decoration: InputDecoration(
          counterText: '',
          errorStyle: TextStyle(height: 0),
        ),
        validator: (input) {
          if (input.isNotEmpty)
            return null;
          else
            return "";
        });
  }

  Widget getCircleBg(GlucoseData glucoseData, bool isFill) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundColor: UtilityManager()
                  .getGlucoseMeasurementColor(int.parse(glucoseData.level)),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: isFill
                    ? UtilityManager().getGlucoseMeasurementColor(
                        int.parse(glucoseData.level))
                    : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.black),
                        child: getBgInputWidget(),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      "mg/dL",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();

  Future getImage(
      BuildContext context, GlucoseData gData, BLEHandler bleHandler) async {
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
                      getPhotoFromSource(
                          context, ImageSource.camera, gData, bleHandler);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      LocaleProvider.current.gallery,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      getPhotoFromSource(
                          context, ImageSource.gallery, gData, bleHandler);
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
                      getPhotoFromSource(
                          context, ImageSource.camera, gData, bleHandler);
                    },
                  ),
                  FlatButton(
                    child: Text(LocaleProvider.current.gallery),
                    onPressed: () {
                      getPhotoFromSource(
                          context, ImageSource.gallery, gData, bleHandler);
                    },
                  )
                ],
              );
      },
    );
  }

  void getPhotoFromSource(BuildContext context, ImageSource imageSource,
      GlucoseData gData, BLEHandler bleHandler) async {
    var photoPerm, cameraPerm;
    if (imageSource == ImageSource.gallery) {
      photoPerm = await Permission.photos.request();
      if (Platform.isAndroid) {
        photoPerm = await Permission.storage.request();
      }
    } else {
      cameraPerm = await Permission.camera.request();
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

    final PickedFile pickedFile = await picker.getImage(source: imageSource);
    Navigator.of(context).pop();

    final Directory appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(pickedFile.path);
    final file = File(fileName);
    await file.copy('${appDir.path}/$fileName');
    if (pickedFile != null) {
      setState(() {
        print(pickedFile.path);
        gData.imageFile = pickedFile;
        gData.imageURL = fileName;
        print(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }
}
