import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


class AnalysisHelper {
  AnalysisHelper._();

  static Future<void> initSentry({
    String? dsn,
    FutureOr<void> Function()? appRunner,
  }) async {
    // - to find dsn =>
    // 1 - go to : https://sentry.io/
    // 2 - go to : Project -> Settings -> Clients Keys -> DSN
    await SentryFlutter.init((options) {
      options.dsn = dsn;
      options.sendDefaultPii = true;
      options.tracesSampleRate = 1.0;
    }, appRunner: () => appRunner);
  }

  static Future<void> initCrashlytics({FirebaseOptions? options}) async {
    // - Don't Forget To Add Google Service File

    await Firebase.initializeApp(options: options);
    FlutterError.onError = (errorDetails) =>
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
