import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';
import 'package:skippingfrog_mobile/services/gameservice.dart';

class AudioService {

  List<AssetsAudioPlayer> audios = [];
  AssetsAudioPlayer assetAudio = AssetsAudioPlayer();
  late BuildContext ctx;

  void init(BuildContext context) {
    ctx = context;
  }

  Future<void> playSound(SkippingFrogSounds sound, { bool waitForSoundToFinish = false}) async {

    GameService gameService = Provider.of<GameService>(ctx, listen: false);
    if (gameService.areAllSoundsMute()) {
      return;
    }
    
    if (waitForSoundToFinish) {
      var waitSound = AssetsAudioPlayer();
      audios.add(waitSound);
      await waitSound.open(Audio('/assets/sounds/${sound.name}.mp3'));
      audios.remove(waitSound);
    }
    else {
       await assetAudio.open(Audio('/assets/sounds/${sound.name}.mp3'));
    }
  }

  void stopAllSounds() async {
    await assetAudio.stop();

    if (audios.isNotEmpty) {
      for (var element in audios) { 
        await element.stop(); 
        }
      }
  }

  void reset() {
    stopAllSounds();
    audios = [];
  }
}