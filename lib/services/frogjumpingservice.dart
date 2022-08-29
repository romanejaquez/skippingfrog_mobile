import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';

class FrogJumpingService extends ChangeNotifier {

  double startFrogPosition = 0;
  double endFrogPosition = 0;
  SwipeDirection currentSwipeDirection = SwipeDirection.none;

  void setFrogNextJumpPosition(double nextPosition, SwipeDirection swipe) {
    currentSwipeDirection = swipe;
    startFrogPosition = endFrogPosition;
    endFrogPosition = nextPosition;
    notifyListeners();
  }

  void resetSwipe() {
    currentSwipeDirection = SwipeDirection.none;
    notifyListeners();
  }
}