import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_plugin/zoom_options.dart';
import 'package:flutter_zoom_plugin/zoom_view.dart';
import 'package:get/get.dart';
import 'package:onedosehealth/core/widgets/guven_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/core.dart';

class ZoomMeetingScreen extends StatefulWidget {
  ZoomOptions zoomOptions;
  ZoomMeetingOptions meetingOptions;

  ZoomMeetingScreen({
    Key key,
    this.zoomOptions,
    this.meetingOptions,
  }) : super(key: key) {}

  @override
  _ZoomMeetingScreenState createState() => _ZoomMeetingScreenState();
}

class _ZoomMeetingScreenState extends State<ZoomMeetingScreen> {
  Timer timer;

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  // Helper Components
  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
        title: LocaleProvider.of(context).load_zoom_meeting);
  }

  @override
  Widget build(BuildContext context) {
    widget.zoomOptions = Get.rootDelegate.arguments<ZoomOptions>();
    widget.meetingOptions = Get.rootDelegate.arguments<ZoomMeetingOptions>();

    return new Scaffold(
      appBar: MainAppBar(
        context: context,
        title: getTitleBar(context),
        leading: ButtonBackWhite(context),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ZoomView(onViewCreated: (controller) {
            print("Created the view");

            controller.initZoom(widget.zoomOptions).then((results) {
              print("initialised");
              print(results);

              if (results[0] == 0) {
                // Listening on the Zoom status stream (1)
                controller.zoomStatusEvents.listen((status) {
                  print("Meeting Status Stream: " +
                      status[0] +
                      " - " +
                      status[1]);

                  if (_isMeetingEnded(status[0])) {
                    Navigator.pop(context);
                    timer?.cancel();
                  }
                });

                print("listen on event channel");

                controller
                    .joinMeeting(widget.meetingOptions)
                    .then((joinMeetingResult) {
                  // Polling the Zoom status (2)
                  timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                    controller
                        .meetingStatus(widget.meetingOptions.meetingId)
                        .then((status) {
                      print("Meeting Status Polling: " +
                          status[0] +
                          " - " +
                          status[1]);
                    });
                  });
                });
              }
            }).catchError((error) {
              print(error);
            });
          })),
    );
  }

  Widget getNoImageAvatar(BuildContext context) {
    return new Container(
      child: Center(
        child: CustomCircleAvatar(
            child: GestureDetector(
              onTap: () {
                getImage(context);
              },
              child: "" == ""
                  ? SvgPicture.asset(
                      R.image.profile_avatar,
                      fit: BoxFit.fill,
                    )
                  : PhotoView(
                      imageProvider: FileImage(File("")),
                    ),
            ),
            size: 120),
      ),
    );
  }

  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = "How to get the photo?";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text("Pick a photo option"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "Camera",
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      print("getPhotoFromSource(context, ImageSource.camera);");
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "Photos",
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      print(
                          "getPhotoFromSource(context, ImageSource.gallery);");
                    },
                  ),
                ],
              )
            : GuvenAlert(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
                content: Text("message"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Camera"),
                    onPressed: () {
                      print("getPhotoFromSource(context, ImageSource.camera);");
                    },
                  ),
                  FlatButton(
                    child: Text("Gallery"),
                    onPressed: () {
                      print(
                          "getPhotoFromSource(context, ImageSource.gallery);");
                    },
                  )
                ],
              );
      },
    );
  }
}
