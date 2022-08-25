import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class LillyPond extends StatefulWidget {
  const LillyPond({Key? key}) : super(key: key);

  @override
  State<LillyPond> createState() => _LillyPondState();
}

class _LillyPondState extends State<LillyPond> {
  final lillyPondScrollController = ScrollController();
  late GameService gameService;
  late SwipingGestureService swipingGestureService;

  @override
  void initState() {
    super.initState();

    gameService = Provider.of<GameService>(context, listen: false);
    swipingGestureService = Provider.of<SwipingGestureService>(context, listen: false);
    swipingGestureService.setSwipingController(lillyPondScrollController);
    
  }

  @override 
  void dispose() {
    lillyPondScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: ListView.builder(
        controller: lillyPondScrollController,
        reverse: true,
        padding: const EdgeInsets.only(bottom: 160),
        itemCount: gameService.leaves.length,
        itemBuilder: (context, index) {
          
          List<Widget> leafRows = [];
          double leafDimension = gameService.leafDimension;

          for(var r = 0; r < gameService.leavesAcrossThePond; r++) {
            LeafModel leafModel = gameService.leaves[index];

            leafRows.add(
              leafModel.index == r ?
                Image.asset('assets/imgs/leaf_${leafModel.direction.name}.png',
                  width: leafDimension,
                  height: leafDimension
                ) :
                leafModel.isBreakpoint ? Image.asset('assets/imgs/lilly.png',
                  width: leafDimension,
                  height: leafDimension
                ) :
                SizedBox(
                  width: leafDimension, height: leafDimension
                )
            );
          }


          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: leafRows,
          );
        })
    );
  }
}