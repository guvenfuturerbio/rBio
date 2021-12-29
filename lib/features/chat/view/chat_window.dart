import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:onedosehealth/features/chat/controller/chat_controller.dart';
import 'package:onedosehealth/features/chat/model/message.dart';
import 'package:onedosehealth/features/chronic_tracking/utils/gallery_pop_up/gallery_pop_up.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:dart_date/dart_date.dart';
import 'package:shimmer/shimmer.dart';
import '../model/chat_person.dart';

/// MG15 - this page includes all chat history (Past and Present)
class ChatWindow extends StatefulWidget {
  ChatWindow();
  ChatPerson otherPerson;

  static Widget widgetFullPhoto(BuildContext context, String url) {
    return Container(child: PhotoView(imageProvider: NetworkImage(url)));
  }

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  bool hasFirstDataArrived = false;
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);

    String sender = getIt<UserNotifier>().firebaseID;

    try {
      widget.otherPerson =
          ChatPerson.fromJson(Atom.queryParameters['otherPerson']);
    } catch (e) {
      return RbioRouteError();
    }

    void _sendMessage() async {
      try {
        if (_textController.text.trim().length > 0) {
          Message _messageSent = Message(
              sentFrom: sender,
              message: _textController.text,
              date: DateTime.now().millisecondsSinceEpoch,
              type: 0);
          _textController.clear();

          var result = await chatController.sendMessage(
              _messageSent, widget.otherPerson.id);
          if (result) {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: Duration(microseconds: 10));
          }
        }
      } catch (e) {
        print(e);
        rethrow;
      }
    }

    return RbioStackedScaffold(
      appbar: RbioAppBar(
        title: TitleAppBarWhite(title: widget.otherPerson.name),
      ),
      body: _buildBody(chatController, sender, _scrollController, context,
          _textController, _sendMessage),
    );
  }

  Widget _buildBody(
      ChatController chatController,
      String sender,
      ScrollController _scrollController,
      BuildContext context,
      TextEditingController _textController,
      void _sendMessage()) {
    return GestureDetector(
      onTap: () {
        Utils.instance.hideKeyboard(context);
      },
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: chatController.getMessages(sender, widget.otherPerson.id),
            builder: (context, streamMessages) {
              if (!streamMessages.hasData) {
                return RbioLoading();
              } else {
                if (!hasFirstDataArrived) {
                  hasFirstDataArrived = true;
                  Future.delayed(Duration(milliseconds: 250), () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: Duration(microseconds: 10));
                  });
                }
                return _buildSuccess(
                    context, _scrollController, streamMessages, sender);
              }
            },
          )),
          _buildInputArea(
              context, chatController, sender, _textController, _sendMessage)
        ],
      ),
    );
  }

  IconTheme _buildInputArea(
      BuildContext context,
      ChatController chatController,
      String sender,
      TextEditingController _textController,
      void _sendMessage()) {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_a_photo, color: getIt<ITheme>().mainColor),
                onPressed: () {
                  chatController.getImage(0, sender, widget.otherPerson.id);
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
                      decoration:
                          InputDecoration.collapsed(hintText: "Mesaj gönder"))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                      color: getIt<ITheme>().mainColor,
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage))
            ]),
            decoration: Theme.of(context).platform == TargetPlatform.iOS
                ? BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[200])))
                : null));
  }

  Widget _buildSuccess(
      BuildContext context,
      ScrollController _scrollController,
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> streamMessages,
      String sender) {
    if (streamMessages.data.data() == null) return SizedBox();
    final messageData = (streamMessages.data.data()['messages'] as List)
        .map((item) => Message.fromMap(item))
        .toList();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 64 + Atom.safeTop),
              controller: _scrollController,
              reverse: false,
              itemBuilder: (context, index) {
                var time = DateTime.now();
                try {
                  time = DateTime.fromMillisecondsSinceEpoch(
                      messageData[index].date,
                      isUtc: true);
                } catch (e) {
                  print("hata var" + e.toString());
                }
                if (messageData.first == messageData[index])
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: getIt<ITheme>().mainColor,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
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
                      messageData[index].type == 0
                          ? _chatIconDesign(messageData[index], sender,
                              widget.otherPerson.url)
                          : chatImage(context, messageData[index], sender,
                              widget.otherPerson.url)
                    ],
                  );
                if (time.isSameDay(DateTime.fromMillisecondsSinceEpoch(
                        messageData[index - 1].date)) ==
                    false)
                  return Column(
                    children: [
                      Container(
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: R.color.main_color,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
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
                      messageData[index].type == 0
                          ? _chatIconDesign(messageData[index], sender,
                              widget.otherPerson.url)
                          : chatImage(context, messageData[index], sender,
                              widget.otherPerson.url)
                    ],
                  );
                else
                  return messageData[index].type == 0
                      ? _chatIconDesign(
                          messageData[index], sender, widget.otherPerson.url)
                      : chatImage(context, messageData[index], sender,
                          widget.otherPerson.url);
              },
              itemCount: messageData.length),
        ),
      ],
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

Widget chatImage(
    BuildContext context, Message message, String uid, String url) {
  var time = "";
  try {
    time = _showTime(DateTime.fromMillisecondsSinceEpoch(message.date));
  } catch (e) {
    print("hata var" + e.toString());
  }
  if (message.sentFrom == uid) {
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 8, 8, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                    context: context,
                    builder: (_) => GalleryView(
                          images: [message.message],
                        ));
              },
              padding: EdgeInsets.all(0),
            )),
            Text(time),
          ])
        ]));
  } else {
    return Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(backgroundImage: NetworkImage(url)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  child: FlatButton(
                child: Material(
                  child: widgetShowImages(
                      message.message, 150 * context.TEXTSCALE),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                onPressed: () {
                  print(message.message);
                  showDialog(
                      context: context,
                      builder: (_) => GalleryView(
                            images: [message.message],
                          ));
                },
                padding: EdgeInsets.all(0),
              )),
            ),
            Text(time),
          ])
        ]));
  }
}

Widget _chatIconDesign(Message message, uid, String url) {
  Color recievedMessageColor = Colors.grey[350];
  Color sentMessageColor = getIt<ITheme>().mainColor;
  var time = "";
  try {
    time = _showTime(DateTime.fromMillisecondsSinceEpoch(message.date));
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
          Text(time),
        ],
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 50, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(url)),
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
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}

String _showTime(DateTime date) {
  var _formatter = DateFormat.Hm();
  var _formattedTime = _formatter.format(date);
  return _formattedTime;
}
