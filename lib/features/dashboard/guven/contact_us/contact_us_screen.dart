import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/core.dart';
import '../../../shared/webview_screen.dart';

class ContactUsScreen extends StatefulWidget {
  String url;
  String title;

  ContactUsScreen({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: _buildBody(),
    );
  }

  Builder _buildBody() {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              left: Atom.size.width < 800
                  ? Atom.size.width * 0.03
                  : Atom.size.width * 0.10,
              right: Atom.size.width < 800
                  ? Atom.size.width * 0.03
                  : Atom.size.width * 0.10),
          child: ListView(
            children: <Widget>[
              //
              Container(
                height: 130,
                child: Column(
                  children: <Widget>[
                    (kIsWeb || Intl.getCurrentLocale() != 'tr')
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              launch("tel://4449494");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                gradient: LinearGradient(
                                    colors: [getIt<IAppConfig>().theme.red, getIt<IAppConfig>().theme.lightRed],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.centerRight),
                                border: Border.all(
                                  width: 1,
                                  color: getIt<IAppConfig>().theme.red,
                                ),
                              ),
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    R.image.icPhoneGreyCall,
                                    color: getIt<IAppConfig>().theme.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    LocaleProvider.of(context).call_us,
                                    style: TextStyle(color: getIt<IAppConfig>().theme.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    _checkIfSupportOnline()
                        ? Center(
                            child: Text(
                              LocaleProvider.of(context).we_are_online,
                              style:
                                  TextStyle(color: getIt<IAppConfig>().theme.red, fontSize: 16),
                            ),
                          )
                        : Center(
                            child: Text(
                              LocaleProvider.of(context).call_us_message,
                              style:
                                  TextStyle(color: getIt<IAppConfig>().theme.red, fontSize: 16),
                            ),
                          )
                  ],
                ),
              ),

              //
              kIsWeb
                  ? Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: context.width * 0.6,
                              maxHeight: context.height * 0.6),
                          child: kIsWeb ? HtmlElementView(viewType: 'tawkto') : WebView(initialUrl: LocaleProvider.current.tawkto_url),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 560,
                      child: WebView(
                        initialUrl: LocaleProvider.current.tawkto_url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.complete(webViewController);
                        },
                        // ignore: prefer_collection_literals
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.youtube.com/')) {
                            return NavigationDecision.prevent;
                          }

                          return NavigationDecision.navigate;
                        },
                        onPageStarted: (String url) {},
                        onPageFinished: (String url) {},
                        gestureNavigationEnabled: true,
                      ),
                    ),

              //
              Container(
                height: 30,
              )
            ],
          ),
        );
      },
    );
  }

  bool _checkIfSupportOnline() {
    DateTime time = DateTime.parse(DateTime.now().xLocalToTurkishTime());
    if (time.hour > 8 && time.hour < 18) {
      return true;
    } else {
      return false;
    }
  }
}
