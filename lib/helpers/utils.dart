import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/enums.dart';
import 'package:skippingfrog_mobile/helpers/leafdirection.dart';
import 'package:skippingfrog_mobile/models/gameconfig.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';
import 'package:skippingfrog_mobile/widgets/basicalert.dart';

class Utils {

  static GlobalKey<NavigatorState> mainNav = GlobalKey();

  static const int slidingDurationValue = 750;
  
  static List<LeafModel> generateGameLeafs(BuildContext context) {

    DifficultyService difficultyService = Provider.of<DifficultyService>(context, listen: false);
    Difficulty dif = difficultyService.difficulty;
    int rows = Utils.gameConfig[dif]!.rows;

    List<LeafModel> leaves = [];

    Random randomLeaf = Random();
    
    for(var i = 0; i < rows; i++) {

      var isCheckpoint = false; // i != 0 && i % (rows / 10) == 0;

      leaves.add(LeafModel(
        index: randomLeaf.nextInt(4),
        direction: LeafDirection.values[randomLeaf.nextInt(LeafDirection.values.length)],
        containsBug: randomLeaf.nextInt(rows) % 2 == 0,
        isCheckpoint: isCheckpoint,
        checkpointValue: isCheckpoint ? i ~/ 10 : -1
      ));
    
    }

    return leaves;
  }

  static Duration slidingDuration = const Duration(milliseconds: slidingDurationValue);

  static Map<Difficulty, GameConfig> gameConfig = {
    Difficulty.easy: GameConfig(rows: 10),
    Difficulty.hard: GameConfig(rows: 200),
  };

  static Future<bool> preloadImages(BuildContext context) {
    Completer<bool> preloadCompleter = Completer();
    
    List<String> allAssets = [
      'assets/imgs/ob_arrowdown.png',
      'assets/imgs/ob_arrowleft.png',
      'assets/imgs/ob_arrowright.png',
      'assets/imgs/ob_arrowup.png',
      'assets/imgs/ob_hand.png',
      'assets/imgs/ob_leafdown.png',
      'assets/imgs/ob_leafleft.png',
      'assets/imgs/ob_leafright.png',
      'assets/imgs/ob_leafup.png',
      'assets/imgs/achieve_badge.png',               
      'assets/imgs/frog_jumping.png',
      'assets/imgs/bottom_panel.png',                
      'assets/imgs/frog_lose.png',
      'assets/imgs/btn_back_off.png',                
      'assets/imgs/frog_skippingleft.png',
      'assets/imgs/btn_back_on.png',                 
      'assets/imgs/frog_skippingright.png',
      'assets/imgs/btn_easy_off.png',                
      'assets/imgs/frog_standing.png',
      'assets/imgs/btn_easy_on.png',                 
      'assets/imgs/frog_win.png',
      'assets/imgs/btn_hard_off.png',                
      'assets/imgs/help_title.png',
      'assets/imgs/btn_hard_on.png',                 
      'assets/imgs/leaderboards_title.png',
      'assets/imgs/btn_help_off.png',                
      'assets/imgs/leaf_down.png',
      'assets/imgs/btn_help_on.png',                 
      'assets/imgs/leaf_left.png',
      'assets/imgs/btn_lose_no_off.png',             
      'assets/imgs/leaf_right.png',
      'assets/imgs/btn_lose_no_on.png',              
      'assets/imgs/leaf_up.png',
      'assets/imgs/btn_lose_yes_off.png',            
      'assets/imgs/leftcontrol.png',
      'assets/imgs/btn_lose_yes_on.png',             
      'assets/imgs/lilly.png',
      'assets/imgs/btn_options_off.png',             
      'assets/imgs/lose_bg.png',
      'assets/imgs/btn_options_on.png',              
      'assets/imgs/main_bg.png',
      'assets/imgs/btn_start_off.png',               
      'assets/imgs/options_title.png',
      'assets/imgs/btn_start_on.png',                
      'assets/imgs/playagain_lose.png',
      'assets/imgs/btn_viewlb_off.png',              
      'assets/imgs/playagain_win.png',
      'assets/imgs/btn_viewlb_on.png',               
      'assets/imgs/rightcontrol.png',
      'assets/imgs/btn_win_no_off.png',              
      'assets/imgs/score.png',
      'assets/imgs/btn_win_no_on.png',               
      'assets/imgs/skippingfrog_icon.png',
      'assets/imgs/btn_win_submit_off.png',          
      'assets/imgs/skippingfrog_logo.png',
      'assets/imgs/btn_win_submit_on.png',           
      'assets/imgs/skippingfrog_logo_off.png',
      'assets/imgs/btn_win_yes_off.png',             
      'assets/imgs/splash_badge.png',
      'assets/imgs/btn_win_yes_on.png',              
      'assets/imgs/time.png',
      'assets/imgs/bug.png',                         
      'assets/imgs/topcontrol.png',
      'assets/imgs/difficulty_panel.png',            
      'assets/imgs/toppanel.png',
      'assets/imgs/downcontrol.png',                 
      'assets/imgs/water_bg.png',
      'assets/imgs/field.png',
    ];

    List<Future> precachedFutures = [];
    for(var asset in allAssets)
    {
        precachedFutures.add(precacheImage(AssetImage(asset), context));
    }

    Future.wait(precachedFutures).then((value) {
      preloadCompleter.complete(true);
    });

    return preloadCompleter.future;
  }

  static String formatTimeAsString(Duration time) {
    var timeAsDate = DateTime(2020, 1, 1).add(time);
    return DateFormat.Hms().format(timeAsDate);
  }

  static void showModalAlertDialog(BuildContext context,
    Function onSelectedAlertOption,
    { String title = '', 
      String message = '', 
      List<AlertOptions> options = const [AlertOptions.ok]
    }
  ) {
        showDialog(
          useSafeArea: true,
          barrierDismissible: false,
          context: context,
          builder: (cxt) {
          
          return BasicAlert(
            title: title,
            message: message,
            options: options,
            onSelectedOption: (AlertOptions o) {
              onSelectedAlertOption(o);
            },
          );
      });
  }
}