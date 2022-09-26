import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';

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

          LeafService leafService = Provider.of<LeafService>(context, listen: false);
          leafService.notifyCurrentLeafOnRow(nextLeaf.index, leafRowCount - 1);

          if (nextLeaf.isCheckpoint) {
            /// show a message
            FrogMessagesService frogMessagesService = 
              Provider.of<FrogMessagesService>(context, listen: false);
            frogMessagesService.setMessage(FrogMessages.simple, msgContent: 'CHECKPOINT #${nextLeaf.checkpointValue} REACHED!');

          }
        });

      leafRowCount++;

      // check if the user has won or lost
    }
    else { 
      FrogMessagesService frogMessagesService = Provider.of<FrogMessagesService>(context, listen: false);

      gameService.decrementLives();

      if (gameService.isGameOver()) {
        frogMessagesService.setMessage(FrogMessages.none);
        gameService.goToLosingPage();
      }
      else {
        frogMessagesService.setMessage(FrogMessages.splash);
      }
    }
  }

  void reset() {
    direction = SwipeDirection.none;
    leafRowCount = 1;
  }
}