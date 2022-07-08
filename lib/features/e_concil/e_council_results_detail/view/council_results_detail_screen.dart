import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ECouncilResultsDetailScreen extends StatelessWidget {
  const ECouncilResultsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(title: Text(LocaleProvider.of(context).council_report)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 19),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: getIt<IAppConfig>().theme.mainColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleProvider.of(context).council_report,
                    style: context.xHeadline2.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: kIsWeb
                    ? HtmlElementView(
                        viewType: 'councilResultDetail',
                      )
                    : WebView(
                        initialUrl: 'https://flutter.dev',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
