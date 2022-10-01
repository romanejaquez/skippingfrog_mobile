import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';

class FrogJumpingService extends ChangeNotifier {

  double startFrogPosition = 0;
  double endFrogPosition = 0;
  double frogVerticalJumpStart = 0;
  double frogVerticalJumpEnd = -1;

  // final jump values
  bool isFinalJump = false;
  double endJumpValue = -4;
  double endJumpPosition = 1.5;

  SwipeDirection currentSwipeDirection = SwipeDirection.none;

  // set the frog's next jump position
  // using as a reference the current swiping direction
  void setFrogNextJumpPosition(double nextPosition, SwipeDirection direction) {
    currentSwipeDirection = direction;
    startFrogPosition = endFrogPosition;
    endFrogPosition = nextPosition;
    notifyListeners();
  }

  // reset the direction of the swiping,
  // so the frog knows not to trigger the jump on its end
  void resetDirection() {
    currentSwipeDirection = SwipeDirection.none;
  }

  // reset the values to the defaults
  void reset() {
    startFrogPosition = 0;
    endFrogPosition = 0;
    frogVerticalJumpStart = 0;
    frogVerticalJumpEnd = -1;
    isFinalJump = false;
    currentSwipeDirection = SwipeDirection.none;
  }


  // make the final jump logic, and upon finishing,
  // trigger the provided callback
  void makeFinalJump({ required Function onFinalJumpDone }) {
    
    // wait a bit before starting
    Timer(const Duration(milliseconds: 150), () {

      // mark this as the final jump and
      // change the appropriate values as well
      // as trigger the notification
      isFinalJump = true;
      currentSwipeDirection = SwipeDirection.up;
      startFrogPosition = endFrogPosition;
      frogVerticalJumpStart = 0;
      frogVerticalJumpEnd = endJumpValue;
      endFrogPosition = endJumpPosition;
      notifyListeners();

      // wait  yet a little more (or the duration of the jump)
      // to flip the values to their final states,
      // then notify once again
      Timer(const Duration(milliseconds: Utils.slidingDurationValue), () {
        currentSwipeDirection = SwipeDirection.none;
        frogVerticalJumpStart = endJumpValue;
        frogVerticalJumpEnd = endJumpValue;
        startFrogPosition = endJumpPosition;
        endFrogPosition = endJumpPosition;
        notifyListeners();

        // wait just a tiny bit more to then
        // notify the callback
        Timer(const Duration(milliseconds: 100), () {
          onFinalJumpDone();
        });
      });
    });
  }
}