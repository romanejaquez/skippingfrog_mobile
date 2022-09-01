import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class GameService {

  double leafDimension = 0;
  int leavesAcrossThePond = 4;
  List<LeafModel> leaves = [];
  double frogDimension = 0;

  void initGame(BuildContext context) {
    leafDimension = MediaQuery.of(context).size.width * 0.20;
    leaves = Utils.generateGameLeafs(context);
    frogDimension = MediaQuery.of(context).size.width * 0.25;

    var startPosition = leaves[0].index.toDouble();
    FrogJumpingService fjService = Provider.of<FrogJumpingService>(context, listen: false);
    fjService.startFrogPosition = startPosition;
    fjService.endFrogPosition = startPosition;
  }
}