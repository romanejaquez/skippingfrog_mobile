import 'package:skippingfrog_mobile/helpers/leafdirection.dart';

class LeafModel {
  final int index;
  final bool containsBug;
  final bool isCheckpoint;
  final LeafDirection direction;
  final int checkpointValue;

  LeafModel({
    required this.index,
    required this.containsBug,
    required this.isCheckpoint,
    required this.direction,
    required this.checkpointValue
  });
}