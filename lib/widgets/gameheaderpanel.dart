import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';

class GameHeaderPanel extends StatelessWidget {
  const GameHeaderPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Image.asset('assets/imgs/toppanel.png',
            height: 200,
            fit: BoxFit.fitHeight
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(SkippingFrogFont.frog, color: AppColors.gameHeaderIconColors, size: 30),
                      const SizedBox(width: 10),
                      Text('3', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(SkippingFrogFont.bug, color: AppColors.gameHeaderIconColors, size: 30),
                      const SizedBox(width: 10),
                      Text('20', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                      ))
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('00:00:00', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          )),
                          const SizedBox(width: 10),
                          Icon(SkippingFrogFont.time, color: AppColors.gameHeaderIconColors, size: 30),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('2500', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          )),
                          const SizedBox(width: 10),
                          Icon(SkippingFrogFont.flag, color: AppColors.gameHeaderIconColors, size: 30),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]
      )
    );
  }
}