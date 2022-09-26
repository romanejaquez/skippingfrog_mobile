import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';

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
              child: Consumer<ScorePanelService>(
                builder: (context, scorePanelService, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(SkippingFrogFont.frog, color: AppColors.gameHeaderIconColors, size: 30),
                            const SizedBox(width: 16),
                            Text('${scorePanelService.lives}', style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(SkippingFrogFont.bug, color: AppColors.gameHeaderIconColors, size: 30),
                            const SizedBox(width: 16),
                            Text('${scorePanelService.bugs}', style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(scorePanelService.timeAsString, style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                )),
                                const SizedBox(width: 10),
                                const Icon(SkippingFrogFont.time, color: AppColors.gameHeaderIconColors, size: 30),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${scorePanelService.score}', style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                )),
                                const SizedBox(width: 10),
                                const Icon(SkippingFrogFont.flag, color: AppColors.gameHeaderIconColors, size: 30),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          )
        ]
      )
    );
  }
}