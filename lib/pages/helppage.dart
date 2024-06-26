import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/widgets/onboarding/onboardingwidget.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class HelpPage extends StatelessWidget {

  static const String route = '/help';
  
  const HelpPage({Key? key}) : super(key: key);

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
                  SizedBox(
                    width: 150,
                    child: Image.asset('assets/imgs/help_title.png',
                      width: 150,
                      height: 100,
                      fit: BoxFit.contain
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: OnboardingWidget(showButtonPanel: false),
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