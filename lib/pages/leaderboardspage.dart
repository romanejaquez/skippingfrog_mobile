import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/widgets/leaderboardscorepanel.dart';
import 'package:skippingfrog_mobile/widgets/leaderboardspanel.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class LeaderboardsPage extends StatelessWidget {

  static const String route = '/leaderboard';

  const LeaderboardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 10, right: 40),
                    child: Image.asset('assets/imgs/leaderboards_title.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          LeaderboardScorePanel(),
                          SizedBox(height: 10),
                          LeaderboardsPanel()
                        ],
                      ),
                    ),
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
                ]
              )
            )
          ]
        )
      ),
    );
  }
}