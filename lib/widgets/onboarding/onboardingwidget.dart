import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/onboardingservice.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/onboardingbuttonspanel.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep1.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep2.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep3.dart';

class OnboardingWidget extends StatefulWidget {
  final bool showButtonPanel;
  const OnboardingWidget({
    super.key,
    this.showButtonPanel = true
  });

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {

  PageController? controller;

  @override 
  void initState() {
    super.initState();

    var onboardingService = Provider.of<OnboardingService>(context, listen: false);
    controller = PageController(initialPage: onboardingService.pageIndex);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(50)
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<OnboardingService>(
            builder: (context, onboarding, child) {
              
              return Column(
                children: [
                  SizedBox(
                    height: 350,
                    width: 300,
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      onPageChanged: ((value) {
                        onboarding.pageIndex = value;
                      }),
                      children: onboarding.onboardingSteps
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    IconButton(
                      onPressed: onboarding.pageIndex > 0 ? () {
                        controller!.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      } : null, 
                      icon: Icon(
                        Icons.chevron_left, 
                        size: 30,
                        color:  onboarding.pageIndex > 0 ? Colors.white : Colors.white.withOpacity(0.2)
                      )
                    ),
                    ...List.generate(
                      onboarding.onboardingSteps.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: ClipOval(
                            child: Container(
                              color: onboarding.pageIndex == index ? Colors.white : Colors.white.withOpacity(0.2),
                              width: 15, height: 15,
                            ),
                          ),
                        );
                      }
                    ),
                    IconButton(
                      onPressed: onboarding.pageIndex < onboarding.onboardingSteps.length - 1 ? () {
                        controller!.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      } : null, 
                      icon: Icon(
                        Icons.chevron_right, 
                        size: 30,
                        color:  onboarding.pageIndex < onboarding.onboardingSteps.length - 1 ? Colors.white : Colors.white.withOpacity(0.2)
                      )
                    ),
                    ]
                  ),
                ],
              );
            }
          ),
          const SizedBox(height: 20),
          widget.showButtonPanel ? const OnboardingButtonsPanel()
            : const SizedBox.shrink()
        ],
      ),
    );
  }
}