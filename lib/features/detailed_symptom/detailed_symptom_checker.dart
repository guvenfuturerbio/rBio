import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailedSymptomChecker extends StatefulWidget {
  const DetailedSymptomChecker({Key? key}) : super(key: key);

  @override
  _DetailedSymptomCheckerState createState() => _DetailedSymptomCheckerState();
}

class _DetailedSymptomCheckerState extends State<DetailedSymptomChecker> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? myWebController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RbioAppBar(
        title: Text(
          LocaleProvider.current.detailed_check,
          style: TextStyle(color: R.color.white),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: "https://tsdc.onedosehealth.com/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            myWebController = webViewController;
          },
          // ignore: prefer_collection_literals
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              LoggerUtils.instance.d('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            LoggerUtils.instance.d('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            LoggerUtils.instance.d('Page started loading: $url');
          },
          onPageFinished: (String url) {
            LoggerUtils.instance.d('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
