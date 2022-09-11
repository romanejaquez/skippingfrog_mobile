import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';

class FrogSplashMessage extends StatefulWidget {
  const FrogSplashMessage({super.key});

  @override
  State<FrogSplashMessage> createState() => _FrogSplashMessageState();
}

class _FrogSplashMessageState extends State<FrogSplashMessage> {
  late Timer splashTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    splashTimer = Timer(const Duration(milliseconds: 1500), () {
      Provider.of<FrogMessagesService>(context, listen: false).setMessage(FrogMessages.none);
    });
  }

  @override
  void dispose() {
    splashTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 120),
              padding: const EdgeInsets.only(
                left: 60,
                right: 20,
                bottom: 20,
                top: 20
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OOPS!',
                    style: TextStyle(
                      color: AppColors.burnedYellow,
                      fontSize: 40
                    )
                  ),
                  Text('Watch your step!',
                    style: TextStyle(color: Colors.white,
                      fontSize: 20
                    )
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(SkippingFrogFont.frog, color: AppColors.gameHeaderIconColors, size: 25),
                      const SizedBox(width: 16),
                      Text('3', style: TextStyle(
                        color: AppColors.gameHeaderIconColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                      )),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text('Lives\nRemaining', style: TextStyle(
                            color: AppColors.gameHeaderIconColors)),
                        ],
                      )
                    ],
                  )
                ],
              )
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 200),
              child: Image.asset(
                'assets/imgs/splash_badge.png',
                width: 200,
                height: 200
              ),
            ),
          ),
        ],
      ),
    );
  }
}