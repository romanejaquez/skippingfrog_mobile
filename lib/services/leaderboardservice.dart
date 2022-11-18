import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/playermodel.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';
import 'package:skippingfrog_mobile/services/gamelocalstorage.dart';
import 'package:skippingfrog_mobile/services/loginservice.dart';

class LeaderboardService extends ChangeNotifier {

  bool isScoreSubmitted = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<PlayerModel> cachedPlayers = [];

  Future<List<PlayerModel>> getPlayers() {
    Completer<List<PlayerModel>> playersCompleter = Completer();

    if (cachedPlayers.isEmpty) {
      firestore.collection('leaderboard').orderBy('timeInSeconds')
      //.orderBy('score', descending: true)
      .get().then((playerDocs) {

        List<PlayerModel> playersList = playerDocs.docs.map((p) => 
          PlayerModel.fromJson(p.data(), p.id)).toList();

        cachedPlayers.addAll(playersList);

        Future.delayed(const Duration(milliseconds: 500), () {
          playersCompleter.complete(playersList);
        });
      });
    }
    else {
      playersCompleter.complete(cachedPlayers);
    }

    return playersCompleter.future;
  }

  // check if the user can submit score
  bool canSubmitScore(BuildContext context, ScoreConfig scoreConfig) {
    LoginService loginService = Provider.of<LoginService>(context, listen: false);

    return loginService.isUserLoggedIn() && scoreConfig.score > 0;
  }

  // submit the user score
  Future<void> submitScore(ScoreConfig config, BuildContext context) async {
    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    GameLocalStorage localStorage = Provider.of<GameLocalStorage>(context, listen: false);

    var userId = loginService.loggedInUserModel!.uid!;
    var playerName = loginService.loggedInUserModel!.email!;

    firestore.collection('leaderboard').doc(userId).set({
      'name': playerName,
      'score': config.score,
      'timeInSeconds': config.time.inSeconds
    }).then((value) {
      localStorage.storePlayerName(playerName);
      cachedPlayers.clear();
      notifyListeners();
    },
    onError: (error) {
      Utils.showModalAlertDialog(
        title: 'Error saving Score',
        message: 'There was an issue saving your score. Please Try again'
      );
    }).catchError((error) {
      Utils.showModalAlertDialog(
        title: 'Error saving Score',
        message: 'There was an issue saving your score. Please Try again'
      );
    });
  }

  void reload() {
    notifyListeners();
  }
}