import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/pages/gamepage.dart';
import 'package:skippingfrog_mobile/pages/helppage.dart';
import 'package:skippingfrog_mobile/pages/optionspage.dart';
import 'package:skippingfrog_mobile/widgets/skippingfrogbutton.dart';

class SkippingFrogLanding extends StatelessWidget {

  static String route = '/landing';

  const SkippingFrogLanding({Key? key}) : super(key: key);

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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/imgs/skippingfrog_logo.png',
                  width: 300,
                  height: 250
                ),
                Image.asset('assets/imgs/frog_win.png',
                  width: 380,
                  height: 380
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkippingFrogButton(
                      width: 120,
                      height: 120,
                      on: 'btn_help_on',
                      off: 'btn_help_off',
                      onTap: () {
                        Navigator.of(context).pushNamed(HelpPage.route);
                      }
                    ),
                    SkippingFrogButton(
                      width: 120,
                      height: 120,
                      on: 'btn_start_on',
                      off: 'btn_start_off',
                      onTap: () {
                        Navigator.of(context).pushNamed(GamePage.route);
                      }
                    ),
                    SkippingFrogButton(
                      width: 120,
                      height: 120,
                      on: 'btn_options_on',
                      off: 'btn_options_off',
                      onTap: () {
                        Navigator.of(context).pushNamed(OptionsPage.route);
                      }
                    )
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}