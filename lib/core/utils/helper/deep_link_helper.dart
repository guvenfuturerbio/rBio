import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

import '../../core.dart';

class DeepLinkHelper {
  DeepLinkHelper._();

  static DeepLinkHelper? _instance;

  static DeepLinkHelper get instance {
    _instance ??= DeepLinkHelper._();
    return _instance!;
  }

  late BuildContext context;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  String deepLinkPath = "";
  Future<void> initDynamicLinks(BuildContext context) async {
    this.context = context;
    Uri? deepLink;
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    deepLink = data?.link;

    dynamicLinks.onLink.listen((dynamicLinkData) {
      deepLink = dynamicLinkData.link;
      checkDeepLink(deepLink);
    }).onError((error) {
      LoggerUtils.instance.w(error.message);
    });

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
