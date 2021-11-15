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
import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../../widgets/utils.dart';
import '../home/home_page_view_model.dart';
import 'ble_reactive_singleton.dart';

class BleReadingTagger extends StatefulWidget {
  final GlucoseData lastReading;
  final bool isManual;
  BleReadingTagger({this.lastReading = null, this.isManual = false});

  @override
  _BleReadingTagger createState() => _BleReadingTagger();
}

class _BleReadingTagger extends State<BleReadingTagger> {
  GlucoseData glucoseData;
  TextEditingController noteTextEditingController = new TextEditingController();
  String notes = "";
  String bgInput = "0";
  @override
  void initState() {
    super.initState();
    setState(() {
      glucoseData = new GlucoseData().fromGlucoseData(widget.lastReading);
      glucoseData.tag = 3;
      measureDT = new DateTime.fromMillisecondsSinceEpoch(glucoseData.time);
    });
    _bgInputController = new TextEditingController();
    _bgInputController.addListener(() {
      setState() {
        bgInput = _bgInputController.text;
        print("kek");
      }
    });
  }

  @override
  void dispose() {
    //stopScan();
    //Provider.of<BLEHandler>(context, listen: false).didShowDialog = false;
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
    return new Dialog(
        backgroundColor: R.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 16,
        child: ChangeNotifierProvider(
          create: (context) => HomePageViewModel(),
          child: Consumer<BLEHandler>(
            builder: (context, bleScanner, _) {
              return Container(
                  padding:
                      EdgeInsets.only(left: 4, right: 4, top: 16, bottom: 16),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      KeyboardAvoider(
                          child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              widget.isManual
                                  ? glucoseData.tag == 3
                                      ? getSquareBg(_bgInputController)
                                      : getCircleBg(
                                          glucoseData, glucoseData.tag == 2)
                                  : glucoseData.tag == 3
                                      ? MeasurementSquare(
                                          glucoseData: glucoseData,
                                          isFill: true,
                                        )
                                      : MeasurementCircle(
                                          glucoseData: glucoseData,
                                          isFill: glucoseData.tag == 2),
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
                                                minimumYear:
                                                    DateTime.now().year,
                                                maximumYear:
                                                    DateTime.now().year,
                                                minuteInterval: 1,
                                                mode: CupertinoDatePickerMode
                                                    .dateAndTime,
                                              ));
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 16, top: 16),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        glucoseData.tag = 1;
                                      });
                                    },
                                    child: Card(
                                      color: glucoseData.tag == 1
                                          ? R.btnDarkBlue
                                          : R.color.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: glucoseData.tag == 1
                                                ? <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ]
                                                : <Color>[
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                          ),
                                        ),
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
                                                R.image.beforemeal_icon_black,
                                                color: glucoseData.tag == 1
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                    LocaleProvider
                                                        .current.hungry,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            glucoseData.tag == 1
                                                                ? Colors.white
                                                                : Colors.black))
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
                                          ? R.btnDarkBlue
                                          : R.color.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: glucoseData.tag == 2
                                                ? <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ]
                                                : <Color>[
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                          ),
                                        ),
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
                                                R.image.aftermeal_icon_black,
                                                color: glucoseData.tag == 2
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                    LocaleProvider.current.full,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            glucoseData.tag == 2
                                                                ? Colors.white
                                                                : Colors
                                                                    .black)),
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
                                          ? R.btnDarkBlue
                                          : R.color.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: glucoseData.tag == 3
                                                ? <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ]
                                                : <Color>[
                                                    Colors.white,
                                                    Colors.white
                                                  ],
                                          ),
                                        ),
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
                                                R.image.fasting_icon_black,
                                                color: glucoseData.tag == 3
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(LocaleProvider.current.other,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: glucoseData.tag == 3
                                                        ? Colors.white
                                                        : Colors.black))
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
                                      padding:
                                          EdgeInsets.only(left: 8, top: 16),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: 60,
                                              height: 60,
                                              child: Card(
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  height: 25,
                                                  width: 25,
                                                  child: glucoseData.imageURL ==
                                                          ""
                                                      ? SvgPicture.asset(
                                                          R.image.addphoto_icon,
                                                        )
                                                      : PhotoView(
                                                          imageProvider: FileImage(File(
                                                              GlucoseRepository()
                                                                  .getImagePathOfImageURL(
                                                                      glucoseData
                                                                          .imageURL))),
                                                        ),
                                                ),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(LocaleProvider
                                                  .current.add_photo)),
                                        ],
                                      ))),
                              Container(
                                padding: EdgeInsets.only(top: 16),
                                height: 120,
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
                                              left: 12, right: 12),
                                          hintText:
                                              LocaleProvider.current.notes,
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelText:
                                              LocaleProvider.current.notes,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: Container(
                                          padding: EdgeInsets.only(top: 16),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            elevation: 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomRight,
                                                    end: Alignment.topLeft,
                                                    colors: <Color>[
                                                      R.color.white,
                                                      R.color.white
                                                    ]),
                                              ),
                                              padding: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  /*Container(
                                                  height: 24,
                                                  child: SvgPicture.asset(
                                                      R.image.power_icon),
                                                ),*/
                                                  Center(
                                                    child: Text(
                                                      LocaleProvider
                                                          .current.cancel,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .textScaleFactor *
                                                              20),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (glucoseData.level != "" &&
                                            glucoseData.level != "0") {
                                          if (widget.isManual) {
                                            glucoseData.manual = true;
                                          } else {
                                            glucoseData.manual = false;
                                          }
                                          glucoseData.note =
                                              noteTextEditingController.text ??
                                                  "";
                                          glucoseData.userId =
                                              UserProfilesNotifier()
                                                      .selection
                                                      ?.id ??
                                                  0;
                                          glucoseData.time =
                                              measureDT.millisecondsSinceEpoch;
                                          await GlucoseRepository()
                                              .addNewGlucoseData(
                                                  glucoseData, true);
                                          if (glucoseData.imageURL != null &&
                                              glucoseData.imageURL != "") {
                                            bleScanner
                                                .updateMeasurementImageUrl(
                                                    context,
                                                    glucoseData.imageURL,
                                                    glucoseData.time);
                                          }
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          elevation: 4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                  colors: <Color>[
                                                    R.btnLightBlue,
                                                    R.btnDarkBlue
                                                  ]),
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .textScaleFactor *
                                                            20),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ));
            },
          ),
        ));
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
        child: boxInsideSection());
  }

  Widget getBgInputWidget() {
    return TextFormField(
        controller: _bgInputController,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
    return Container(
      alignment: Alignment.center,
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFill
            ? UtilityManager()
                .getGlucoseMeasurementColor(int.parse(glucoseData.level))
            : Colors.white,
        border: Border.all(
          color: UtilityManager().getGlucoseMeasurementColor(int.parse(
              glucoseData.level)), //                   <--- border color
          width: 10.0,
        ),
      ),
      child: boxInsideSection(),
    );
  }

  Column boxInsideSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: getBgInputWidget()),
        SizedBox(
          height: 9,
        ),
        Text(
          "mg/dL",
        ),
      ],
    );
  }

  final picker = ImagePicker();
  File _image = new File("");

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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pop();
      });
      final Directory appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      await pickedFile.saveTo(('${appDir.path}/$fileName'));
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
    } catch (e, stk) {
      print(e);
      debugPrintStack(stackTrace: stk);
    }
  }
}
