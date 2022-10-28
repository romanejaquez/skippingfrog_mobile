import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Logger {

  static late FirebaseCrashlytics _instance;

  static void initialize(FirebaseCrashlytics instance) {
    _instance = instance;
  }

  static void logForUser(String uid) {
    _instance.setUserIdentifier(uid);
  }

  static void message(String message) {
    _instance.log(message);
  }

  static void error(dynamic error, StackTrace stackTrace, { String reason = '' }) {
    _instance.recordError(error, stackTrace, reason: reason);
  }
}