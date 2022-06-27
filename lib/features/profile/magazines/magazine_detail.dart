import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/core.dart';

class MagazinesWebView extends StatefulWidget {
  const MagazinesWebView({Key? key}) : super(key: key);

  @override
  _MagazinesWebViewState createState() => _MagazinesWebViewState();
}

class _MagazinesWebViewState extends State<MagazinesWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? myWebController;
  String? magazineUrl;

  @override
  void initState() {
    //if (Atom.isWeb) WebView.platform = WebWebViewPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      magazineUrl = Atom.queryParameters['magazineUrl'];
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return Scaffold(
      appBar: RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.current.magazines,
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: magazineUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            myWebController = webViewController;
          },
          onProgress: (int progress) {
            LoggerUtils.instance
                .i('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            LoggerUtils.instance.i('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            LoggerUtils.instance.i('Page finished loading: $url');
          },
          // ignore: prefer_collection_literals
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              LoggerUtils.instance.i('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            LoggerUtils.instance.i('allowing navigation to $request');
            return NavigationDecision.navigate;
          },

          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
