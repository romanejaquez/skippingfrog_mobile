import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';

class OnboardingStep3 extends StatefulWidget {
  const OnboardingStep3({super.key});

  @override
  State<OnboardingStep3> createState() => _OnboardingStep3State();
}

class _OnboardingStep3State extends State<OnboardingStep3> with TickerProviderStateMixin {

  late AnimationController frogJump;
  late AnimationController frogVert;
  late Timer jumpTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    frogJump = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    frogVert = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..forward().then((value) {
      frogVert.reverse();
    });

    jumpTimer = Timer.periodic(const Duration(seconds: 2), (timer) {

      frogJump.reset();
      frogJump.forward();
      frogVert.forward().then(((value) {
        frogVert.reverse();
      }));
    });
    
  }

  @override
  void dispose() {
    frogJump.dispose();
    frogVert.dispose();
    jumpTimer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Jump from leaf to leaf until reaching the end of the pond in the shortest time',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 30)
          ),
          Expanded(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: Offset.zero, end: const Offset(8, 0))
                      .animate(CurvedAnimation(parent: frogJump, curve: Curves.easeInOut)),
                      child: SlideTransition(
                        position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
                        .animate(CurvedAnimation(parent: frogVert, curve: Curves.easeInOut)),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          child: const Icon(SkippingFrogFont.frog, size: 30, color: Colors.white)
                        ),
                      ),
                    )
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/imgs/ob_leafright.png',
                          width: 50, height: 50
                        ),
                        Image.asset('assets/imgs/ob_leafright.png',
                          width: 50, height: 50
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}