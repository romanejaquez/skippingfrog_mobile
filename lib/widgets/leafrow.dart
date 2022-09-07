import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/widgets/leaf.dart';

class LeafRow extends StatelessWidget {
  
  final int rowIndex;
  const LeafRow({ Key? key, required this.rowIndex }) : super(key: key);

  @override
  Widget build(BuildContext context){

    GameService gameService = Provider.of<GameService>(context, listen: false);
    
    List<Widget> leafRows = [];

    for(var r = 0; r < gameService.leavesAcrossThePond; r++) {
      LeafModel leafModel = gameService.leaves[rowIndex];

      leafRows.add(
        Leaf(
          leafIndex: r,
          leaf: leafModel, 
          rowIndex: rowIndex,
          leafSize: gameService.leafDimension
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: leafRows,
    );
  }
}