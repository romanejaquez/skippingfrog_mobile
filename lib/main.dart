import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
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

    await FirebaseAppCheck.instance.activate(
      androidDebugProvider: true
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

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: 
    [SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
      
    return MaterialApp(
      navigatorKey: Utils.mainNav,
      theme: ThemeData(
        fontFamily: 'Dimitri'
      ),
      builder: (BuildContext context, Widget? child) {
        
        GameService gameService = Provider.of<GameService>(context, listen: false);
            
        if (!gameService.isGameInitialized) {
          gameService.initGame(context);
        }

        return FGBGNotifier(
          child: child!,
          onEvent: (event) {
            
            if (gameService.isGameInitialized) {
              if (event == FGBGType.background || event == FGBGType.foreground) {

                // check if game is paused before 
                if (!gameService.isGamePaused()) {
                  gameService.pauseGame(context);
                }
              }
            }
          }
        );
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