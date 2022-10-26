import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';

class GameLocalStorage {

  // shared prefs keys
  static const String onboarding = 'onboarding';
  static const String scoreData = 'scoreData';

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

  void saveScoreData(ScoreConfig scoreConfig) {
    prefs.setString(GameLocalStorage.scoreData, json.encode(scoreConfig.toJson()));
  }

  ScoreConfig getScoreData() {
    if (prefs.getString(GameLocalStorage.scoreData) != null) {
      var scoreDataAsString = prefs.getString(GameLocalStorage.scoreData)!;
      return ScoreConfig.fromJson(json.decode(scoreDataAsString));
    }

    return ScoreConfig(
      bugs: 0, 
      score: 0, 
      time: Duration.zero, 
      timeAsString: '00:00:00'
    );
  }
}