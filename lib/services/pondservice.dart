import 'package:flutter/material.dart';

class PondService extends ChangeNotifier {

    // lillypond values
  double startPondValue = -1;
  double endPondValue = -1;
  double incrementValue = 0.08;

  void movePond() {
    startPondValue = endPondValue;
    endPondValue += incrementValue;
    notifyListeners();
  }

  void reset() {
    startPondValue = -1;
    endPondValue = -1;
  }
}