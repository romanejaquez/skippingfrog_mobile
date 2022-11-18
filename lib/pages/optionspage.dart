import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/optionsservice.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class OptionsPage extends StatelessWidget {

  static String route = '/options';

  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var audioService = Provider.of<AudioService>(context, listen: false);
    var gameService = Provider.of<GameService>(context, listen: false);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/imgs/options_title.png',
                    width: 150,
                    height: 80,
                  ),
                  Expanded(
                    child: Consumer<OptionsService>(
                      builder: (context, optionsService, child) {
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      audioService.playSound(
                                        SkippingFrogSounds.ribbit, 
                                        waitForSoundToFinish: true
                                      );
                                      optionsService.toggleMute();
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(optionsService.muteAllSoundsSelected ? Icons.toggle_on_outlined : Icons.toggle_off_outlined, color: Colors.white, size: 50),
                                        const SizedBox(width: 10),
                                        const Text('Mute All Sounds', style: TextStyle(color: Colors.white, fontSize: 20))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      audioService.playSound(
                                        SkippingFrogSounds.ribbit, 
                                        waitForSoundToFinish: true
                                      );
    
                                      Utils.showModalAlertDialog(
                                        title: 'Clear All Game Data',
                                        message: 'All Game Data stored locally will be wiped out. Are you sure about this?',
                                        options: [AlertOptions.yes, AlertOptions.no],
                                        onSelectedAlertOption: (AlertOptions selectedOption) async {
    
                                          // clear all game data if the user said 'yes'
                                          if (selectedOption == AlertOptions.yes) {
                                            await gameService.clearAllGameData();
                                          }
                                        }
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.delete_forever, color: Colors.white, size: 40),
                                        SizedBox(width: 10),
                                        Text('Clear all Game Data', style: TextStyle(color: Colors.white, fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            SkippingFrogButton(
                              width: 350,
                              height: 100,
                              on: 'btn_viewlb_on',
                              off: 'btn_viewlb_off',
                              onTap: () {
                                optionsService.navigateToLeaderboards();
                              }
                            )
                          ]
                        );
                      }
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SkippingFrogButton(
                        width: 180,
                        height: 100,
                        on: 'btn_back_on',
                        off: 'btn_back_off',
                        onTap: () {
                          Utils.mainNav.currentState!.pop();
                        }
                      ),
                    ],
                  ),
                ],
              )
            )
          ]
        )
      ),
    );
  }
}