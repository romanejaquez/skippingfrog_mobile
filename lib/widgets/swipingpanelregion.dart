import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';

class SwipingPanelRegion extends StatelessWidget {
  const SwipingPanelRegion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SwipingGestureService swipingGestureService = Provider.of<SwipingGestureService>(context, listen: true);
    
    return GestureDetector(
      onVerticalDragEnd: (DragEndDetails details) {
        // up
        if (details.primaryVelocity! < 0) {
          swipingGestureService.onSwipe(SwipeDirection.up);
          log('up');
        }
        // down
        else if (details.primaryVelocity! > 0) {
          swipingGestureService.onSwipe(SwipeDirection.down);
          log('down');
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        // left
        if (details.primaryVelocity! < 0) {
          swipingGestureService.onSwipe(SwipeDirection.left);
          log('left');
        }
        // right
        else if (details.primaryVelocity! > 0) {
          swipingGestureService.onSwipe(SwipeDirection.right);
          log('right');
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 160, bottom: 160),
        color: Colors.transparent
      ),
    );
  }
}