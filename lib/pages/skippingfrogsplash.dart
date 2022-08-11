import 'dart:async';

import 'package:flutter/material.dart';

class SkippingFrogAppSplash extends StatefulWidget {

  static String route = '/';
  const SkippingFrogAppSplash({Key? key}) : super(key: key);

  @override
  State<SkippingFrogAppSplash> createState() => _SkippingFrogAppSplashState();
}

class _SkippingFrogAppSplashState extends State<SkippingFrogAppSplash> {
  
  late Timer timer;

  @override 
  void initState() {
    super.initState();

    timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/landing');
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/imgs/skippingfrog_logo_off.png',
          width: 250,
          height: 250
        ),
      )
    );
  }
}