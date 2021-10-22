import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_plugin/zoom_options.dart';
import 'package:flutter_zoom_plugin/zoom_view.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class StartZoomMeetingScreen extends StatefulWidget {
  String email;
  String jwtToken;

  StartZoomMeetingScreen({
    Key key,
    this.email,
    this.jwtToken,
  }) : super(key: key) {}

  @override
  _StartZoomMeetingScreenState createState() => _StartZoomMeetingScreenState();
}

class _StartZoomMeetingScreenState extends State<StartZoomMeetingScreen> {
  ZoomOptions zoomOptions;
  ZoomMeetingOptions meetingOptions;

  Timer timer;
  bool isMeetingCreated = false;

  @override
  void initState() {
    super.initState();
    setZoomOptions();
  }

  void setZoomOptions() async {
    String email = widget.email;
    String jwtToken = widget.jwtToken;
    final userTokenResponse = await http.get(
      Uri.parse(
          'https://api.zoom.us/v2/users/$email/token?type=token&access_token=$jwtToken'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $jwtToken"},
    );
    var userResponseBody = jsonDecode(utf8.decode(userTokenResponse.bodyBytes));
    String userToken = userResponseBody["token"];

    final accessTokenResponse = await http.get(
      Uri.parse(
          'https://api.zoom.us/v2/users/$email/token?type=zak&access_token=$jwtToken'),
      headers: {HttpHeaders.authorizationHeader: "Bearer $jwtToken"},
    );
    var accessResponseBody =
        jsonDecode(utf8.decode(accessTokenResponse.bodyBytes));
    String accessToken = accessResponseBody["token"];

    String yearPart = DateFormat('yyyy-dd-MM').format(DateTime.now());
    String hourPart = DateFormat('HH:mm:ss').format(DateTime.now());
    final createMeeting = await http.post(
      Uri.parse('https://api.zoom.us/v2/users/$email/meetings'),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwtToken",
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: jsonEncode(<String, String>{
        "topic": "topic",
        "type": "2",
        "start_time": (yearPart + "T" + hourPart),
        "duration": "30"
      }),
    );
    var createMeetingResponseBody =
        jsonDecode(utf8.decode(createMeeting.bodyBytes));
    ZoomCreateMeetingResponse zoomCreateMeetingResponse =
        ZoomCreateMeetingResponse.fromJson(createMeetingResponseBody);
    print(zoomCreateMeetingResponse.startUrl);
    print("CAGDAS joinUrl");
    print(zoomCreateMeetingResponse.joinUrl);

    this.zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      appKey: R.strings.zoom_app_key,
      appSecret: R.strings.zoom_app_secret,
    );

    this.meetingOptions = new ZoomMeetingOptions(
        userId: email, // Replace with the user email or Zoom user ID
        displayName: 'Meeting Starter',
        meetingId: zoomCreateMeetingResponse.id.toString(),
        zoomAccessToken:
            accessToken, // Replace with the token obtained from the Zoom API
        zoomToken:
            userToken, // Replace with the token obtained from the Zoom API
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false");

    setState(() {
      isMeetingCreated = true;
    });
  }

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
        title: LocaleProvider.of(context).start_zoom_meeting);
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: MainAppBar(
        context: context,
        title: getTitleBar(context),
        leading: ButtonBackWhite(context),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: isMeetingCreated
              ? ZoomView(onViewCreated: (controller) async {
                  print("Created the view");
                  controller.initZoom(this.zoomOptions).then((results) {
                    print("initialised");
                    print(results);

                    if (results[0] == 0) {
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
                          .startMeeting(this.meetingOptions)
                          .then((joinMeetingResult) {
                        timer =
                            Timer.periodic(new Duration(seconds: 2), (timer) {
                          controller
                              .meetingStatus(this.meetingOptions.meetingId)
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
                    print("Error");
                    print(error);
                  });
                })
              : Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(R.color.dark_blue),
                  ),
                )),
    );
  }
}
