import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';

class GameService {

  double leafDimension = 0;
  int leavesAcrossThePond = 4;
  List<LeafModel> leaves = [];

  void initGame(BuildContext context) {
    leafDimension = MediaQuery.of(context).size.width * 0.20;
    leaves = Utils.generateGameLeafs(context);
  }
}