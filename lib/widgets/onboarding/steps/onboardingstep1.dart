import 'package:flutter/material.dart';

class OnboardingStep1 extends StatefulWidget {
  const OnboardingStep1({super.key});

  @override
  State<OnboardingStep1> createState() => _OnboardingStep1State();
}

class _OnboardingStep1State extends State<OnboardingStep1> with SingleTickerProviderStateMixin {

  late AnimationController handCtrl;

  @override
  void initState() {
    super.initState();

    handCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

  }

  @override
  void dispose() {
    handCtrl.dispose();
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
          const Text('Swipe in the direction of the leaf in turn so the frog jumps to it',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 30)
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/imgs/ob_leafup.png',
                  width: 60,
                  height: 60,
                ),
                Image.asset('assets/imgs/ob_arrowup.png',
                  width: 80,
                  height: 150,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.5),
                    end: const Offset(0.0, -0.5)
                  ).animate(CurvedAnimation(parent: handCtrl, curve: Curves.easeInOut)),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1)
                    .animate(CurvedAnimation(parent: handCtrl, curve: Curves.easeInOut)),
                    child: Image.asset('assets/imgs/ob_hand.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}