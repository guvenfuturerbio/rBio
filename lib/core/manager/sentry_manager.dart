import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../core.dart';

abstract class SentryManager {
  Future<void> init(
    FutureOr<void> Function() appRunner,
    String version,
  );
  Widget wrapBundle(Widget child);
  Future<SentryId> captureException(
    throwable, {
    stackTrace,
    hint,
    ScopeCallback? withScope,
  }) async {
    return await Sentry.captureException(
      throwable,
      stackTrace: stackTrace,
      hint: hint,
      withScope: withScope,
    );
  }
}

class GuvenOnlineSentryManagerImpl extends SentryManager {
  final String _dsn =
      'https://f54e64bc5a8a4c9bbcddf7bb771c5967@o983734.ingest.sentry.io/5940445';
  final String _release = 'com.guvenfuture.online@';

  @override
  Future<void> init(
    FutureOr<void> Function() appRunner,
    String version,
  ) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = _dsn;
        options.enablePrintBreadcrumbs = true;
        options.attachStacktrace = true;
        options.release = _release + version;
        options.environment = kDebugMode
            ? Environment.dev.toString()
            : Environment.prod.toString();
        options.diagnosticLevel = SentryLevel.debug;
        options.sendDefaultPii = true;
      },
      appRunner: appRunner,
    );
  }

  @override
  Widget wrapBundle(Widget child) {
    return DefaultAssetBundle(
      bundle: SentryAssetBundle(enableStructuredDataTracing: true),
      child: child,
    );
  }
}

class OneDoseSentryManagerImpl extends SentryManager {
  final String _dsn =
      'https://cdaf2769f32349d8baf6fa2f97d04aa5@o983734.ingest.sentry.io/6511487';
  final String _release = 'com.guvenfuture.onedosehealth@';

  @override
  Future<void> init(
    FutureOr<void> Function() appRunner,
    String version,
  ) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = _dsn;
        options.enablePrintBreadcrumbs = true;
        options.attachStacktrace = true;
        options.release = _release + version;
        options.environment = kDebugMode
            ? Environment.dev.toString()
            : Environment.prod.toString();
        options.diagnosticLevel = SentryLevel.debug;
        options.sendDefaultPii = true;
      },
      appRunner: appRunner,
    );
  }

  @override
  Widget wrapBundle(Widget child) {
    return DefaultAssetBundle(
      bundle: SentryAssetBundle(enableStructuredDataTracing: true),
      child: child,
    );
  }
}
