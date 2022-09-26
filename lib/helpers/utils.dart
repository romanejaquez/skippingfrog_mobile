import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/leafdirection.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';

class Utils {

  static GlobalKey<NavigatorState> mainNav = GlobalKey();

  static List<LeafModel> generateGameLeafs(BuildContext context) {

    DifficultyService difficultyService = Provider.of<DifficultyService>(context, listen: false);
    Difficulty dif = difficultyService.difficulty;
    int rows = dif == Difficulty.easy ? 100 : 200;

    List<LeafModel> leaves = [];

    Random randomLeaf = Random();
    
    for(var i = 0; i < rows; i++) {

      var isCheckpoint = i != 0 && i % (rows / 10) == 0;

      leaves.add(LeafModel(
        index: randomLeaf.nextInt(4),
        direction: LeafDirection.values[randomLeaf.nextInt(LeafDirection.values.length)],
        containsBug: randomLeaf.nextInt(rows) % 2 == 0,
        isCheckpoint: isCheckpoint,
        checkpointValue: isCheckpoint ? i ~/ 10 : -1
      ));
    
    }

    return leaves;
  }
}