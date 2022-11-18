import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/scoretype.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';
import 'package:skippingfrog_mobile/pages/losingpage.dart';
import 'package:skippingfrog_mobile/pages/winningpage.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/bottompanelservice.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/services/gamelocalstorage.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';
import 'package:skippingfrog_mobile/services/optionsservice.dart';
import 'package:skippingfrog_mobile/services/pondservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class GameService {

  double leafDimension = 0;
  int leavesAcrossThePond = 4;
  List<LeafModel> leaves = [];
  double frogDimension = 0;
  late BuildContext ctxt;
  int bugScoreValue = 100;
  int lifeScoreValue = 250;
  int checkpointValue = 100;
  int bugCount = 0;
  int gameLeafCountShowPond = 9;
  bool isGameInitialized = false;

  // services to query
  late FrogJumpingService frogJumpingService;
  late FrogMessagesService frogMessagesService;
  late SwipingGestureService swipingGestureService;
  late ScorePanelService scorePanelService;
  late LeafService leafService;
  late AudioService audioService;
  late PondService pondService;
  late BottomPanelService bottomPanelService;
  late GameLocalStorage gameLocalStorage;
  late OptionsService optionsService;

  void initGame(BuildContext context) {
    ctxt = context;
    leafDimension = MediaQuery.of(ctxt).size.width * 0.20;
    frogDimension = MediaQuery.of(ctxt).size.width * 0.25;

    initServices();
    resetGameFromTheBeginning();
  }

  bool showPond(int leafRowCount) {
    return leafRowCount >= leaves.length - gameLeafCountShowPond;
  }

  // initialize all service in one single place
  void initServices() {
    frogJumpingService = Provider.of<FrogJumpingService>(ctxt, listen: false);
    scorePanelService = Provider.of<ScorePanelService>(ctxt, listen: false);
    leafService = Provider.of<LeafService>(ctxt, listen: false);

    swipingGestureService = Provider.of<SwipingGestureService>(ctxt, listen: false);
    swipingGestureService.initSwipeGestureService(ctxt);

    audioService = Provider.of<AudioService>(ctxt, listen: false);
    audioService.init(ctxt);

    pondService = Provider.of<PondService>(ctxt, listen: false);

    bottomPanelService = Provider.of<BottomPanelService>(ctxt, listen: false);
    gameLocalStorage = Provider.of<GameLocalStorage>(ctxt, listen: false);
    gameLocalStorage.init(ctxt, () {
      optionsService = Provider.of<OptionsService>(ctxt, listen: false);
      optionsService.init(ctxt);
    });

    frogMessagesService = Provider.of<FrogMessagesService>(ctxt, listen: false);
  }

  // reset all provided service
  // from a single location
  void resetServices() {
    frogJumpingService.reset();
    frogMessagesService.reset();
    scorePanelService.reset();
    leafService.reset();
    swipingGestureService.reset();
    audioService.reset();
    pondService.reset();
    bottomPanelService.reset();
  }

  // based on the score type,
  // increment the score value
  void addToScore(ScoreType type) {

    int score = 0;

    switch(type) {
      case ScoreType.bug:
        scorePanelService.incrementBugs();
        audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);
        score = bugScoreValue;
        break;
      case ScoreType.checkpoint:
        score = checkpointValue;
        break;
    }

    int additionalLives = scorePanelService.bugs % 5 == 0 ? 1 : 0;
    if (additionalLives > 0) {
      audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);
      scorePanelService.incrementLives();
      score += lifeScoreValue;
    }

    scorePanelService.addToScore(score);
  }

  void resetGameFromTheBeginning() {
    bugScoreValue = 100;
    lifeScoreValue = 250;
    bugCount = 0;
    leaves = Utils.generateGameLeafs(ctxt);
    var startPosition = leaves[0].index.toDouble();
    frogJumpingService.startFrogPosition = startPosition;
    frogJumpingService.endFrogPosition = startPosition;
    bottomPanelService.resetValues(leaves.length);

    // at this point, game has been initialized
    isGameInitialized = true;
  }

  void startGame() {
    swipingGestureService.startSwipeReminder();
    scorePanelService.startTime();
  }

  void decrementLives() {
    scorePanelService.decrementLives();
  }

  void incrementLives() {
    scorePanelService.incrementLives();
  }

  bool isGameOver() {
    return scorePanelService.lives == 0;
  }

  void goToLosingPage() {
    Utils.mainNav.currentState!.pushReplacementNamed(LosingPage.route);
  }

  void resetGame() {
    isGameInitialized = false;
    resetServices();
    resetGameFromTheBeginning();
  }

  void stopAllSounds() {
    audioService.stopAllSounds();
  }

  void goToWinningPage() {
    Utils.mainNav.currentState!.pushReplacementNamed(WinningPage.route);
  }

  void stopGameClock() {
    scorePanelService.stopTime();
  }

  ScoreConfig getScoreConfig() {
    return scorePanelService.getScoreConfig();
  }

  void neverShowOnboardingAgain() {
    gameLocalStorage.neverShowOnboardingAgain();
  }

  bool isFirstInstall() {
    return !gameLocalStorage.isOnboardingSet();
  }

  ScoreConfig getScoreData() {
    return gameLocalStorage.getScoreData();
  }

  void saveScoreData() {
    gameLocalStorage.saveScoreData(getScoreConfig());
  }

  bool areAllSoundsMute() {
    return gameLocalStorage.areAllSoundsMute();
  }

  void toggleMuteSounds(bool mute) {
    gameLocalStorage.toggleMuteSounds(mute);
  }

  Future<void> clearAllGameData() async {
    await gameLocalStorage.clearAllGameData();
  }

   bool isGamePaused() {
    return scorePanelService.isTimePaused;
  }

  void pauseGame() {
    bottomPanelService.onPause(ctxt);
  }

  void checkForNonRegisteredPlayer(String playerName,
  { Function? onNonRegisteredUser }) {
    
    var storedPlayerName = gameLocalStorage.getPlayerName();
    
    if (storedPlayerName.isNotEmpty && playerName != storedPlayerName) {
      
      Utils.showModalAlertDialog(
        title: 'Different Saved Player',
        richMessage: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black),
          children: [
            const TextSpan(text: 'The player '),
            TextSpan(text: playerName, style: const TextStyle(color: AppColors.burnedYellow)),
            const TextSpan(text: ' is different from the stored player '),
            TextSpan(text: storedPlayerName, style: const TextStyle(color: AppColors.burnedYellow)),
            const TextSpan(text: '. You cannot submit the score under the new player. Clear the data from the game first before submitting the score under the new player.')
          ]
        ),
        options: [AlertOptions.ok],
        onSelectedAlertOption: (AlertOptions o) {

          // trigger the callback, because we found out
          // the stored user is not the same as the one logged in
          if (onNonRegisteredUser != null) {
            onNonRegisteredUser();
          }
        }
      );
    }
    else {
      if (storedPlayerName.isEmpty) {
        gameLocalStorage.storePlayerName(playerName);
      }
    }
  }
}