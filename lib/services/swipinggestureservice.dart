import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

class SwipingGestureService extends ChangeNotifier {

  SwipeDirection direction = SwipeDirection.none;
  ScrollController? swipeController;
  int leafRowCount = 1;
  double startFrogPosition = 0;
  double endFrogPosition = 0;

  void setSwipingController(ScrollController ctrl) {
    swipeController = ctrl;
  }

  void onSwipe(SwipeDirection d, BuildContext context) {
    direction = d;
    GameService gameService = Provider.of<GameService>(context, listen: false);

    // animate the lilly pond's scroll controller
    // to the height of the leaf dimension times the corresponding row
    // but only if the direction corresponds to the upcoming row's leaf direction

    var nextLeaf = gameService.leaves[leafRowCount];

    if (nextLeaf.direction.name == direction.name) {

      // FrogJumpingService fjService = Provider.of<FrogJumpingService>(context, listen: false);
      // fjService.setFrogNextJumpPosition(nextLeaf.index.toDouble(), direction);
      startFrogPosition = endFrogPosition;
      endFrogPosition = nextLeaf.index.toDouble();

      swipeController!.animateTo(gameService.leafDimension * leafRowCount, 
        duration: const Duration(milliseconds: 750), 
        curve: Curves.easeOut).then((value) {
          direction = SwipeDirection.none;
          //fjService.resetSwipe();
          notifyListeners();
        });

      leafRowCount++;
      notifyListeners();
    }
    else {
      // wrong swipe - didn't match the leaf direction
    }
  }
}