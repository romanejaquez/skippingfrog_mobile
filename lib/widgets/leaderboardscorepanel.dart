import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/leaderboardservice.dart';
import 'package:skippingfrog_mobile/services/loginservice.dart';
import 'package:skippingfrog_mobile/widgets/loginoptionspanel.dart';

class LeaderboardScorePanel extends StatelessWidget {
  const LeaderboardScorePanel({super.key});

  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);
    ScoreConfig score = gameService.getScoreData();

    LeaderboardService leaderboardService = Provider.of<LeaderboardService>(context, listen: true);
    
    return Consumer<LoginService>(
      builder: (context, loginService, child) {
        
        return Column(
          children: [
            loginService.isUserLoggedIn() ? 
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 5,
                  strokeAlign: StrokeAlign.outside
                ),
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(loginService.loggedInUserModel!.photoUrl!)
                )
              ),
            ) : Container(
                width: 50, height: 50, alignment: Alignment.center,
                child: const Icon(Icons.account_circle, color: Colors.black, size: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Latest score',
                      style: TextStyle(fontSize: 20)
                    ),
                    Text('${score.score}', style: const TextStyle(fontSize: 30))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Latest Time', style: TextStyle(fontSize: 20)),
                    Text(score.timeAsString, style: const TextStyle(fontSize: 30))
                  ],
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))
                    ),
                    onPressed: leaderboardService.canSubmitScore(context, score) ? 
                    () {
                      leaderboardService.submitScore(score, context);
                    } : null, 
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('SUBMIT SCORE', style: TextStyle(fontSize: 15)),
                    )
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))
                    ),
                    onPressed: () async {
                      if (!loginService.isUserLoggedIn()) {

                        Utils.showLoginBottomSheet(
                          context,
                          LoginOptionsPanel(
                            onSignIn: (SkippingFrogSignInOptions option) async {
                              Utils.mainNav.currentState!.pop();

                              switch(option) {
                                case SkippingFrogSignInOptions.signInWithGoogle:
                                  await loginService.signInWithGoogle();
                                  leaderboardService.reload();
                                  break;
                                case SkippingFrogSignInOptions.signInWithApple:
                                  await loginService.signInWithApple();
                                  leaderboardService.reload();
                                  break;
                              }
                            }
                          )  
                        );
                      }
                      else {
                        await loginService.signOut(() {});
                        leaderboardService.reload();
                      }
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        loginService.isUserLoggedIn() ? 'SIGN OUT' : 'SIGN IN',
                        style: const TextStyle(fontSize: 15)
                      ),
                    )
                  ),
                )
              ],
            )
          ],
        );
      }
    );
  }
}