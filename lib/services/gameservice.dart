import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';

class GameService extends ChangeNotifier {

  Difficulty difficulty = Difficulty.easy;

  void setGameDifficulty(Difficulty dif) {
    difficulty = dif;
    notifyListeners();
  }
}