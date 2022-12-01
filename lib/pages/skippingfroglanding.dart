import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/helppage.dart';
import 'package:skippingfrog_mobile/pages/optionspage.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class SkippingFrogLanding extends StatefulWidget {

  static const String route = '/landing';

  const SkippingFrogLanding({Key? key}) : super(key: key);

  @override
  State<SkippingFrogLanding> createState() => _SkippingFrogLandingState();
}

class _SkippingFrogLandingState extends State<SkippingFrogLanding> with SingleTickerProviderStateMixin {

  late AnimationController btnsCtrl;

  @override
  void initState() {
    super.initState();

    btnsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000)
    )..forward();
  }

  @override
  void dispose() {
    btnsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AudioService audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playSound(SkippingFrogSounds.ribbit);

    List<SkippingFrogButton> buttons = [
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_help_on',
        off: 'btn_help_off',
        onTap: () {
          Utils.mainNav.currentState!.pushNamed(HelpPage.route);
        }
      ),
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_start_on',
        off: 'btn_start_off',
        onTap: () {
          Utils.mainNav.currentState!.pushNamed(GamePage.route);
        }
      ),
      SkippingFrogButton(
        width: 120,
        height: 120,
        on: 'btn_options_on',
        off: 'btn_options_off',
        onTap: () {
          Utils.mainNav.currentState!.pushNamed(OptionsPage.route);
        }
      )
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/imgs/main_bg.png',
              fit: BoxFit.cover
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
                    child: Image.asset('assets/imgs/skippingfrog_logo.png',
                      width: 300,
                      height: 230
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
    );
  }
}