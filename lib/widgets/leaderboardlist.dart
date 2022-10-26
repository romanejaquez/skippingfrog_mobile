import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/appcolors.dart';
import 'package:skippingfrog_mobile/helpers/utils.dart';
import 'package:skippingfrog_mobile/models/playermodel.dart';
import 'package:skippingfrog_mobile/services/loginservice.dart';

class LeaderboardList extends StatefulWidget {

  final List<PlayerModel> players;

  const LeaderboardList({super.key, required this.players });

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {

  List<PlayerModel> playersList = [];
  final GlobalKey<AnimatedListState> playersListKey = GlobalKey<AnimatedListState>();
  late Timer listTimer = Timer(Duration.zero, () {});
  
  @override
  void initState() {
    super.initState();

    int count = 0;

    listTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (count == widget.players.length) {
        timer.cancel();
      }
      else {
        playersListKey.currentState!.insertItem(count, duration: const Duration(milliseconds: 500));
        playersList.add(widget.players[count]);
      }
      count++;
    });
  }

  @override
  void dispose() {
    listTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle headerStyle = const TextStyle(color: Colors.white, fontSize: 20);
    TextStyle rowStyle = const TextStyle(
      fontFamily: 'Arial',
      color: Colors.white, fontSize: 15);

    TextStyle currentUserRowStyle = const TextStyle(
      fontFamily: 'Arial',
      fontWeight: FontWeight.bold,
      color: Colors.black, fontSize: 15);

    EdgeInsets headerPadding = const EdgeInsets.only(
      left: 20, right: 20, top: 20, bottom: 10
    );

    EdgeInsets rowPadding = const EdgeInsets.only(
      left: 20, right: 20, top: 10, bottom: 10
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: headerPadding,
            color: Colors.black.withOpacity(0.8),
            child: Row(
              children: [
                Text('#', style: headerStyle),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Text('PLAYER', style: headerStyle),
                ),
                Expanded(
                  child: Text('SCORE', textAlign: TextAlign.center, style: headerStyle),
                ),
                Expanded(
                  child: Text('TIME', textAlign: TextAlign.right, style: headerStyle),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: AnimatedList(
                key: playersListKey,
                initialItemCount: playersList.length,
                itemBuilder: ((context, index, animation) {
                  PlayerModel player = widget.players[index];

                  var loginService = Provider.of<LoginService>(context, listen: false);
                  var timeAsString = Utils.formatTimeAsString(Duration(seconds: player.timeInSeconds));
                  var isCurrentPlayer = loginService.isUserLoggedIn() && loginService.loggedInUserModel!.email == player.name;

                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero
                    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                      child: Container(
                          color: isCurrentPlayer ? (Colors.yellow) : (index % 2 == 0 ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.3)),
                          padding: rowPadding,
                          child: Row(
                          children: [
                            Text('${index + 1}', style: isCurrentPlayer ? currentUserRowStyle : rowStyle),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(player.name,
                                  overflow: TextOverflow.ellipsis,
                                style: isCurrentPlayer ? currentUserRowStyle : rowStyle),
                              )),
                            Expanded(
                              child: Text('${player.score}',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: isCurrentPlayer ? currentUserRowStyle : rowStyle)
                            ),
                            Expanded(child: Text(timeAsString, 
                            textAlign: TextAlign.right, style: isCurrentPlayer ? currentUserRowStyle : rowStyle)),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ),
            ),
          )
        ],
      ),
    );
  }
}