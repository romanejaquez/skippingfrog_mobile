
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/pondservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';
import 'package:skippingfrog_mobile/widgets/leafrow.dart';

class LillyPond extends StatefulWidget {
  const LillyPond({Key? key}) : super(key: key);

  @override
  State<LillyPond> createState() => _LillyPondState();
}

class _LillyPondState extends State<LillyPond> with SingleTickerProviderStateMixin {

  final lillyPondScrollController = ScrollController();
  late GameService gameService;
  late SwipingGestureService swipingGestureService;
  late AnimationController lillyPondController;

  @override
  void initState() {
    super.initState();

    lillyPondController = AnimationController(
      vsync: this, duration: Utils.slidingDuration, 
    );

    gameService = Provider.of<GameService>(context, listen: false);
    swipingGestureService = Provider.of<SwipingGestureService>(context, listen: false);
    swipingGestureService.setSwipingController(lillyPondScrollController);
  }

  @override 
  void dispose() {
    lillyPondScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Consumer<PondService>(
          builder: (context, pondService, child) {

            lillyPondController.reset();
            lillyPondController.forward();

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, pondService.startPondValue),
                end: Offset(0.0, pondService.endPondValue),
              ).animate(
                CurvedAnimation(parent: lillyPondController, curve: Curves.easeOut)
              ),
              child: Image.asset('./assets/imgs/field.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
        Center(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: lillyPondScrollController,
            reverse: true,
            padding: EdgeInsets.only(
              top: (gameService.leafDimension * 20).toDouble(),
              bottom: 160),
            itemCount: gameService.leaves.length,
            itemBuilder: (context, index) {

              return  LeafRow(rowIndex: index);

            })
        ),
      ],
    );
  }
}