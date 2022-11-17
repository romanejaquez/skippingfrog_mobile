import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/sign_in_icons.dart';

class LoginOptionsPanel extends StatelessWidget {

  final Function onSignIn;
  const LoginOptionsPanel({ super.key, required this.onSignIn }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      padding: const EdgeInsets.only(
        top: 30, left: 30, right: 30, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('SIGN IN OPTIONS',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Visibility(
            visible: Platform.isIOS,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))
                ),
                onPressed: () {
                  onSignIn(SkippingFrogSignInOptions.signInWithApple);
                }, 
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(SignInIcons.apple),
                      SizedBox(width: 20),
                      Text(
                        'SIGN IN WITH APPLE',
                        style: TextStyle(fontSize: 20)
                      )
                    ],
                  ),
                )
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              elevation: 0,
              backgroundColor: AppColors.burnedYellow,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))
            ),
            onPressed: () {
              onSignIn(SkippingFrogSignInOptions.signInWithGoogle);
            }, 
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(SignInIcons.google),
                  SizedBox(width: 20),
                  Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(fontSize: 20)
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}