import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/core.dart';

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
          style: TextStyle(color: getIt<IAppConfig>().theme.white),
        ),
      ),
      body: SafeArea(
        child: kIsWeb
            ? const HtmlElementView(viewType: 'detailed_symptom')
            : WebView(
                initialUrl: "https://tsdc.onedosehealth.com/",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  myWebController = webViewController;
                },
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
