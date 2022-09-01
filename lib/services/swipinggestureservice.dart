import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

class SwipingGestureService {

  SwipeDirection direction = SwipeDirection.none;
  ScrollController? swipeController;
  int leafRowCount = 1;

  void setSwipingController(ScrollController ctrl) {
    swipeController = ctrl;
  }

  void onSwipe(SwipeDirection d, BuildContext context) {
    direction = d;
    GameService gameService = Provider.of<GameService>(context, listen: false);

    var nextLeaf = gameService.leaves[leafRowCount];

    if(nextLeaf.direction.name == direction.name) {

      FrogJumpingService frogJumpingService = Provider.of<FrogJumpingService>(context, listen: false);
      frogJumpingService.setFrogNextJumpPosition(
        nextLeaf.index.toDouble(),
        direction
      );

      swipeController!.animateTo(gameService.leafDimension * leafRowCount, 
        duration: const Duration(milliseconds: 750), 
        curve: Curves.easeOut).then((value) {
          direction = SwipeDirection.none;
          frogJumpingService.resetDirection();
        });

      leafRowCount++;
    }
  }
}