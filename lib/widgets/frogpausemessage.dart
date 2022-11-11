import 'package:flutter/material.dart';

class FrogPauseMessage extends StatelessWidget {
  const FrogPauseMessage({super.key});

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
              child: const Text('GAME PAUSED',
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