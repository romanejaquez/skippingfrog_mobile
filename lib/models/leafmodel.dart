import 'package:skippingfrog_mobile/helpers/leafdirection.dart';

class LeafModel {
  final int index;
  final bool containsBug;
  final bool isBreakpoint;
  final LeafDirection direction;

  LeafModel({
    required this.index,
    required this.containsBug,
    required this.isBreakpoint,
    required this.direction
  });
}