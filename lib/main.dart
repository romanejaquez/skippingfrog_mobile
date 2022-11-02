import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/firebase_options.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/helppage.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/pages/losingpage.dart';
import 'package:skippingfrog_mobile/pages/optionspage.dart';
import 'package:skippingfrog_mobile/pages/skippingfroglanding.dart';
import 'package:skippingfrog_mobile/pages/skippingfrogsplash.dart';
import 'package:skippingfrog_mobile/pages/winningpage.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/bottompanelservice.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';
import 'package:skippingfrog_mobile/services/frogjumpingservice.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/services/gamelocalstorage.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/leaderboardservice.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';
import 'package:skippingfrog_mobile/services/loggerservice.dart';
import 'package:skippingfrog_mobile/services/loginservice.dart';
import 'package:skippingfrog_mobile/services/onboardingservice.dart';
import 'package:skippingfrog_mobile/services/optionsservice.dart';
import 'package:skippingfrog_mobile/services/pondservice.dart';
import 'package:skippingfrog_mobile/services/scorepanelservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

void main() async {

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    Logger.initialize(FirebaseCrashlytics.instance);

    runApp(
      MultiProvider(
        providers: [
          Provider(
            create: (_) => GameService()
          ),
          Provider(
            create: (_) => GameLocalStorage()
          ),
          Provider(
            create: (_) => AudioService()
          ),
          Provider(
            create: (_) => SwipingGestureService()
          ),
          ChangeNotifierProvider(
            create: (_) => LeaderboardService()
          ),
          ChangeNotifierProvider(
            create: (_) => BottomPanelService()
          ),
          ChangeNotifierProvider(
            create: (_) => PondService()
          ),
          ChangeNotifierProvider(
            create: (_) => DifficultyService()
          ),
          
          ChangeNotifierProvider(
            create: (_) => FrogJumpingService()
          ),
          ChangeNotifierProvider(
            create: (_) => LeafService()
          ),
          ChangeNotifierProvider(
            create: (_) => FrogMessagesService()
          ),
          ChangeNotifierProvider(
            create: (_) => ScorePanelService()
          ),
          ChangeNotifierProvider(
            create: (_) => LoginService()
          ),
          ChangeNotifierProvider(
            create: (_) => OnboardingService()
          ),
          ChangeNotifierProvider(
            create: (_) => OptionsService()
          )
        ],
        child: const SkippingFrogApp(),
      )
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class SkippingFrogApp extends StatelessWidget {
  const SkippingFrogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: Utils.mainNav,
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
        LeaderboardsPage.route: (context) => const LeaderboardsPage(),
        LosingPage.route: (context) => const LosingPage(),
        WinningPage.route: (context) => const WinningPage(),
      },
    );
  }
}