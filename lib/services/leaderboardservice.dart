import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/playermodel.dart';
import 'package:skippingfrog_mobile/models/scoreconfig.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';
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

  bool canSubmitScore(BuildContext context) {
    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    GameService gameService = Provider.of<GameService>(context, listen: false);
    ScoreConfig scoreConfig = gameService.getScoreData();

    return loginService.isUserLoggedIn() && scoreConfig.score > 0;
  }

  Future<void> submitScore(ScoreConfig config, BuildContext context) async {
    LoginService loginService = Provider.of<LoginService>(context, listen: false);

    var userId = loginService.loggedInUserModel!.uid;
    var playerName = loginService.loggedInUserModel!.email;

    await firestore.collection('leaderboard').doc(userId).set({
      'name': playerName,
      'score': config.score,
      'timestamp': config.time.inSeconds
    });
    cachedPlayers.clear();
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }
}