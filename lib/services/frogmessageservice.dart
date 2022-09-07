import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';

class FrogMessagesService extends ChangeNotifier {

  String message = '';
  FrogMessages messageType = FrogMessages.none;

  void setMessage(FrogMessages msg, { String msgContent = ''}) {

    Timer(const Duration(milliseconds: 50), () {
      messageType = msg;
      notifyListeners();
    });

    message = msgContent;
    messageType = FrogMessages.none;
    notifyListeners();
  }
}