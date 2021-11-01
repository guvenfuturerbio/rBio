import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';

class AdaSymptomAnalyzerScreen extends StatefulWidget {
  AdaSymptomAnalyzerScreen({Key key}) : super(key: key);

  @override
  _AdaSymptomAnalyzerScreenState createState() => _AdaSymptomAnalyzerScreenState();
}

class _AdaSymptomAnalyzerScreenState extends State<AdaSymptomAnalyzerScreen> {
  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.of(context).symptom_analyzer);
  }

  bool webViewCreated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
        title: getTitleBar(context),
        leading: ButtonBackWhite(context),
      ),
      body: webViewCreated
          ? WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:
                  'https://web-embed-preview.client-prod-eu.prod.ada.com/',
              onWebViewCreated: (WebViewController webViewController) {
                print("onWebViewCreated");
                setState(() {
                  webViewCreated = true;
                });
              },
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(R.color.dark_blue),
              ),
            ),
    );
  }
}
