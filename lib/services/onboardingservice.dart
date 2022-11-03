import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep1.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep2.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/steps/onboardingstep3.dart';

class OnboardingService extends ChangeNotifier {

  int _pageIndex = 0;

  List<Widget> onboardingSteps = const [
    OnboardingStep1(),
    OnboardingStep2(),
    OnboardingStep3(),
  ];

  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}