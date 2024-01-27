import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/services/analytic/analytic_event.dart';

@singleton
class GoogleAnalyticService {
  final FirebaseAnalytics _analytics;
  GoogleAnalyticService(this._analytics);

  Future<void> sendEvent(
      AnalyticEvent event, Map<String, dynamic> params) async {
    try {
      log("🛜 [Analytics] ${event.toName}");
      await _analytics.logEvent(name: event.toName, parameters: params);
    } catch (e) {
      log("🐛[Analytics] ${e.toString()}");
    }
  }
}
