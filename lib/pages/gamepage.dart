import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/widgets/bottompanel.dart';
import 'package:skippingfrog_mobile/widgets/frog.dart';
import 'package:skippingfrog_mobile/widgets/frogmessagepanel.dart';
import 'package:skippingfrog_mobile/widgets/gameheaderpanel.dart';
import 'package:skippingfrog_mobile/widgets/lillypond.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/onboardingwidget.dart';
import 'package:skippingfrog_mobile/widgets/swipingpanelregion.dart';

class GamePage extends StatefulWidget {

  static String route = '/game';

  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);
    

    if (gameService.isFirstInstall()) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context, 
          isScrollControlled: true,
          useRootNavigator: true,
          enableDrag: true,
          builder: ((context) {
          return OnboardingWidget();
        })).then((value) {
          gameService.startGame();
        });
      });
    }
    else {
      gameService.startGame();
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/imgs/water_bg.png',
              fit: BoxFit.cover
            ),
          ),
          const LillyPond(),
          const GameHeaderPanel(),
          const BottomPanel(),
          const Frog(),
          const FrogMessagePanel(),
          const SwipingPanelRegion()
        ]
      )
    );
  }
}