import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';

class ScorePanelService extends ChangeNotifier {

    int lives = 3;
    int bugs = 0;
    int score = 0;
    Timer gameTimer = Timer(Duration.zero, () {});
    String timeAsString = "00:00:00";
    Duration time = Duration.zero;
    bool isTimePaused = false;
    bool isTimePausedForExit = false;

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

    void pauseGameForExit() {
      isTimePausedForExit = true;

      if (isTimePaused) {
        return;
      }

      pauseGame();
    }

    void pauseGame() {
      isTimePaused = true;

      if (isTimePaused) {
        gameTimer.cancel();
      }

      notifyListeners();
    }

    void unpauseGame() {
      isTimePaused = false;
      isTimePausedForExit = false;

      startTime();
      notifyListeners();
    }

    void togglePause() {
      isTimePaused = !isTimePaused;

      if (isTimePaused) {
        gameTimer.cancel();
      }
      else {
        startTime();
      }
      notifyListeners();
    }

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
      isTimePaused = false;
      isTimePausedForExit = true;
    }
}