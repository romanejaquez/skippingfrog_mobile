import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/pages/losingpage.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class GameService {

  double leafDimension = 0;
  int leavesAcrossThePond = 4;
  List<LeafModel> leaves = [];
  double frogDimension = 0;
  late BuildContext ctx;

  // services to query
  late FrogJumpingService frogJumpingService;
  late SwipingGestureService swipingGestureService;
  late ScorePanelService scorePanelService;
  late LeafService leafService;

  void initGame(BuildContext context) {
    ctx = context;
    leafDimension = MediaQuery.of(ctx).size.width * 0.20;
    frogDimension = MediaQuery.of(ctx).size.width * 0.25;

    initServices();
    resetGameFromTheBeginning();
  }

  void initServices() {
    frogJumpingService = Provider.of<FrogJumpingService>(ctx, listen: false);
    scorePanelService = Provider.of<ScorePanelService>(ctx, listen: false);
    leafService = Provider.of<LeafService>(ctx, listen: false);
    swipingGestureService = Provider.of<SwipingGestureService>(ctx, listen: false);
  }

  void resetServices() {
    frogJumpingService.reset();
    scorePanelService.reset();
    leafService.reset();
    swipingGestureService.reset();
  }

  void resetGameFromTheBeginning() {
    
    leaves = Utils.generateGameLeafs(ctx);
    var startPosition = leaves[0].index.toDouble();
    frogJumpingService.startFrogPosition = startPosition;
    frogJumpingService.endFrogPosition = startPosition;
  }

  void startGame() {
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
}