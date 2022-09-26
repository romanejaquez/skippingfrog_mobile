import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/difficulty.dart';
import 'package:skippingfrog_mobile/helpers/leafdirection.dart';
import 'package:skippingfrog_mobile/models/leafmodel.dart';
import 'package:skippingfrog_mobile/services/difficultyservice.dart';

class Utils {

  static GlobalKey<NavigatorState> mainNav = GlobalKey();

  static List<LeafModel> generateGameLeafs(BuildContext context) {

    DifficultyService difficultyService = Provider.of<DifficultyService>(context, listen: false);
    Difficulty dif = difficultyService.difficulty;
    int rows = dif == Difficulty.easy ? 100 : 200;

    List<LeafModel> leaves = [];

    Random randomLeaf = Random();
    
    for(var i = 0; i < rows; i++) {

      var isCheckpoint = i != 0 && i % (rows / 10) == 0;

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

  static void preloadImages(WidgetsBinding binding) {
    List<String> allAssets = [
      './assets/imgs/achieve_badge.png',               
      './assets/imgs/frog_jumping.png',
      './assets/imgs/bottom_panel.png',                
      './assets/imgs/frog_lose.png',
      './assets/imgs/btn_back_off.png',                
      './assets/imgs/frog_skippingleft.png',
      './assets/imgs/btn_back_on.png',                 
      './assets/imgs/frog_skippingright.png',
      './assets/imgs/btn_easy_off.png',                
      './assets/imgs/frog_standing.png',
      './assets/imgs/btn_easy_on.png',                 
      './assets/imgs/frog_win.png',
      './assets/imgs/btn_hard_off.png',                
      './assets/imgs/help_title.png',
      './assets/imgs/btn_hard_on.png',                 
      './assets/imgs/leaderboards_title.png',
      './assets/imgs/btn_help_off.png',                
      './assets/imgs/leaf_down.png',
      './assets/imgs/btn_help_on.png',                 
      './assets/imgs/leaf_left.png',
      './assets/imgs/btn_lose_no_off.png',             
      './assets/imgs/leaf_right.png',
      './assets/imgs/btn_lose_no_on.png',              
      './assets/imgs/leaf_up.png',
      './assets/imgs/btn_lose_yes_off.png',            
      './assets/imgs/leftcontrol.png',
      './assets/imgs/btn_lose_yes_on.png',             
      './assets/imgs/lilly.png',
      './assets/imgs/btn_options_off.png',             
      './assets/imgs/lose_bg.png',
      './assets/imgs/btn_options_on.png',              
      './assets/imgs/main_bg.png',
      './assets/imgs/btn_start_off.png',               
      './assets/imgs/options_title.png',
      './assets/imgs/btn_start_on.png',                
      './assets/imgs/playagain_lose.png',
      './assets/imgs/btn_viewlb_off.png',              
      './assets/imgs/playagain_win.png',
      './assets/imgs/btn_viewlb_on.png',               
      './assets/imgs/rightcontrol.png',
      './assets/imgs/btn_win_no_off.png',              
      './assets/imgs/score.png',
      './assets/imgs/btn_win_no_on.png',               
      './assets/imgs/skippingfrog_icon.png',
      './assets/imgs/btn_win_submit_off.png',          
      './assets/imgs/skippingfrog_logo.png',
      './assets/imgs/btn_win_submit_on.png',           
      './assets/imgs/skippingfrog_logo_off.png',
      './assets/imgs/btn_win_yes_off.png',             
      './assets/imgs/splash_badge.png',
      './assets/imgs/btn_win_yes_on.png',              
      './assets/imgs/time.png',
      './assets/imgs/bug.png',                         
      './assets/imgs/topcontrol.png',
      './assets/imgs/difficulty_panel.png',            
      './assets/imgs/toppanel.png',
      './assets/imgs/downcontrol.png',                 
      './assets/imgs/water_bg.png',
      './assets/imgs/field.png'
    ];
  
    binding.addPostFrameCallback((_) async {
    BuildContext context = binding.renderViewElement!;
    for(var asset in allAssets)
    {
      precacheImage(AssetImage(asset), context);
    }
  });
  }
}