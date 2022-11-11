import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late BuildContext ctx;
  int bugScoreValue = 100;
  int lifeScoreValue = 250;
  int checkpointValue = 100;
  int bugCount = 0;
  int gameLeafCountShowPond = 9;

  // services to query
  late FrogJumpingService frogJumpingService;
  late SwipingGestureService swipingGestureService;
  late ScorePanelService scorePanelService;
  late LeafService leafService;
  late AudioService audioService;
  late PondService pondService;
  late BottomPanelService bottomPanelService;
  late GameLocalStorage gameLocalStorage;
  late OptionsService optionsService;

  void initGame(BuildContext context) {
    ctx = context;
    leafDimension = MediaQuery.of(ctx).size.width * 0.20;
    frogDimension = MediaQuery.of(ctx).size.width * 0.25;

    initServices();
    resetGameFromTheBeginning();
  }

  bool showPond(int leafRowCount) {
    return leafRowCount >= leaves.length - gameLeafCountShowPond;
  }

  // initialize all service in one single place
  void initServices() {
    frogJumpingService = Provider.of<FrogJumpingService>(ctx, listen: false);
    scorePanelService = Provider.of<ScorePanelService>(ctx, listen: false);
    leafService = Provider.of<LeafService>(ctx, listen: false);

    swipingGestureService = Provider.of<SwipingGestureService>(ctx, listen: false);
    swipingGestureService.initSwipeGestureService(ctx);

    audioService = Provider.of<AudioService>(ctx, listen: false);
    audioService.init(ctx);

    pondService = Provider.of<PondService>(ctx, listen: false);

    bottomPanelService = Provider.of<BottomPanelService>(ctx, listen: false);
    gameLocalStorage = Provider.of<GameLocalStorage>(ctx, listen: false);
    gameLocalStorage.init(ctx, () {
      optionsService = Provider.of<OptionsService>(ctx, listen: false);
      optionsService.init(ctx);
    });
  }

  // reset all provided service
  // from a single location
  void resetServices() {
    frogJumpingService.reset();
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
    leaves = Utils.generateGameLeafs(ctx);
    var startPosition = leaves[0].index.toDouble();
    frogJumpingService.startFrogPosition = startPosition;
    frogJumpingService.endFrogPosition = startPosition;
    bottomPanelService.resetValues(leaves.length);
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
}