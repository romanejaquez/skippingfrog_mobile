import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';
import 'package:skippingfrog_mobile/widgets/frogsimplemessage.dart';
import 'package:skippingfrog_mobile/widgets/frogsplashmessage.dart';

class FrogMessagePanel extends StatefulWidget {
  const FrogMessagePanel({super.key});

  @override
  State<FrogMessagePanel> createState() => _FrogMessagePanelState();
}

class _FrogMessagePanelState extends State<FrogMessagePanel> with SingleTickerProviderStateMixin {

  late AnimationController msgCtrl;

  @override 
  void initState() {
    super.initState();

    msgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );
  }

  @override
  void dispose() {
    msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FrogMessagesService>(
      builder: (context, fmService, child) {

        Widget? msg;

        switch(fmService.messageType) {
          case FrogMessages.simple:
            msg = FrogSimpleMessage(msg: fmService.message);
            break;
          case FrogMessages.splash:
            msg = const FrogSplashMessage();
            break;
          case FrogMessages.none:
          default: 
            msg = const SizedBox();
            break;
        }
        
        msgCtrl.reset();
        msgCtrl.forward();

        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: msgCtrl, curve: Curves.bounceOut)),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: msgCtrl, curve: Curves.bounceOut)),
            child: msg),
        );  
      }
    );
  }
}