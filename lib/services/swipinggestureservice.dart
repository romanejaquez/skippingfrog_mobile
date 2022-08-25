import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/swipedirection.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

class SwipingGestureService extends ChangeNotifier {

  SwipeDirection direction = SwipeDirection.none;
  ScrollController? swipeController;
  int count = 1;

  void setSwipingController(ScrollController ctrl) {
    swipeController = ctrl;
  }

  void onSwipe(SwipeDirection d, BuildContext context) {
    direction = d;
    GameService gameService = Provider.of<GameService>(context, listen: false);

    swipeController!.animateTo(gameService.leafDimension * count, 
      duration: const Duration(milliseconds: 750), 
      curve: Curves.easeOut).then((value) {
        direction = SwipeDirection.none;
        notifyListeners();
      });

    count++;
    notifyListeners();
  }
}