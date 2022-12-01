import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/pages/skippingfroglanding.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class WinningPage extends StatefulWidget {

  static const String route = '/winning';

  const WinningPage({Key? key}) : super(key: key);

  @override
  State<WinningPage> createState() => _WinningPageState();
}

class _WinningPageState extends State<WinningPage> with SingleTickerProviderStateMixin {

  late AnimationController btnsCtrl;

  late GameService gameService;
  late AudioService audioService;

  @override
  void initState() {
    super.initState();

    gameService = Provider.of<GameService>(context, listen: false);
    audioService = Provider.of<AudioService>(context, listen: false);

    audioService.playSound(SkippingFrogSounds.winning);
    
    btnsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    )..forward();
  }

  @override
  void dispose() {
    btnsCtrl.dispose();

    audioService.stopAllSounds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ScoreConfig scoreConfig = gameService.getScoreConfig();
    gameService.saveScoreData();
    
    List<Widget> scoreConfigPanelItems = [
      Column(
        children: [
          const Text('Your Score'),
          Text('${scoreConfig.score}', style: const TextStyle(fontSize: 35))
        ],
      ),
      Column(
        children: [
          const Text('Your Time'),
          Text(scoreConfig.timeAsString, style: const TextStyle(fontSize: 35))
        ],
      )
    ];

    List<SkippingFrogButton> buttons = [
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_win_yes_on',
        off: 'btn_win_yes_off',
        onTap: () {
          gameService.resetGame();
          Utils.mainNav.currentState!.pushReplacementNamed(GamePage.route);
        }
      ),
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_win_no_on',
        off: 'btn_win_no_off',
        onTap: () {
          gameService.resetGame();
          Utils.mainNav.currentState!.popUntil((route) => route.settings.name == SkippingFrogLanding.route);
        }
      ),
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_win_submit_on',
        off: 'btn_win_submit_off',
        onTap: () {
          gameService.resetGame();
          Utils.mainNav.currentState!.pushReplacementNamed(LeaderboardsPage.route);
        }
      )
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/imgs/main_bg.png',
                fit: BoxFit.cover
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(scoreConfigPanelItems.length, (index) {
                        
                        var interval = 1 / scoreConfigPanelItems.length;
                
                        return FadeTransition(
                           opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                              parent: btnsCtrl,
                              curve: Interval(index * interval, (index + 1) * interval, curve: Curves.easeInOut))),
                            child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, -1.0), end: Offset.zero
                            ).animate(CurvedAnimation(
                              parent: btnsCtrl, 
                              curve: Interval(index * interval, (index + 1) * interval, curve: Curves.easeInOut))),
                            child: scoreConfigPanelItems[index]),
                        );
                      })
                    ),
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, -0.25), end: Offset.zero
                        ).animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                        child: Image.asset('assets/imgs/playagain_win.png',
                          width: 250,
                          height: 180
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.9, end: 1.0)
                        .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                        child: Image.asset('assets/imgs/frog_win.png',
                          width: 380,
                          height: 360
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(buttons.length, (index) {
                        
                        var interval = 1 / buttons.length;
                
                        return FadeTransition(
                           opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                              parent: btnsCtrl,
                              curve: Interval(index * interval, (index + 1) * interval, curve: Curves.easeInOut))),
                            child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 1.0), end: Offset.zero
                            ).animate(CurvedAnimation(
                              parent: btnsCtrl, 
                              curve: Interval(index * interval, (index + 1) * interval, curve: Curves.easeInOut))),
                            child: buttons[index]),
                        );
                      })
                    )
                  ],
                )
              ),
            ),
            
          ],
        )
      ),
    );
  }
}