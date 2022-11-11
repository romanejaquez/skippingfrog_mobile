import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/services/audioservice.dart';

class BasicAlert extends StatelessWidget {

  final List<AlertOptions> options;
  final String title;
  final String message;
  final Function onSelectedOption;

  BasicAlert({
    super.key,
    required this.options,
    required this.title,
    required this.message,
    required this.onSelectedOption
  });

  final ButtonStyle yesBtnStyle = TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: AppColors.burnedYellow,
                          foregroundColor: Colors.white
                        );

  final ButtonStyle noBtnStyle = TextButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: AppColors.burnedYellow.withOpacity(0.2),
                          foregroundColor: Colors.black
                        );

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: const EdgeInsets.only(
              top: 30, left: 30, right: 30, bottom: 30),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                  style: const TextStyle(color: AppColors.burnedYellow, fontSize: 25)
                ),
                const SizedBox(height: 10),
                Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25)
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buttonFromOptions(options, context),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  void onButtonTriggered(AlertOptions option, BuildContext context) {
    var audioService = Provider.of<AudioService>(context, listen: false);
    audioService.playSound(SkippingFrogSounds.ribbit, waitForSoundToFinish: true);
    Utils.mainNav.currentState!.pop();
    onSelectedOption(option);
  }

  List<Widget> buttonFromOptions(List<AlertOptions> options, BuildContext context) {
    List<Widget> buttons = [];

    for(var o in options) {
      Widget? optionBtn;

      switch(o) {
        case AlertOptions.yes:
        case AlertOptions.ok:
          optionBtn = Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: TextButton(
                style: yesBtnStyle,
                onPressed: () {
                  onButtonTriggered(o, context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(o.name,
                    style: const TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ),
          );
        break;
        case AlertOptions.no:
        case AlertOptions.cancel:
          optionBtn = Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: TextButton(
                style: noBtnStyle,
                onPressed: () {
                  onButtonTriggered(o, context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(o.name,
                    style: const TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ),
          );
        break;
        
      }

      buttons.add(optionBtn!);
    }

    return buttons;
  }
}