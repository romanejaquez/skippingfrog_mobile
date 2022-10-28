import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/loggerservice.dart';

class SkippingFrogAppSplash extends StatefulWidget {

  static String route = '/';
  const SkippingFrogAppSplash({Key? key}) : super(key: key);

  @override
  State<SkippingFrogAppSplash> createState() => _SkippingFrogAppSplashState();
}

class _SkippingFrogAppSplashState extends State<SkippingFrogAppSplash> with SingleTickerProviderStateMixin {
  
  late Timer timer;
  late AnimationController logoCtrl;

  @override 
  void initState() {
    super.initState();

    logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3)
    )..forward();

    Logger.message('loading splash screen');
  }

  @override
  void didChangeDependencies() {
    timer = Timer(const Duration(seconds: 3), () {
      
      Utils.preloadImages(context).then((value) {
        super.didChangeDependencies();
        Utils.mainNav.currentState!.pushReplacementNamed('/landing');
      });
    });
    
  }

  @override
  void dispose() {
    timer.cancel();
    logoCtrl.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: logoCtrl, curve: Curves.easeInOut)),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: logoCtrl, curve: Curves.easeInOut)),
            child: Image.asset(
              'assets/imgs/skippingfrog_logo_off.png',
              width: 250,
              height: 250
            ),
          ),
        ),
      )
    );
  }
}