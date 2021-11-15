import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/database/SqlitePersistence.dart';
import 'package:onedosehealth/database/datamodels/glucose_data.dart';
import 'package:onedosehealth/database/repository/glucose_repository.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/helper/resources.dart';
import 'package:onedosehealth/models/bg_measurement/bg_measurement_view_model.dart';
import 'package:onedosehealth/notifiers/bg_measurements_notifiers.dart';
import 'package:onedosehealth/notifiers/stripcount_tracker.dart';
import 'package:onedosehealth/pages/ble_device_connection/ble_reactive_singleton.dart';
import 'package:onedosehealth/pages/home/home_page_view_model.dart';
import 'package:onedosehealth/widgets/bg_measurement_list.dart';
import 'package:onedosehealth/widgets/main_appbar.dart';
import 'package:onedosehealth/widgets/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:onedosehealth/helper/extensions/string_extension.dart';

class BleReadingTaggerList extends StatefulWidget {
  @override
  _BleReadingTaggerList createState() => _BleReadingTaggerList();
}

class _BleReadingTaggerList extends State<BleReadingTaggerList> {
  static const LAST_PAIRED_DEVICE_KEY = "LAST_PAIRED_DEVICE_KEY";

  List<DiscoveredDevice> _devices = new List();
  FlutterReactiveBle reactivebleclient;
  StreamSubscription _subscription;
  final serviceUUIDS = [Uuid.parse("FC00"), Uuid.parse("1808")];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //stopScan();
    super.dispose();
  }

  bool removedStrips = false;
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Consumer<BLEHandler>(
        builder: (context, bleHandler, _) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: TitleAppBarWhite(
                    title: LocaleProvider.current.device_connections),
                leading: InkWell(
                    child: SvgPicture.asset(R.image.back_icon),
                    onTap: () => Navigator.of(context).pop())),
            body: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                SafeArea(
                  child: Container(
                      padding: EdgeInsets.only(top: 100),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 16),
                            child: GestureDetector(
                              onTap: () {
                                bleHandler.clearReadings();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: Container(
                                height: 50,
                                color: R.color.light_blue,
                                child: Center(
                                  child: Text(
                                    LocaleProvider.current.finish,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          removedStrips == false
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (removedStrips == false) {
                                        removedStrips = true;
//                                  StripCountTracker().decrementBy(bleHandler.glucoseReadings.length);
                                        StripCountTracker.decrementAndSave(
                                            bleHandler.glucoseReadings.length);
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 80,
                                    color: R.color.very_low,
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                        child: Text(LocaleProvider
                                            .current.strip_detected_message
                                            .format(List<String>()
                                              ..add(bleHandler
                                                  .glucoseReadings.length
                                                  .toString())
                                              ..add(bleHandler
                                                  .glucoseReadings.length
                                                  .toString())))),
                                  ),
                                )
                              : Container(),
                          GroupedListView<GlucoseData, DateTime>(
                            elements: bleHandler.glucoseReadings,
                            order: GroupedListOrder.DESC,
                            controller: scrollController,
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            floatingHeader: true,
                            shrinkWrap: true,
                            useStickyGroupSeparators: false,
                            groupBy: (GlucoseData gData) {
                              DateTime measureDT =
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      gData.time);
                              DateTime dateTime = new DateTime(measureDT.year,
                                  measureDT.month, measureDT.day);
                              return dateTime;
                            },
                            groupHeaderBuilder: (GlucoseData glucoseData) {
                              //print(bgMeasurementViewModel.date);
                              return Container(
                                height: 50,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      gradient: GreenGradient(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(new DateTime.fromMillisecondsSinceEpoch(glucoseData.time))}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemBuilder: (_, GlucoseData glucoseData) {
                              DateTime measureDT =
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      glucoseData.time);
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      elevation: 8.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0, vertical: 3.0),
                                      child: Visibility(
                                        visible: true,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              height: 150,
                                              padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 8,
                                                  top: 8),
                                              color: Colors.grey,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "${measureDT.hour > 9 ? measureDT.hour : "0" + measureDT.hour.toString()}:${measureDT.minute > 9 ? measureDT.minute : "0" + measureDT.minute.toString()}   ",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      glucoseData.tag == 3
                                                          ? MeasurementContainer(
                                                              glucoseData:
                                                                  glucoseData)
                                                          : MeasurementCircleSmall(
                                                              level: glucoseData
                                                                  .level,
                                                              isFill: glucoseData
                                                                      .tag ==
                                                                  2),
                                                      GestureDetector(
                                                        onTap: () {
                                                          //print("Rebuilding glucoseData $glucoseData");
                                                          //print(bleHandler.glucoseReadings);
                                                          setState(() {
                                                            glucoseData.tag = 1;
                                                          });
                                                          bleHandler
                                                              .assignTagToMeasurement(
                                                                  context,
                                                                  1,
                                                                  glucoseData
                                                                      .time);
                                                        },
                                                        child: Card(
                                                          color: (glucoseData
                                                                          .tag ==
                                                                      null ||
                                                                  glucoseData
                                                                          .tag ==
                                                                      0)
                                                              ? R.color.white
                                                              : glucoseData
                                                                          .tag ==
                                                                      1
                                                                  ? R.color
                                                                      .defaultBlue
                                                                  : R.color
                                                                      .white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          elevation: 4,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 16,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 20,
                                                                  child: SvgPicture
                                                                      .asset(R
                                                                          .image
                                                                          .beforemeal_icon_black),
                                                                ),
                                                                Text(
                                                                  LocaleProvider.of(
                                                                          context)
                                                                      .bef,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
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
                                                          bleHandler
                                                              .assignTagToMeasurement(
                                                                  context,
                                                                  2,
                                                                  glucoseData
                                                                      .time);
                                                        },
                                                        child: Card(
                                                          color: (glucoseData
                                                                          .tag ==
                                                                      null ||
                                                                  glucoseData
                                                                          .tag ==
                                                                      0)
                                                              ? R.color.white
                                                              : glucoseData
                                                                          .tag ==
                                                                      2
                                                                  ? R.color
                                                                      .defaultBlue
                                                                  : R.color
                                                                      .white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          elevation: 4,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 16,
                                                                    top: 8,
                                                                    bottom: 8),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 20,
                                                                  child: SvgPicture
                                                                      .asset(R
                                                                          .image
                                                                          .aftermeal_icon_black),
                                                                ),
                                                                Text(
                                                                  LocaleProvider.of(
                                                                          context)
                                                                      .aft,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                ),
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
                                                          bleHandler
                                                              .assignTagToMeasurement(
                                                                  context,
                                                                  3,
                                                                  glucoseData
                                                                      .time);
                                                        },
                                                        child: Card(
                                                          color:
                                                              glucoseData.tag ==
                                                                      3
                                                                  ? R.color
                                                                      .defaultBlue
                                                                  : R.color
                                                                      .white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          elevation: 4,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 16,
                                                                    right: 16,
                                                                    top: 10,
                                                                    bottom: 10),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: SvgPicture
                                                                      .asset(R
                                                                          .image
                                                                          .fasting_icon_black),
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                4),
                                                                    child: Text(
                                                                        LocaleProvider
                                                                            .current
                                                                            .oth,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10)))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        getImage(
                                                            context,
                                                            glucoseData,
                                                            bleHandler);
                                                      },
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8,
                                                                  top: 16),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                  width: 60,
                                                                  height: 60,
                                                                  child: Card(
                                                                    elevation:
                                                                        4,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                      child: glucoseData.imageURL ==
                                                                              ""
                                                                          ? SvgPicture
                                                                              .asset(
                                                                              R.image.addphoto_icon,
                                                                            )
                                                                          : PhotoView(
                                                                              imageProvider: FileImage(File(glucoseData.imageURL)),
                                                                            ),
                                                                    ),
                                                                  )),
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8),
                                                                  child: Text(LocaleProvider.of(
                                                                          context)
                                                                      .add_photo)),
                                                            ],
                                                          ))),
                                                ],
                                              )),
                                        ),
                                      )),
                                ),
                              );
                            },
                          )
                        ],
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  String connState = "NO INFO";
  final List<BgMeasurementViewModel> bgMeasurements = new List();
  final ScrollController scrollController = new ScrollController();
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

    final XFile pickedFile = await picker.pickImage(source: imageSource);
    Navigator.of(context).pop();

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
  }
}
