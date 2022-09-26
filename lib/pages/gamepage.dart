import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/widgets/frog.dart';
import 'package:skippingfrog_mobile/widgets/frogmessagepanel.dart';
import 'package:skippingfrog_mobile/widgets/gameheaderpanel.dart';
import 'package:skippingfrog_mobile/widgets/lillypond.dart';
import 'package:skippingfrog_mobile/widgets/swipingpanelregion.dart';

class GamePage extends StatelessWidget {

  static String route = '/game';

  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);
    gameService.startGame();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/imgs/water_bg.png',
              fit: BoxFit.fitHeight
            ),
          ),
          const LillyPond(),
          const GameHeaderPanel(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/imgs/bottom_panel.png')
          ),
          const Frog(),
          const FrogMessagePanel(),
          const SwipingPanelRegion()
        ]
      )
    );
  }
}