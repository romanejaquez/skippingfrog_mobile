import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/skippingfroglanding.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class LosingPage extends StatefulWidget {

  static String route = '/losing';

  const LosingPage({Key? key}) : super(key: key);

  @override
  State<LosingPage> createState() => _LosingPageState();
}

class _LosingPageState extends State<LosingPage> with SingleTickerProviderStateMixin {

  late AnimationController btnsCtrl;

  late GameService gameService;
  late AudioService audioService;
  @override
  void initState() {
    super.initState();

    gameService = Provider.of<GameService>(context, listen: false);
    audioService = Provider.of<AudioService>(context, listen: false);

    audioService.playSound(SkippingFrogSounds.loser);
    
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

    List<SkippingFrogButton> buttons = [
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_lose_yes_on',
        off: 'btn_lose_yes_off',
        onTap: () {
          gameService.resetGame();
          Utils.mainNav.currentState!.pushReplacementNamed(GamePage.route);
        }
      ),
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_lose_no_on',
        off: 'btn_lose_no_off',
        onTap: () {
          gameService.resetGame();
          Utils.mainNav.currentState!.popUntil((route) => route.settings.name == SkippingFrogLanding.route);
        }
      )
    ];

    return WillPopScope(
      onWillPop: () async {
        audioService.stopAllSounds();
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/imgs/lose_bg.png',
                fit: BoxFit.fitHeight
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, -0.25), end: Offset.zero
                      ).animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                      child: Image.asset('assets/imgs/playagain_lose.png',
                        width: 300,
                        height: 250
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.9, end: 1.0)
                      .animate(CurvedAnimation(parent: btnsCtrl, curve: Curves.easeInOut)),
                      child: Image.asset('assets/imgs/frog_lose.png',
                        width: 380,
                        height: 380
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
            )
          ],
        )
      ),
    );
  }
}