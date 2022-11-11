import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class BottomPanelService extends ChangeNotifier {

  double initialProgressValue = 0;
  double incrementalValue = 0;

  void advanceToNextLeafProgress() {
    incrementalValue++;
    notifyListeners();
  }

  void exitGame(BuildContext context) {
    var gameService = Provider.of<GameService>(context,  listen: false);
    gameService.resetGame();
    Utils.mainNav.currentState!.pop();
  }

  void reset() {
    incrementalValue = 0;
  }

  void resetValues(int leavesCount) {
    initialProgressValue = leavesCount.toDouble();
  }

  void onPause(BuildContext context) {
    var audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);

    var swipingGestureService = Provider.of<SwipingGestureService>(context, listen: false);
    var scorePanelService = Provider.of<ScorePanelService>(context, listen: false);
    
    var frogMessagesService = Provider.of<FrogMessagesService>(context, listen: false);
    frogMessagesService.setMessage(FrogMessages.none);

    scorePanelService.togglePause();

    if (scorePanelService.isTimePaused) {
      frogMessagesService.setMessageAndKeepVisible(
        FrogMessages.simple, msgContent: 
        'GAME PAUSED');
    }
    else {
      frogMessagesService.setMessage(FrogMessages.none);
    }

    swipingGestureService.resetSwipeReminder();
  }

  void onExitGame(BuildContext context) {
    var audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);

    var scorePanelService = Provider.of<ScorePanelService>(context, listen: false);
    var swipingGestureService = Provider.of<SwipingGestureService>(context, listen: false);
    var frogMessagesService = Provider.of<FrogMessagesService>(context, listen: false);
    
    if (!scorePanelService.isTimePaused) {
      scorePanelService.isTimePausedForExit = true;
      scorePanelService.pauseGame();
      swipingGestureService.resetSwipeReminder();
    }
    
    Utils.showModalAlertDialog(context,
      title: 'Exit Game',
      message: 'Are you sure you want to exit the game?',
      options: [AlertOptions.yes, AlertOptions.no],
      (AlertOptions selectedOption) {
        if (selectedOption == AlertOptions.yes) {
          exitGame(context);
        }
        else {

          if (scorePanelService.isTimePaused && scorePanelService.isTimePausedForExit) {
            scorePanelService.unpauseGame();
            frogMessagesService.resetMessagePanel();
            swipingGestureService.resetSwipeReminder();
          }
        }
      }
    );
  }
}