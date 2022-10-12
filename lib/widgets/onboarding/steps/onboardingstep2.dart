import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';

class OnboardingStep2 extends StatefulWidget {
  const OnboardingStep2({super.key});

  @override
  State<OnboardingStep2> createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends State<OnboardingStep2> with TickerProviderStateMixin {

  late AnimationController frogTongueCtrl;
  late AnimationController bugCtrl;
  late AnimationController scoreCtrl;
  ValueNotifier<bool> scoreValue = ValueNotifier(false);
  late Timer animTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    frogTongueCtrl = AnimationController(
      vsync: this,
      lowerBound: 00,
      upperBound: 190,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    bugCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );

    scoreCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    );

    animTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      scoreCtrl.repeat(reverse: true);
      bugCtrl.forward().then((value) {
        scoreCtrl.reset();
        bugCtrl.reset();
      });
    });
  }

  @override
  void dispose() {
    frogTongueCtrl.dispose();
    bugCtrl.dispose();
    scoreCtrl.dispose();
    animTimer.cancel();
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
          const Text('Eat bugs and collect points along the way!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 25)
          ),
          Expanded(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      SkippingFrogFont.frog, 
                      size: 60,
                      color: Colors.white)
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedBuilder(
                      animation: frogTongueCtrl,
                      builder: (context, child) {
                        return Container(
                          height: 4,
                          width: frogTongueCtrl.value,
                          margin: const EdgeInsets.only(left: 60, right: 30, bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                          ),
                        );
                      }
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {

                      var offset = (constraints.maxWidth - 60) / 50;
                      return Align(
                        alignment: Alignment.centerRight,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: Offset.zero, end: Offset(offset * -1, 0))
                          .animate(CurvedAnimation(parent: bugCtrl, curve: Curves.linear)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15, right: 25),
                            child: const Icon(
                              SkippingFrogFont.bug,
                              size: 20,
                              color: Colors.white),
                          ),
                        )
                      );
                    }
                  ),
                  FadeTransition(
                    opacity: Tween<double>(begin: 1, end: 0)
                    .animate(CurvedAnimation(parent: scoreCtrl, curve: Curves.linear)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 60, right: 20),
                        child: const Text('100', 
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white))),
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