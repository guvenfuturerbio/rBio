import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart' as masked;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class YoutubeViewerWebScreen extends StatefulWidget {
  String url;
  String courseId;
  String courseName;
  bool didCompleteSurvey;

  YoutubeViewerWebScreen({
    this.url,
    this.courseName = "",
    this.courseId = "",
    this.didCompleteSurvey = true,
  });

  @override
  _YoutubeViewerWebScreenState createState() => _YoutubeViewerWebScreenState();
}

class _YoutubeViewerWebScreenState extends State<YoutubeViewerWebScreen> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController surnameController = new TextEditingController();
  static const String MASK_TEXT = '(000) 000 00 00';
  var phoneNumbercontroller = new masked.MaskedTextController(mask: MASK_TEXT);

  final nameFNode = FocusNode();
  final surnameFNode = FocusNode();
  final phoneNumberFNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      params: const YoutubePlayerParams(
        startAt: const Duration(minutes: 0, seconds: 00),
        autoPlay: true,
        loop: true,
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    //_controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.of(context).youtube_stream,
        ),
      ),
      body: ListView(
        children: [
          //
          YoutubePlayerIFrame(
            controller: _controller,
          ),

          //
          widget.didCompleteSurvey ? getBody(context) : getSurvey(context),

          //
          SizedBox(height: 16),

          //
          Center(
            child: Text(
              LocaleProvider.of(context).powered_by,
              style: TextStyle(
                color: getIt<ITheme>().mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),

          //
          SizedBox(height: 16),

          //
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 16,
              ),
              child: SvgPicture.asset(
                R.image.guven_future_logo,
                height: 100,
                width: 100,
              ),
              margin: EdgeInsets.only(bottom: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSurvey(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //
          Container(
            child: Center(
              child: Text(
                widget.courseName ??
                    LocaleProvider.of(context).fill_all_field_to_win_lottery,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          //
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance.inputImageDecoration(
                hintText: LocaleProvider.of(context).name,
                image: R.image.ic_user,
              ),
              focusNode: nameFNode,
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                  context,
                  nameFNode,
                  surnameFNode,
                ),
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(
                  context,
                  nameFNode,
                  surnameFNode,
                );
              },
            ),
          ),

          //
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              focusNode: surnameFNode,
              controller: surnameController,
              textInputAction: TextInputAction.next,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance.inputImageDecoration(
                hintText: LocaleProvider.of(context).surname,
                image: R.image.ic_user,
              ),
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                  context,
                  surnameFNode,
                  phoneNumberFNode,
                ),
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(
                  context,
                  surnameFNode,
                  phoneNumberFNode,
                );
              },
            ),
          ),

          //
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              focusNode: phoneNumberFNode,
              controller: phoneNumbercontroller,
              textInputAction: TextInputAction.done,
              style: Utils.instance.inputTextStyle(),
              decoration: Utils.instance.inputImageDecoration(
                hintText: LocaleProvider.of(context).phone_number,
                image: R.image.ic_phone_call_grey,
              ),
              inputFormatters: <TextInputFormatter>[
                TabToNextFieldTextInputFormatter(
                  context,
                  phoneNumberFNode,
                  null,
                ),
              ],
              onFieldSubmitted: (term) {
                UtilityManager().fieldFocusChange(
                  context,
                  phoneNumberFNode,
                  null,
                );
              },
            ),
          ),

          //
          Center(
            child: Container(
              width: double.infinity,
              child: Utils.instance.button(
                text: LocaleProvider.of(context).btn_done.toUpperCase(),
                onPressed: () {
                  completeSurvey(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Center(
              child: Text(
                LocaleProvider.of(context).thank_you_for_survey,
                style: TextStyle(
                    fontSize: 24,
                    color: R.color.online_appointment,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> completeSurvey(BuildContext context) async {
    if (nameController.text == "" ||
        surnameController.text == "" ||
        phoneNumbercontroller.text.length != MASK_TEXT.length) {
      UtilityManager().showGradientDialog(
          context,
          LocaleProvider.of(context).warning,
          LocaleProvider.of(context).fill_all_field);
      return;
    }

    AnalyticsManager().sendEvent(
      YoutubeSurveyCompleteEvent(
        name: nameController.text,
        surname: surnameController.text,
        phone: phoneNumbercontroller.text,
        courseId: widget.courseId,
      ),
    );

    getIt<Repository>().setYoutubeSurveyUser(
      YoutubeSurveyUserRequest(
        name: nameController.text,
        surname: surnameController.text,
        phone: phoneNumbercontroller.text,
        id: widget.courseId,
      ),
    );

    await getIt<ISharedPreferencesManager>()
        .setBool(SharedPreferencesKeys.DID_COMPLETE_SURVEY, true);

    setState(() {
      widget.didCompleteSurvey = true;
    });
  }
}
