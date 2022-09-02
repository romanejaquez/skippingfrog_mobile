import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
import 'package:skippingfrog_mobile/services/leafservice.dart';

class Leaf extends StatelessWidget {
  final LeafModel leaf;
  final int rowIndex;
  final int leafIndex;
  final double leafSize;
  const Leaf({ Key? key, required this.leafIndex, required this.leafSize, required this.leaf, required this.rowIndex }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Consumer<LeafService>(
      builder: (context, leafService, child) {
        
        bool hideBugOnLeaf = leafService.currentRowIndex >= rowIndex;

        return leaf.index == leafIndex ?
          SizedBox(
            width: leafSize,
            height: leafSize,
            child: Stack(
              children: [
                Image.asset('assets/imgs/leaf_${leaf.direction.name}.png',
                  width: leafSize,
                  height: leafSize
                ),
                leaf.containsBug && !hideBugOnLeaf ?
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/imgs/bug.png',
                        width: leafSize / 2,
                        height: leafSize / 2
                      ),
                      const Text('100', style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        )
                      ),
                      const SizedBox(height: 25)
                    ],
                  ),
                ) : const SizedBox()
              ],
            ),
          ) :
          leaf.isBreakpoint ? Image.asset('assets/imgs/lilly.png',
            width: leafSize,
            height: leafSize
          ) :
          SizedBox(
            width: leafSize, height: leafSize
          );
      }
    );
  }
}