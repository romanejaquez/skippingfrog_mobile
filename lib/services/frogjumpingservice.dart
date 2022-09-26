import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';

class FrogJumpingService extends ChangeNotifier {

  double startFrogPosition = 0;
  double endFrogPosition = 0;
  SwipeDirection currentSwipeDirection = SwipeDirection.none;

  void setFrogNextJumpPosition(double nextPosition, SwipeDirection direction) {
    currentSwipeDirection = direction;
    startFrogPosition = endFrogPosition;
    endFrogPosition = nextPosition;
    notifyListeners();
  }

  void resetDirection() {
    currentSwipeDirection = SwipeDirection.none;
  }

  void reset() {
    startFrogPosition = 0;
    endFrogPosition = 0;
    currentSwipeDirection = SwipeDirection.none;
  }
}