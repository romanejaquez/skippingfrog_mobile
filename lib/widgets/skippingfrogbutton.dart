import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';

class SkippingFrogButton extends StatefulWidget {
  final String on;
  final String off;
  final Function onTap;
  final double width;
  final double height;
  final bool? toggle;

  const SkippingFrogButton({
    required this.on,
    required this.off,
    required this.onTap,
    required this.width,
    required this.height,
    this.toggle,
    Key? key}) : super(key: key);

  @override
  State<SkippingFrogButton> createState() => _SkippingFrogButtonState();
}

class _SkippingFrogButtonState extends State<SkippingFrogButton> {
  
  bool isPressed = false;
  
  @override
  Widget build(BuildContext context) {

    AudioService audioService = Provider.of<AudioService>(context, listen: false);
    if (widget.toggle != null) {
      setState(() {
        isPressed = widget.toggle!;
      });
    }

    return GestureDetector(
      onTap: () async {
        await audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);
        widget.onTap();
      },
      onTapDown: (details) {
          if (widget.toggle == null) {
            setState(() {
              isPressed = true;
            });
          }
      },
      onTapUp: (details) {
          if (widget.toggle == null) {
            setState(() {
              isPressed = false;
            });
          }
      },
      onTapCancel: () {
          setState(() {
            isPressed = false;
          });
      },
      child: Stack(
        children: [
          Opacity(
            opacity: isPressed ? 1 : 0,
            child: Image.asset('assets/imgs/${widget.on}.png',
              width: widget.width,
              height: widget.height,
            )),
          Opacity(
            opacity: isPressed ? 0 : 1,
            child: Image.asset('assets/imgs/${widget.off}.png',
              width: widget.width,
              height: widget.height,
            )),
        ],
      ),
    );
  }
}