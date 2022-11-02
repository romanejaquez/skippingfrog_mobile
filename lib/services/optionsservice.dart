import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/pages/leaderboardspage.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

class OptionsService extends ChangeNotifier {

  bool _muteAllSoundsSelected = false;
  late BuildContext? ctx;

  bool get muteAllSoundsSelected {
    if (ctx != null) {
      GameService gameService = Provider.of<GameService>(ctx!, listen: false);
      _muteAllSoundsSelected = gameService.areAllSoundsMute();
      return _muteAllSoundsSelected;
    }

    return false;
  }
  

  void init(BuildContext context) {
    ctx = context;
    GameService gameService = Provider.of<GameService>(ctx!, listen: false);
    _muteAllSoundsSelected = gameService.areAllSoundsMute();
  }

  void toggleMute() {
    GameService gameService = Provider.of<GameService>(ctx!, listen: false);
    muteAllSoundsSelected != muteAllSoundsSelected;
    gameService.toggleMuteSounds(muteAllSoundsSelected);
    notifyListeners();
  }

  void clearAllGameData() {

  }

  void navigateToLeaderboards() {
    Utils.mainNav.currentState!.pushNamed(LeaderboardsPage.route);
  }
}