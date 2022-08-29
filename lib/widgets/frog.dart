import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class Frog extends StatefulWidget {
  const Frog({Key? key}) : super(key: key);

  @override
  State<Frog> createState() => _FrogState();
}

class _FrogState extends State<Frog> with TickerProviderStateMixin {

  late AnimationController frogVerticalLeapCtrl;
  late AnimationController frogHorizLeapCtrl;
  late Timer jumpTimer;
  bool isFrogJumping = false;

  @override
  void initState() {
    super.initState();

    frogVerticalLeapCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 400)
    );

    frogHorizLeapCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 400)
    );
  }

  void triggerJump() {
    if (mounted) {
        //setState(() {
          isFrogJumping = true;
        //});
      }

      frogHorizLeapCtrl.reset();
      frogHorizLeapCtrl.forward();
      frogVerticalLeapCtrl.forward().whenComplete(() {
        frogVerticalLeapCtrl.reverse().whenComplete(() {
          if (mounted) {
            setState(() {
              isFrogJumping = false;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    frogVerticalLeapCtrl.dispose();
    jumpTimer.cancel();
    super.dispose();
  }

  String getFrogImageFromPosition(double startPos, double endPos) {
    if (isFrogJumping) {
      if (startPos == endPos) {
          return 'jumping';
      }
      
      if (startPos > endPos) {
          return 'skippingleft';
      }

      if (startPos < endPos) {
          return 'skippingright';
      }
    }

    return 'standing';
  }

  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);
    
    return Consumer<SwipingGestureService>(
      builder: (context, fjService, child) {
        if (fjService.direction != SwipeDirection.none) {
          triggerJump();
        }

        return Positioned(
          bottom: 170,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(fjService.startFrogPosition, 0.0),
              end: Offset(fjService.endFrogPosition, 0.0)
            ).animate(CurvedAnimation(parent: frogHorizLeapCtrl, curve: Curves.easeInOut)),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, -1.0)
              ).animate(CurvedAnimation(parent: frogVerticalLeapCtrl, curve: Curves.easeInOut)),
              child: Image.asset('assets/imgs/frog_${getFrogImageFromPosition(fjService.startFrogPosition, fjService.endFrogPosition)}.png',
                width: gameService.frogDimension,
                height: gameService.frogDimension,
              ),
            ),
          ),
        );
      },
    );
  }
}