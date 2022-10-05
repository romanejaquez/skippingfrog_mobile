import 'package:flutter/material.dart';

class BottomPanelService extends ChangeNotifier {

  bool isGamePaused = false;
  double initialProgressValue = 0;
  double incrementalValue = 0;

  void advanceToNextLeafProgress() {
    incrementalValue++;
    notifyListeners();
  }

  void exitGame() {
    
  }

  void pauseGame() {

  }

  void reset() {
    incrementalValue = 0;
  }

  void resetValues(int leavesCount) {
    initialProgressValue = leavesCount.toDouble();
  }
}