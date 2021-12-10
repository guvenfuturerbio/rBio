import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/core.dart';
import '../../../chronic_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../chronic_tracking/utils/gallery_pop_up/gallery_pop_up.dart';
import '../../utils/widgets.dart';
import 'chat_controller.dart';
import 'message.dart';

class DoctorChatWindow extends StatelessWidget {
  final String uuid;
  final String patientName;
  DoctorChatWindow(this.uuid, this.patientName);
  static Widget widgetFullPhoto(BuildContext context, String url) {
    return Container(child: PhotoView(imageProvider: NetworkImage(url)));
  }

  Widget build(BuildContext context) {
    final chatController = Provider.of<DoctorChatController>(context);
    chatController.username = 'Example UserName'; // usernotifier.userId;
    final _textController = TextEditingController();
    final _scrollController = ScrollController();

    void _sendMessage() async {
      if (_textController.text.trim().length > 0) {
        Message _messageSent = Message(
            sentFrom: chatController.username,
            sentTo: uuid,
            message: _textController.text,
            type: 0);
        _textController.clear();

        var result = await chatController.sendMessage(_messageSent);
        if (result) {
          _scrollController.animateTo(0.0,
              curve: Curves.easeOut, duration: Duration(microseconds: 10));
        }
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: titleAppBarWhite(title: patientName),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Message>>(
            stream: chatController.getMessages(chatController.username, uuid),
            builder: (context, streamMessages) {
              if (!streamMessages.hasData) {
                return RbioLoading();
              } else {
                return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemBuilder: (context, index) {
                      var time = DateTime.now();
                      try {
                        time = streamMessages.data[index].date.toDate() ??
                            DateTime.now();
                      } catch (e) {
                        print("hata var" + e.toString());
                      }
                      if (streamMessages.data.last ==
                          streamMessages.data[index])
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: R.color.dark_black,
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.centerRight),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(50),
                                          blurRadius: 15,
                                          spreadRadius: 0,
                                          offset: Offset(5, 10))
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(time)}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            streamMessages.data[index].type == 0
                                ? _chatIconDesign(streamMessages.data[index],
                                    chatController.username.toString())
                                : chatImage(context, streamMessages.data[index],
                                    chatController.username)
                          ],
                        );
                      if (time.isSameDay(
                              streamMessages.data[index + 1].date.toDate()) ==
                          false)
                        return Column(
                          children: [
                            Container(
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: R.color.dark_blue,
                                    gradient: LinearGradient(
                                        colors: [Colors.white, Colors.white],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.centerRight),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(50),
                                          blurRadius: 15,
                                          spreadRadius: 0,
                                          offset: Offset(5, 10))
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SelectableText(
                                      '${DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(time)}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            streamMessages.data[index].type == 0
                                ? _chatIconDesign(streamMessages.data[index],
                                    chatController.username)
                                : chatImage(context, streamMessages.data[index],
                                    chatController.username)
                          ],
                        );
                      else
                        return streamMessages.data[index].type == 0
                            ? _chatIconDesign(streamMessages.data[index],
                                chatController.username)
                            : chatImage(context, streamMessages.data[index],
                                chatController.username);
                    },
                    itemCount: streamMessages.data.length);
              }
            },
          )),
          IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add_a_photo, color: R.color.main_color),
                      onPressed: () {
                        chatController.getImage(
                            0, chatController.username, uuid);
                      },
                    ),
                    SizedBox(width: 10),
                    Flexible(
                        child: TextField(
                            controller: _textController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              _sendMessage();
                            },
                            decoration: InputDecoration.collapsed(
                                hintText: "Mesaj gönder"))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                            color: R.color.main_color,
                            icon: Icon(Icons.send),
                            onPressed: _sendMessage))
                  ]),
                  decoration: Theme.of(context).platform == TargetPlatform.iOS
                      ? BoxDecoration(
                          border:
                              Border(top: BorderSide(color: Colors.grey[200])))
                      : null))
        ],
      ),
    );
  }
}

Widget widgetShowImages(String imageUrl, double imageSize) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: imageSize,
    width: imageSize,
    placeholder: (context, url) => Shimmer.fromColors(
        child: SizedBox(
          height: imageSize,
          width: imageSize,
        ),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100]),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

Widget chatImage(BuildContext context, Message message, String uid) {
  var time = "";
  try {
    time = _showTime(message.date ?? Timestamp(1, 1));
  } catch (e) {
    print("hata var" + e.toString());
  }
  if (message.sentFrom == uid) {
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 8, 8, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            child: FlatButton(
              child: widgetShowImages(message.message, 150 * context.TEXTSCALE),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Dismissible(
                        key: Key('${message.date.millisecondsSinceEpoch}'),
                        child: GalleryView(
                          images: [message.message],
                        ),
                        direction: DismissDirection.vertical,
                        movementDuration: Duration(milliseconds: 100),
                        onDismissed: (direction) {
                          Navigator.pop(context, 'dialog');
                        },
                      );
                    });
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ZoomImage(url: message.message))); */
              },
              padding: EdgeInsets.all(0),
            ),
          ),
          Text(time),
        ]));
  } else {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/max/625/1*vwkVPiu3M2b5Ton6YVywlg.png")),
            Container(
                child: FlatButton(
              child: Material(
                child:
                    widgetShowImages(message.message, 150 * context.TEXTSCALE),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                clipBehavior: Clip.hardEdge,
              ),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Dismissible(
                        key: Key('${message.date.millisecondsSinceEpoch}'),
                        child: Material(
                          child: Stack(
                            children: [
                              widgetShowImages(message.message, context.HEIGHT),
                              Container(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'dialog');
                                    },
                                    icon: Icon(Icons.close)),
                              )
                            ],
                          ),
                        ),
                        direction: DismissDirection.vertical,
                        movementDuration: Duration(milliseconds: 100),
                        onDismissed: (direction) {
                          Navigator.pop(context, 'dialog');
                        },
                      );
                    });
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ZoomImage(url: message.message))); */
              },
              padding: EdgeInsets.all(0),
            )),
            Text(time),
          ],
        ));
  }
}

Widget _chatIconDesign(Message message, uid) {
  Color recievedMessageColor = Colors.grey[350];
  Color sentMessageColor = R.color.dark_blue;
  var time = "";
  try {
    time = _showTime(message.date ?? Timestamp(1, 1));
  } catch (e) {
    print("hata var" + e.toString());
  }
  if (message.sentFrom == uid) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: sentMessageColor,
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(4),
              child: SelectableText(message.message,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          SelectableText(time),
        ],
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 50, 8),
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://miro.medium.com/max/625/1*vwkVPiu3M2b5Ton6YVywlg.png")),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: recievedMessageColor,
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(4),
              child: SelectableText(message.message,
                  style: TextStyle(color: Colors.black)),
            ),
          ),
          SelectableText(time),
        ],
      ),
    );
  }
}

String _showTime(Timestamp date) {
  var _formatter = DateFormat.Hm();
  var _formattedTime = _formatter.format(date.toDate());
  return _formattedTime;
}
