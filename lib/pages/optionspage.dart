import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class OptionsPage extends StatelessWidget {

  static String route = '/options';

  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/imgs/main_bg.png',
              fit: BoxFit.fitHeight
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
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Image.asset('assets/imgs/difficulty_panel.png',
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 120),
                              child: Consumer<DifficultyService>(
                                builder: (context, difficultyService, child) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SkippingFrogButton(
                                        toggle: difficultyService.difficulty == Difficulty.easy,
                                        width: 180,
                                        height: 100,
                                        on: 'btn_easy_on',
                                        off: 'btn_easy_off',
                                        onTap: () {
                                          difficultyService.setGameDifficulty(Difficulty.easy);
                                        }
                                      ),
                                      SkippingFrogButton(
                                        toggle: difficultyService.difficulty == Difficulty.hard,
                                        width: 180,
                                        height: 100,
                                        on: 'btn_hard_on',
                                        off: 'btn_hard_off',
                                        onTap: () {
                                          difficultyService.setGameDifficulty(Difficulty.hard);
                                        }
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          )
                        ],
                      ),
                      SkippingFrogButton(
                        width: 350,
                        height: 100,
                        on: 'btn_viewlb_on',
                        off: 'btn_viewlb_off',
                        onTap: () {
                          Navigator.of(context).pushNamed(LeaderboardsPage.route);
                        }
                      )
                    ]
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
                        Navigator.of(context).pop();
                      }
                    ),
                  ],
                ),
              ],
            )
          )
        ]
      )
    );
  }
}