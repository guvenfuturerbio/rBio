import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/core.dart';
import '../../../core/core.dart';
import '../controller/chat_vm.dart';
import '../model/chat_person.dart';
import '../model/message.dart';

part '../widget/image_preview_dialog.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatPerson otherPerson;
  late StreamSubscription<bool> keyboardSubscription;

  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  late ValueNotifier<bool> firstLoadNotifier;

  String getCurrentUserId = getIt<UserNotifier>().firebaseID!;
  ChatPerson get getCurrentPerson => ChatPerson(
        id: getIt<UserNotifier>().firebaseID,
        name: getIt<UserFacade>().getNameAndSurname(),
        url: R.image.avatarUrl,
        firebaseToken: getIt<FirebaseMessagingManager>().getToken,
      );
  final topPadding = 64 + Atom.safeTop;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    firstLoadNotifier = ValueNotifier(false);

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible) {
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            _scrollAnimateToEnd();
          },
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
    firstLoadNotifier.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      otherPerson = ChatPerson.fromJson(Atom.queryParameters['otherPerson']!);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    final chatVm = Provider.of<ChatVm>(context)
      ..init(getCurrentUserId, otherPerson.id!, _scrollAnimateToEnd,
          firstLoadNotifier);

    return KeyboardDismissOnTap(
      child: RbioStackedScaffold(
        appbar: _buildAppBar(context),
        body: _buildBody(chatVm),
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(context, otherPerson.name ?? ''),
    );
  }

  Widget _buildBody(ChatVm chatVm) {
    return RbioKeyboardActions(
      focusList: [
        _focusNode,
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                //
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: chatVm.stream,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const RbioLoading();
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const RbioBodyError();
                      } else if (snapshot.hasData) {
                        return _buildSuccess(snapshot.data!, chatVm);
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),

                //
                ValueListenableBuilder(
                  valueListenable: firstLoadNotifier,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return !value
                        ? Positioned.fill(
                            child: Container(
                              color: context.scaffoldBackgroundColor,
                              child: const RbioLoading(),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),

          //
          _buildInputArea(chatVm),

          //
          KeyboardVisibilityBuilder(
            builder: (BuildContext context, bool isKeyboardVisible) {
              return SizedBox(
                height: isKeyboardVisible ? 12 : Atom.safeBottom + 12,
              );
            },
          ),
        ],
      ),
    );
  }

  void _scrollAnimateToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent + topPadding + 300);
        },
      );
    });
  }

  Widget _buildInputArea(ChatVm chatVm) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                R.image.photo,
                color: context.xPrimaryColor,
                width: 25,
              ),
              onPressed: () async {
                if (!await getIt<PermissionManager>().request(
                  permission: CameraPermissionStrategy(
                    LocaleProvider.of(context),
                    getIt<IAppConfig>(),
                  ),
                  context: context,
                )) {
                  return;
                }

                chatVm.getImage(
                  1,
                  getCurrentUserId,
                  otherPerson.id!,
                  getCurrentPerson,
                  otherPerson.firebaseToken!,
                );
              },
            ),

            IconButton(
              icon: Icon(
                Icons.image_outlined,
                color: context.xPrimaryColor,
              ),
              onPressed: () async {
                if (!await getIt<PermissionManager>().request(
                  permission: GalleryPermissionStrategy(
                    LocaleProvider.of(context),
                    getIt<IAppConfig>(),
                  ),
                  context: context,
                )) {
                  return;
                }

                chatVm.getImage(
                  0,
                  getCurrentUserId,
                  otherPerson.id!,
                  getCurrentPerson,
                  otherPerson.firebaseToken!,
                );
              },
            ),
            //

            //
            Expanded(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  //
                  RbioTextFormField(
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    contentPadding: const EdgeInsets.only(
                        left: 20, right: 40, top: 10, bottom: 10),
                    hintText: LocaleProvider.current.send_message,
                    onFieldSubmitted: (value) {
                      _sendMessage(chatVm);
                    },
                  ),

                  //
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: context.xPrimaryColor,
                      icon: SvgPicture.asset(R.image.send, width: 25),
                      onPressed: () {
                        _sendMessage(chatVm);
                      },
                    ),
                  ),
                ],
              ),
            ),

            //
            R.widgets.wSizer8,
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
    ChatVm chatVm,
  ) {
    final documentData = documentSnapshot.data();
    if (documentData == null) return const SizedBox();
    final messages = documentData['messages'] as List?;
    if (messages == null) {
      return const SizedBox();
    }
    final messageData =
        messages.map((item) => Message.fromMap(item)).cast<Message>().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        //
        Expanded(
          child: Scrollbar(
            thickness: 3,
            thumbVisibility: true,
            radius: const Radius.circular(5),
            controller: _scrollController,
            child: ListView.builder(
              reverse: false,
              shrinkWrap: true,
              controller: _scrollController,
              padding: EdgeInsets.only(top: topPadding),
              physics: const ClampingScrollPhysics(),
              itemCount: messageData.length,
              itemBuilder: (BuildContext context, int index) {
                var time = DateTime.now();

                try {
                  time = DateTime.fromMillisecondsSinceEpoch(
                    messageData[index].date!,
                    isUtc: true,
                  );
                } catch (e, stackTrace) {
                  getIt<IAppConfig>()
                      .platform
                      .sentryManager
                      .captureException(e, stackTrace: stackTrace);
                  LoggerUtils.instance.e(e);
                }

                if (messageData.first == messageData[index]) {
                  return _buildFirstCard(
                    time,
                    messageData[index],
                    chatVm,
                  );
                }

                //
                if (time.isSameDay(DateTime.fromMillisecondsSinceEpoch(
                        messageData[index - 1].date!)) ==
                    false) {
                  return Column(
                    children: [
                      _buildDateTitle(time),
                      _buildChatBubble(messageData[index], chatVm),
                    ],
                  );
                } else {
                  return _buildChatBubble(messageData[index], chatVm);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _buildFirstCard(
    DateTime time,
    Message message,
    ChatVm chatVm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        _buildDateTitle(time),

        //
        _buildChatBubble(message, chatVm),
      ],
    );
  }

  Widget _buildChatBubble(
    Message message,
    ChatVm chatVm,
  ) =>
      message.type == 0
          ? _buildTextBubble(
              message,
              otherPerson.url!,
              chatVm,
            )
          : _buildImageBubble(
              context,
              message,
              otherPerson.url!,
              chatVm,
            );

  Widget _buildDateTitle(DateTime time) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: context.xCardColor,
          borderRadius: R.sizes.borderRadiusCircular,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat.yMMMMEEEEd(Intl.getCurrentLocale()).format(time),
            textAlign: TextAlign.center,
            style: context.xHeadline5,
          ),
        ),
      ),
    );
  }

  Widget _buildImageBubble(
    BuildContext context,
    Message message,
    String url,
    ChatVm chatVm,
  ) {
    var time = "";
    try {
      time = _showTime(DateTime.fromMillisecondsSinceEpoch(message.date!));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }

    if (message.sentFrom == getCurrentUserId) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            RbioTextButton(
              padding: const EdgeInsets.all(0),
              child: Material(
                child: widgetShowImages(message.message!),
                borderRadius: R.sizes.borderRadiusCircular,
                clipBehavior: Clip.hardEdge,
              ),
              onPressed: () {
                Atom.show(
                  RbioImagePreviewDialog(
                    image: message.message,
                  ),
                );
              },
            ),

            //
            R.widgets.wSizer8,

            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildTimeText(time),
                if (chatVm.otherLastSeen > message.date!) ...{
                  _buildEyesIcon(),
                },
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            RbioTextButton(
              padding: const EdgeInsets.all(0),
              child: Material(
                child: widgetShowImages(message.message!),
                borderRadius: R.sizes.borderRadiusCircular,
                clipBehavior: Clip.hardEdge,
              ),
              onPressed: () {
                Atom.show(
                  RbioImagePreviewDialog(
                    image: message.message,
                  ),
                );
              },
            ),

            //
            _buildTimeText(time, true),
          ],
        ),
      );
    }
  }

  Widget _buildTextBubble(
    Message message,
    String url,
    ChatVm chatVm,
  ) {
    var time = "";
    try {
      time = _showTime(DateTime.fromMillisecondsSinceEpoch(message.date!));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }

    if (message.sentFrom == getCurrentUserId) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Flexible(
              child: _buildSelectableText(
                message.message!,
                getIt<IAppConfig>().theme.textColorSecondary,
                getIt<IAppConfig>().theme.secondaryColor,
              ),
            ),

            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildTimeText(time),
                if (chatVm.otherLastSeen > message.date!) ...{
                  _buildEyesIcon(),
                },
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            Flexible(
              child: _buildSelectableText(
                message.message!,
                getIt<IAppConfig>().theme.textColorSecondary,
                context.xCardColor,
              ),
            ),

            //
            _buildTimeText(time, true),
          ],
        ),
      );
    }
  }

  Widget _buildSelectableText(
    String message,
    Color textColor,
    Color backColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: SelectableText(
        message,
        style: context.xHeadline5.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
        enableInteractiveSelection: true,
        autofocus: true,
      ),
    );
  }

  Widget _buildTimeText(String time, [bool bottomPadding = false]) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4,
        bottom: bottomPadding ? 7 : 0,
      ),
      child: Text(
        time,
        style: context.xHeadline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEyesIcon() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 7,
      ),
      child: SvgPicture.asset(
        R.image.eyeSeen,
        height: 12,
      ),
    );
  }

  void _sendMessage(ChatVm chatVm) async {
    try {
      if (_textEditingController.text.trim().isNotEmpty) {
        final _messageSent = Message(
          sentFrom: getCurrentUserId,
          message: _textEditingController.text,
          date: DateTime.now().millisecondsSinceEpoch,
          type: 0,
        );

        var result = await chatVm.sendMessage(_messageSent, otherPerson.id!,
            getCurrentPerson, otherPerson.firebaseToken!);
        if (result) {
          _focusNode.unfocus();
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(microseconds: 10),
          );
          Future.delayed(const Duration(milliseconds: 10), () {
            _textEditingController.clear();
          });
        }
      }
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
      rethrow;
    }
  }

  Widget widgetShowImages(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: Atom.width * 0.25,
      placeholder: (context, url) => Shimmer.fromColors(
        child: SizedBox(
          height: Atom.width * 0.25,
          width: Atom.width * 0.25,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  String _showTime(DateTime date) {
    var _formatter = DateFormat.Hm();
    var _formattedTime = _formatter.format(date);
    return _formattedTime;
  }
}
