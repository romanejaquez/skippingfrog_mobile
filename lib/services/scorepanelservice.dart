import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';

class ScorePanelService extends ChangeNotifier {

    int lives = 3;
    int bugs = 0;
    int score = 0;
    Timer gameTimer = Timer(Duration.zero, () {});
    String timeAsString = "00:00:00";
    Duration time = Duration.zero;

    void startTime() {

      gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // update the time
        time = Duration(seconds: time.inSeconds + 1);
        timeAsString = Utils.formatTimeAsString(time);
        notifyListeners();
      });
    }

    void stopTime() {
      gameTimer.cancel();
    }

    ScoreConfig getScoreConfig() {
      return ScoreConfig(
        bugs: bugs, 
        score: score, 
        time: time, 
        timeAsString: timeAsString
      );
    }

    void pauseTime() {}

    void addToScore(int scoreValue) {
      score += scoreValue;
      notifyListeners();
    }

    void incrementBugs() {
      bugs++;
      notifyListeners();
    }

    void incrementLives() {
      lives++;
      notifyListeners();
    }

    void decrementLives() {
      lives--;
      notifyListeners();
    }

    void reset() {
      lives = 3;
      bugs = 0;
      score = 0;
      gameTimer.cancel();
      timeAsString = "00:00:00";
      time = Duration.zero;
    }
}