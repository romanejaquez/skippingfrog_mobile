import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';

class GameLocalStorage {

  // shared prefs keys
  static const String onboarding = 'onboarding';
  static const String scoreData = 'scoreData';
  static const String muteSounds = 'muteAllSounds';

  late SharedPreferences prefs;
  late BuildContext ctx;

  void init(BuildContext context, Function callback) {
    ctx = context;
    SharedPreferences.getInstance().then((sp) {
      prefs = sp;
      callback();
    });
  }

  void saveData() {
    // save other data
  }

  void toggleMuteSounds(bool mute) {
    prefs.setBool(GameLocalStorage.muteSounds, mute);
  }

  bool areAllSoundsMute() {
    return prefs.getBool(GameLocalStorage.muteSounds) != null && 
      !prefs.getBool(GameLocalStorage.muteSounds)!;
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

  Future<void> clearAllGameData() async {
    await prefs.remove(GameLocalStorage.scoreData);
  }
}