import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';
import '../../chronic_tracking/utils/gallery_pop_up/gallery_pop_up.dart';
import '../controller/chat_controller.dart';
import '../model/chat_person.dart';
import '../model/message.dart';

class ChatWindow extends StatefulWidget {
  const ChatWindow({Key key}) : super(key: key);

  @override
  _ChatWindowState createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  ChatPerson otherPerson;

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool hasFirstDataArrived = false;

  void _sendMessage(String sender, ChatController chatController) async {
    try {
      if (_textController.text.trim().length > 0) {
        final _messageSent = Message(
          sentFrom: sender,
          message: _textController.text,
          date: DateTime.now().millisecondsSinceEpoch,
          type: 0,
        );
        _textController.clear();

        var result = await chatController.sendMessage(
          _messageSent,
          otherPerson.id,
        );
        if (result) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: Duration(microseconds: 10),
          );
        }
      }
    } catch (e) {
      LoggerUtils.instance.e(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      otherPerson = ChatPerson.fromJson(Atom.queryParameters['otherPerson']);
    } catch (e) {
      return RbioRouteError();
    }

    final sender = getIt<UserNotifier>().firebaseID;
    final chatController = Provider.of<ChatController>(context)
      ..init(sender, otherPerson.id);

    return KeyboardDismissOnTap(
      child: RbioStackedScaffold(
        appbar: RbioAppBar(
          title: TitleAppBarWhite(
            title: otherPerson.name,
          ),
        ),
        body: _buildBody(
          chatController,
          sender,
          _scrollController,
          context,
          _textController,
          _sendMessage,
        ),
      ),
    );
  }

  Widget _buildBody(
    ChatController chatController,
    String sender,
    ScrollController _scrollController,
    BuildContext context,
    TextEditingController _textController,
    void Function(String sender, ChatController chatController) _sendMessage,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: chatController.stream,
            builder: (context, streamMessages) {
              if (!streamMessages.hasData) {
                return RbioLoading();
              } else {
                if (!hasFirstDataArrived &&
                    streamMessages.data.data() != null) {
                  hasFirstDataArrived = true;
                  Future.delayed(
                    Duration(milliseconds: 250),
                    () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: Duration(microseconds: 10),
                      );
                    },
                  );
                }

                return _buildSuccess(context, _scrollController, streamMessages,
                    sender, chatController);
              }
            },
          ),
        ),

        //
        _buildInputArea(
          context,
          chatController,
          sender,
          _textController,
          _sendMessage,
        ),

        //
        KeyboardVisibilityBuilder(
          builder: (p0, isKeyboardVisible) {
            return SizedBox(
              height: isKeyboardVisible ? 0 : Atom.safeBottom + 12,
            );
          },
        ),
      ],
    );
  }

  IconTheme _buildInputArea(
    BuildContext context,
    ChatController chatController,
    String sender,
    TextEditingController _textController,
    void Function(String sender, ChatController chatController) _sendMessage,
  ) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: getIt<ITheme>().mainColor,
              ),
              onPressed: () {
                chatController.getImage(0, sender, otherPerson.id);
              },
            ),

            //
            SizedBox(width: 10),

            //
            Flexible(
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onSubmitted: (value) {
                  _sendMessage(sender, chatController);
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Mesaj gönder",
                ),
              ),
            ),

            //
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                color: getIt<ITheme>().mainColor,
                icon: Icon(Icons.send),
                onPressed: () => _sendMessage(sender, chatController),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(
      BuildContext context,
      ScrollController _scrollController,
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> streamMessages,
      String sender,
      ChatController chatController) {
    if (streamMessages.data.data() == null) return SizedBox();
    final messages = streamMessages.data.data()['messages'];
    if (messages == null) return SizedBox();
    final messageData = messages.map((item) => Message.fromMap(item)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: ListView.builder(
            reverse: false,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: messageData.length,
            padding: EdgeInsets.only(top: 64 + Atom.safeTop),
            itemBuilder: (context, index) {
              var time = DateTime.now();
              try {
                time = DateTime.fromMillisecondsSinceEpoch(
                    messageData[index].date,
                    isUtc: true);
              } catch (e) {
                LoggerUtils.instance.e(e);
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
                            otherPerson.url, chatController)
                        : chatImage(context, messageData[index], sender,
                            otherPerson.url, chatController)
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
                            otherPerson.url, chatController)
                        : chatImage(context, messageData[index], sender,
                            otherPerson.url, chatController)
                  ],
                );
              else
                return messageData[index].type == 0
                    ? _chatIconDesign(messageData[index], sender,
                        otherPerson.url, chatController)
                    : chatImage(context, messageData[index], sender,
                        otherPerson.url, chatController);
            },
          ),
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

Widget chatImage(BuildContext context, Message message, String uid, String url,
    ChatController chatController) {
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
            Column(
              children: [
                Text(time),
                if (chatController.otherLastSeen > message.date) ...{
                  SvgPicture.asset(R.image.eyeseen_icon, height: 10)
                }
              ],
            ),
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

Widget _chatIconDesign(
    Message message, uid, String url, ChatController chatController) {
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
          Column(
            children: [
              Text(time),
              if (chatController.otherLastSeen > message.date) ...{
                SvgPicture.asset(R.image.eyeseen_icon, height: 10)
              }
            ],
          ),
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
