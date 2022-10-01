import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';

class FrogMessagesService extends ChangeNotifier {

  String message = '';
  bool hideItself = true;
  FrogMessages messageType = FrogMessages.none;

  void setMessage(FrogMessages msg, { String msgContent = '', bool hide = true}) {
    hideItself = hide;

    Timer(const Duration(milliseconds: 50), () {
      messageType = msg;
      notifyListeners();
    });

    message = msgContent;
    messageType = FrogMessages.none;
    notifyListeners();
  }

  void setMessageAndKeepVisible(FrogMessages msg, { String msgContent = ''}) {
    setMessage(msg, msgContent: msgContent, hide: false);
  }
}