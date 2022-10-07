import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep1.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep2.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep3.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {

  PageController? controller;

  @override 
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    GameService gameService = Provider.of<GameService>(context, listen: false);
    ValueNotifier<int> pageIndex = ValueNotifier(0);
    List<Widget> onboardingSteps = const [
      OnboardingStep1(),
      OnboardingStep2(),
      OnboardingStep3(),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
      padding: const EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 350,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              onPageChanged: ((value) {
                pageIndex.value = value;
              }),
              children: onboardingSteps
            ),
          ),
          ValueListenableBuilder<int>(
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                IconButton(
                  onPressed: value > 0 ? () {
                    controller!.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  } : null, 
                  icon: Icon(
                    Icons.chevron_left, 
                    size: 30,
                    color: value > 0 ? Colors.white : Colors.white.withOpacity(0.2)
                  )
                ),
                ...List.generate(
                  onboardingSteps.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipOval(
                        child: Container(
                          color: pageIndex.value == index ? Colors.white : Colors.white.withOpacity(0.2),
                          width: 15, height: 15,
                        ),
                      ),
                    );
                  }
                ),
                IconButton(
                  onPressed: value < onboardingSteps.length - 1 ? () {
                    controller!.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  } : null, 
                  icon: Icon(
                    Icons.chevron_right, 
                    size: 30,
                    color: value < onboardingSteps.length - 1 ? Colors.white : Colors.white.withOpacity(0.2)
                  )
                ),
                ]
              );
            }, valueListenable: pageIndex,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              Utils.mainNav.currentState!.pop();
            },
            child: ValueListenableBuilder(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(pageIndex.value == onboardingSteps.length - 1 ? 'LET\'S PLAY!' : 'SKIP AND START',
                    style: const TextStyle(fontSize: 30)),
                );
              },
              valueListenable: pageIndex,
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('NEVER SHOW THIS AGAIN', style: TextStyle(fontSize: 20)),
            )
          )
        ],
      ),
    );
  }
}