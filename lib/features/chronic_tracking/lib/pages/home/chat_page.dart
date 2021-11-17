import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../widgets/utils.dart';

class ChatPage extends StatefulWidget {
  String url, title;
  ChatPage(
      {this.url =
          "https://widget.tiledesk.com/v4/assets/twp/index.html?isOpen=true&tiledesk_projectid=5ff39a28f5195b0019b4dacd&tiledesk_fullscreenMode=true&tiledesk_hideHeaderCloseButton=true&tiledesk_isopen=true",
      this.title});
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<ChatPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
        title: TitleAppBarWhite(title: LocaleProvider.current.chat),
        leading: InkWell(
            child: SvgPicture.asset(R.image.back_icon),
            onTap: () => Navigator.of(context).pop()),
      ),
      body: Builder(builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              padding: EdgeInsets.only(top: 8, bottom: 32, right: 16, left: 16),
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              )),
        );
      }),
    );
  }
}
