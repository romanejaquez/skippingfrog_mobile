import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/helppage.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/pages/optionspage.dart';
import 'package:skippingfrog_mobile/pages/skippingfroglanding.dart';
import 'package:skippingfrog_mobile/pages/skippingfrogsplash.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameService()
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