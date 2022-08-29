import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class GameService {

  double leafDimension = 0;
  double frogDimension = 0;
  int leavesAcrossThePond = 4;
  List<LeafModel> leaves = [];
  double startFrogPosition = 0;

  void initGame(BuildContext context) {
    leafDimension = MediaQuery.of(context).size.width * 0.20;
    frogDimension = MediaQuery.of(context).size.width * 0.25;
    leaves = Utils.generateGameLeafs(context);

    // set frog's initial position
    var fjService = Provider.of<SwipingGestureService>(context, listen: false);
    //var fjService = Provider.of<FrogJumpingService>(context, listen: false);
    startFrogPosition = leaves[0].index.toDouble();
    fjService.startFrogPosition = startFrogPosition;
    fjService.endFrogPosition = startFrogPosition;
  }
}