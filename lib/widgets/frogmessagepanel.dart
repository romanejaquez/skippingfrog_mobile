import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/widgets/frogsimplemessage.dart';
import 'package:skippingfrog_mobile/widgets/frogsplashmessage.dart';

class FrogMessagePanel extends StatelessWidget {
  const FrogMessagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FrogMessagesService>(
      builder: (context, fmService, child) {

        Widget? msg;

        switch(fmService.messageType) {
          case FrogMessages.simple:
            msg = const FrogSimpleMessage();
            break;
          case FrogMessages.splash:
            msg = const FrogSplashMessage();
            break;
          case FrogMessages.none:
          default: 
            msg = const SizedBox();
            break;
        }

        return msg;  
      }
    );
  }
}