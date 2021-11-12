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

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    try {
      widget.title = Uri.decodeFull(Atom.queryParameters['title']);
      widget.url = Uri.decodeFull(Atom.queryParameters['url']);
    } catch (_) {
      return RbioRouteError();
    }

    return Scaffold(
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      appBar: MainAppBar(
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
        context: context,
        title: getTitleBar(context),
        leading: ButtonBackWhite(context),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // TODO(iskakaushik): Remove this when collection literals makes it to stable.
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
      }),
    );
  }

  void shareFile(BuildContext context, String url) async {
    await FlutterShare.share(title: widget.title, linkUrl: url);
  }
}
