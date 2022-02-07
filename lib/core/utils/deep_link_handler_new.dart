import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../core.dart';

class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  late BuildContext context;

  factory DeepLinkHandler() {
    return _instance;
  }

  DeepLinkHandler._internal();

  String deepLinkPath = "";
  Future<void> initDynamicLinks(BuildContext context) async {
    this.context = context;
    Uri? deepLink;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    deepLink = data?.link;

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        deepLink = dynamicLink?.link;
        checkDeepLink(deepLink);
      },
      onError: (OnLinkErrorException e) async {
        LoggerUtils.instance.w(e.message);
      },
    );

    LoggerUtils.instance.d("Deep Link : " + deepLink.toString());
    return checkDeepLink(deepLink);
  }

  Future<void> checkDeepLink(Uri? deepLink) async {
    if (deepLink != null) {
      if (deepLink.queryParameters.isNotEmpty) {
        {
          context.vRouter
              .to(deepLink.path, queryParameters: deepLink.queryParameters);
        }
      } else {
        Atom.to(deepLink.path);
      }
    }
  }
}
