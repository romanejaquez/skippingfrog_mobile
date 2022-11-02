import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/onboardingservice.dart';

class OnboardingButtonsPanel extends StatelessWidget {
  const OnboardingButtonsPanel({super.key});

  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);

    return Consumer<OnboardingService>(
      builder: (context, onboarding, child) {
        return Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Utils.mainNav.currentState!.pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(onboarding.pageIndex == onboarding.onboardingSteps.length - 1 ? 'LET\'S PLAY!' : 'SKIP AND START',
                    style: const TextStyle(fontSize: 30)),
                )
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Utils.mainNav.currentState!.pop();
                  gameService.neverShowOnboardingAgain();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('NEVER SHOW THIS AGAIN', style: TextStyle(fontSize: 20)),
                )
              )
          ],
        );
      },
    );
  }
}