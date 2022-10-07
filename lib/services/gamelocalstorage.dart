import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameLocalStorage {

  // shared prefs keys
  static const String onboarding = 'onboarding';

  late SharedPreferences prefs;
  late BuildContext ctx;

  void init(BuildContext context) {
    ctx = context;
    SharedPreferences.getInstance().then((sp) {
      prefs = sp;
    });
  }

  void saveData() {
    // save other data
  }

  void neverShowOnboardingAgain() {
    prefs.setBool(GameLocalStorage.onboarding, false);
  }

  bool isOnboardingSet() {
    return prefs.getBool(GameLocalStorage.onboarding) != null && 
      !prefs.getBool(GameLocalStorage.onboarding)!;
  }
}