import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/core.dart';

class WebViewScreen extends StatefulWidget {
  String? url;
  String? title;

  WebViewScreen({Key? key}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    try {
      widget.title = Uri.decodeFull(Atom.queryParameters['title'] as String);
      widget.url = Uri.decodeFull(Atom.queryParameters['url'] as String);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          widget.title ?? "No title!",
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: GestureDetector(
              onTap: () => {shareFile(context, widget.url ?? '')},
              child: Platform.isIOS
                  ? SvgPicture.asset(R.image.iosShare)
                  : SvgPicture.asset(R.image.androidShare),
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
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                LoggerUtils.instance.i('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              LoggerUtils.instance.i('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              LoggerUtils.instance.i('Page started loading: $url');
            },
            onPageFinished: (String url) {
              LoggerUtils.instance.i('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          );
        },
      ),
    );
  }

  void shareFile(BuildContext context, String url) async {
    await FlutterShare.share(title: widget.title ?? "No title!", linkUrl: url);
  }
}
