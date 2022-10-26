import 'package:flutter/material.dart';
import 'package:skippingfrog_mobile/helpers/skipping_frog_font_icons.dart';

class LeaderboardLoading extends StatelessWidget {
  const LeaderboardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 80, height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation(Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(SkippingFrogFont.frog, size: 30, color: Colors.black))
          )
        ],
      ),
    );
  }
}