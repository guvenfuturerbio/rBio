import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as htmlK;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';

class ContactUsScreen extends StatefulWidget {
  String url;
  String title;

  ContactUsScreen({
    Key key,
    this.url,
    this.title,
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
        return kIsWeb
            ? Padding(
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
                          kIsWeb
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    launch("tel://4449494");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      gradient: LinearGradient(
                                          colors: [
                                            R.color.blue,
                                            R.color.light_blue
                                          ],
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.centerRight),
                                      border: Border.all(
                                        width: 1,
                                        color: R.color.blue,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(20),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          R.image.ic_phone_call_grey,
                                          color: R.color.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          LocaleProvider.of(context).call_us,
                                          style:
                                              TextStyle(color: R.color.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          Center(
                            child: Text(
                              LocaleProvider.of(context).call_us_message,
                              style:
                                  TextStyle(color: R.color.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: Get.width * 0.6,
                              maxHeight: Get.height * 0.6),
                          child: HtmlElementView(viewType: 'tawkto'),
                        ),
                      ),
                    ),

                    //
                    Container(
                      height: 30,
                    )
                  ],
                ),
              )
            : ListView(
                children: <Widget>[
                  //
                  Container(
                    height: 130,
                    child: Column(
                      children: <Widget>[
                        kIsWeb
                            ? SizedBox()
                            : InkWell(
                                onTap: () {
                                  launch("tel://4449494");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    gradient: LinearGradient(
                                        colors: [
                                          R.color.blue,
                                          R.color.light_blue
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.centerRight),
                                    border: Border.all(
                                      width: 1,
                                      color: R.color.blue,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        R.image.ic_phone_call_grey,
                                        color: R.color.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        LocaleProvider.of(context).call_us,
                                        style: TextStyle(color: R.color.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        Center(
                          child: Text(
                            LocaleProvider.of(context).call_us_message,
                            style: TextStyle(color: R.color.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  kIsWeb
                      ? button(
                          text: 'Chat',
                          onPressed: () =>
                              htmlK.window.open('widget.url', 'new tab'))
                      : Container(
                          height: 560,
                          child: WebView(
                            initialUrl: widget.url,
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            },
                            // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                            // ignore: prefer_collection_literals
                            navigationDelegate: (NavigationRequest request) {
                              if (request.url
                                  .startsWith('https://www.youtube.com/')) {
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
                          ),
                        ),

                  //
                  Container(
                    height: 30,
                  ),
                ],
              );
      },
    );
  }
}
