import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/helppage.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/pages/optionspage.dart';
import 'package:skippingfrog_mobile/pages/skippingfroglanding.dart';
import 'package:skippingfrog_mobile/pages/skippingfrogsplash.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => GameService()
        ),
        ChangeNotifierProvider(
          create: (_) => DifficultyService()
        ),
        Provider(
          create: (_) => SwipingGestureService()
        ),
        ChangeNotifierProvider(
          create: (_) => FrogJumpingService()
        )
      ],
      child: const SkippingFrogApp(),
    )
  );
}

class SkippingFrogApp extends StatelessWidget {
  const SkippingFrogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Dimitri'
      ),
      builder: (BuildContext context, Widget? child) {

        // initialize the game service
        GameService gameService = Provider.of<GameService>(context, listen: false);
        gameService.initGame(context);
        return child!;
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SkippingFrogAppSplash.route,
      routes: {
        SkippingFrogAppSplash.route: (context) => const SkippingFrogAppSplash(),
        SkippingFrogLanding.route: (context) => const SkippingFrogLanding(),
        HelpPage.route: (context) => const HelpPage(),
        OptionsPage.route: (context) => const OptionsPage(),
        GamePage.route: (context) => const GamePage(),
        LeaderboardsPage.route: (context) => const LeaderboardsPage()
      },
    );
  }
}