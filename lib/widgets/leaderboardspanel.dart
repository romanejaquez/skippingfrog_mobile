import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/models/playermodel.dart';
import 'package:skippingfrog_mobile/services/leaderboardservice.dart';
import 'package:skippingfrog_mobile/widgets/leaderboardlist.dart';
import 'package:skippingfrog_mobile/widgets/leaderboardloading.dart';

class LeaderboardsPanel extends StatelessWidget {
  const LeaderboardsPanel({super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Consumer<LeaderboardService>(
        builder: (context, lbService, child) {
          return FutureBuilder(
            future: lbService.getPlayers(),
            builder: (context, snapshot) {
              
              Widget displayWidget;

              switch(snapshot.connectionState) {
                case ConnectionState.waiting:
                  displayWidget = const LeaderboardLoading();
                  break;
                case ConnectionState.done:
                  displayWidget = LeaderboardList(
                    players: snapshot.data as List<PlayerModel>
                  );
                  break;
                default:
                  displayWidget = const LeaderboardLoading();
                  break;
              }
              return displayWidget;
            },
          );
        }
      ),
    );
  }
}