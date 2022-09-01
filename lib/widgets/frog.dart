import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class Frog extends StatefulWidget {
  const Frog({super.key});
  @override
  FrogState createState() => FrogState();
}

class FrogState extends State<Frog> with TickerProviderStateMixin {
  bool isFrogJumping = false;
  late Timer jumpTimer;
  late AnimationController frogVerticalCtrl;
  late AnimationController frogHorizCtrl;

  @override
  void initState() {
    super.initState();

    frogVerticalCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400)
    );

    frogHorizCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400)
    );
  }

  void triggerJump() {

    isFrogJumping = true;

    frogHorizCtrl.reset();
    frogHorizCtrl.forward();
    frogVerticalCtrl.forward().whenComplete(() {
      frogVerticalCtrl.reverse().whenComplete(() {
        setState(() {
          isFrogJumping = false;
        });
      });
    });
  }

  String getFrogImageFromPosition(double start, double end) {

    if(isFrogJumping) {
      // jump left
      if (start > end) {
        return 'skippingleft';
      }

      // jump right
      if (start < end) {
        return 'skippingright';
      }

      // jump forward
      if (start == end) {
        return 'jumping';
      }
    }

    return 'standing';
  }

  @override
  Widget build(BuildContext context) {
    
    GameService gameService = Provider.of<GameService>(context, listen: false);
    
    return Consumer<FrogJumpingService>(
      builder: (context, fjService, child) {
        if (fjService.currentSwipeDirection != SwipeDirection.none) {
          triggerJump();
        }

        return Positioned(
          bottom: 170,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(fjService.startFrogPosition, 0.0),
                end:  Offset(fjService.endFrogPosition, 0.0)
            ).animate(CurvedAnimation(parent: frogHorizCtrl, curve: Curves.easeInOut)),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, -1.0)
              ).animate(CurvedAnimation(parent: frogVerticalCtrl, curve: Curves.easeInOut)),
              child: Image.asset(
                'assets/imgs/frog_${getFrogImageFromPosition(fjService.startFrogPosition, fjService.endFrogPosition)}.png',
                width: gameService.frogDimension,
                height: gameService.frogDimension
              ),
            ),
          )
        );
      }
    );
  }
}
