import 'package:flutter/material.dart';

class LeafService extends ChangeNotifier {

  int currentLeafIndex = 0;
  int currentRowIndex = 0;

  void notifyCurrentLeafOnRow(int leafIndex, int rowIndex) {
    currentRowIndex = rowIndex;
    currentLeafIndex = leafIndex;
    notifyListeners();
  }
}