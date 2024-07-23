import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class AnalyticsEvents {
  static void addTask() {
    analytics.logEvent(
      name: 'add_task',
    );
  }

  static void removeTask() {
    analytics.logEvent(
      name: 'remove_task',
    );
  }

  static void editTask() {
    analytics.logEvent(
      name: 'edit_task',
    );
  }

  static void pushPage(String pageName) {
    analytics.logEvent(
      name: 'push_page',
      parameters: {
        'page_name': pageName,
      },
    );
  }
}
