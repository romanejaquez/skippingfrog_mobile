
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/swipinggestureservice.dart';
import 'package:skippingfrog_mobile/widgets/leafrow.dart';

class LillyPond extends StatefulWidget {
  const LillyPond({Key? key}) : super(key: key);

  @override
  State<LillyPond> createState() => _LillyPondState();
}

class _LillyPondState extends State<LillyPond> {
  final lillyPondScrollController = ScrollController();
  late GameService gameService;
  late SwipingGestureService swipingGestureService;

  @override
  void initState() {
    super.initState();

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

    return Center(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: lillyPondScrollController,
        reverse: true,
        padding: const EdgeInsets.only(bottom: 160),
        itemCount: gameService.leaves.length,
        itemBuilder: (context, index) {
          return LeafRow(rowIndex: index);
        })
    );
  }
}