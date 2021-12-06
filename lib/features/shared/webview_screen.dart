import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/core.dart';

class WebViewScreen extends StatefulWidget {
  String url;
  String title;

  WebViewScreen({
    Key key,
    this.url,
    this.title,
  }) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    try {
      widget.title = Uri.decodeFull(Atom.queryParameters['title']);
      widget.url = Uri.decodeFull(Atom.queryParameters['url']);
    } catch (_) {
      return RbioRouteError();
    }

    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          widget.title,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: GestureDetector(
              onTap: () => {shareFile(context, widget.url)},
              child: Platform.isIOS
                  ? SvgPicture.asset(R.image.ic_ios_share)
                  : SvgPicture.asset(R.image.ic_android_share),
            ),
          )
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            // ignore: prefer_collection_literals
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
          );
        },
      ),
    );
  }

  void shareFile(BuildContext context, String url) async {
    await FlutterShare.share(title: widget.title, linkUrl: url);
  }
}
