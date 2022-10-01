import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/helpers/scoretype.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';
import 'package:skippingfrog_mobile/services/pondservice.dart';

class SwipingGestureService {

  SwipeDirection direction = SwipeDirection.none;
  ScrollController? swipeController;
  int leafRowCount = 1;
  Timer swipeReminder = Timer(Duration.zero, () {});
  late BuildContext ctx;

  late GameService gameService;
  late AudioService audioService;
  late FrogMessagesService frogMessagesService;
  late LeafService leafService;
  late PondService pondService;

  void setSwipingController(ScrollController ctrl) {
    swipeController = ctrl;
  }

  void initSwipeGestureService(BuildContext context) {
    ctx = context;
    gameService = Provider.of<GameService>(ctx, listen: false);
    audioService = Provider.of<AudioService>(ctx, listen: false);
    frogMessagesService = Provider.of<FrogMessagesService>(ctx, listen: false);   
    leafService = Provider.of<LeafService>(ctx, listen: false);   
    pondService = Provider.of<PondService>(ctx, listen: false);   
  }

  void onSwipe(SwipeDirection d) {
    direction = d;
    
    // reset swipe reminder - the user has swiped
    resetSwipeReminder();

    var nextLeaf = gameService.leaves[leafRowCount];

    if(nextLeaf.direction.name == direction.name) {
      
      audioService.playSound(SkippingFrogSounds.jump, waitForSoundToFinish: true);
      FrogJumpingService frogJumpingService = Provider.of<FrogJumpingService>(ctx, listen: false);
      frogJumpingService.setFrogNextJumpPosition(
        nextLeaf.index.toDouble(),
        direction
      );

      if (gameService.showPond(leafRowCount)) {
        pondService.movePond();
      }

      swipeController!.animateTo(gameService.leafDimension * leafRowCount, duration: Utils.slidingDuration, curve: Curves.easeOut).then((value) {

          audioService.playSound(SkippingFrogSounds.land, waitForSoundToFinish: true);
          direction = SwipeDirection.none;
          frogJumpingService.resetDirection();

          leafService.notifyCurrentLeafOnRow(nextLeaf.index, leafRowCount - 1);

          if (nextLeaf.containsBug) {
            gameService.addToScore(ScoreType.bug);
          }

          if (nextLeaf.isCheckpoint) {
            /// show a message
            audioService.playSound(SkippingFrogSounds.chimeup, waitForSoundToFinish: true);
            frogMessagesService.setMessage(FrogMessages.simple, msgContent: 'CHECKPOINT #${nextLeaf.checkpointValue} REACHED!');
          }

          if (leafRowCount == gameService.leaves.length) {
            frogJumpingService.makeFinalJump(onFinalJumpDone: () {
              gameService.stopGameClock();
              swipeReminder.cancel();
              frogMessagesService.setMessage(FrogMessages.none);
              gameService.goToWinningPage();
            });
          }
        });

      leafRowCount++;
    }
    else {
      
      // decrement lives as you did the wrong swipe
      gameService.decrementLives();

      if (gameService.isGameOver()) {
        swipeReminder.cancel();
        frogMessagesService.setMessage(FrogMessages.none);
        gameService.goToLosingPage();
      }
      else {
        audioService.playSound(SkippingFrogSounds.splash, waitForSoundToFinish: true);
        frogMessagesService.setMessage(FrogMessages.splash);
      }
    }
  }

  void reset() {
    direction = SwipeDirection.none;
    leafRowCount = 1;
    swipeReminder.cancel();
  }

  void resetSwipeReminder() {
    swipeReminder.cancel();
    startSwipeReminder();
  }

  void startSwipeReminder() {
    swipeReminder = Timer.periodic(const Duration(seconds: 5), (timer) {
      audioService.playSound(SkippingFrogSounds.alert, waitForSoundToFinish: true);
      frogMessagesService.setMessage(FrogMessages.simple, msgContent: 'MAKE A MOVE!!');
    });
  }
}