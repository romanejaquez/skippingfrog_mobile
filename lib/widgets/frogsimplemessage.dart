import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/frogmessages.dart';
import 'package:skippingfrog_mobile/services/frogmessageservice.dart';

class FrogSimpleMessage extends StatefulWidget {

  final String msg;
  const FrogSimpleMessage({super.key, required this.msg});

  @override
  State<FrogSimpleMessage> createState() => _FrogSimpleMessageState();
}

class _FrogSimpleMessageState extends State<FrogSimpleMessage> {

  late Timer msgTimer = Timer(Duration.zero, () {});

  @override
  void initState() {
    super.initState();

    msgTimer = Timer(const Duration(milliseconds: 1500), () {
      Provider.of<FrogMessagesService>(context, listen: false).setMessage(FrogMessages.none);
    });
  }

  @override
  void dispose() {
    msgTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.only(left: 100),
              padding: const EdgeInsets.only(
                left: 40,
                right: 20,
                bottom: 20,
                top: 20
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              child: Text(widget.msg,
                  style: TextStyle(color: Colors.white,
                    fontSize: 20
                  )
                ),
              )
            ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 200),
              child: Image.asset(
                'assets/imgs/achieve_badge.png',
                width: 150,
                height: 150
              ),
            ),
          ),
        ],
      ),
    );
  }
}