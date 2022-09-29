import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:skippingfrog_mobile/helpers/skippingfrogsounds.dart';

class AudioService {

  List<AssetsAudioPlayer> audios = [];
  AssetsAudioPlayer assetAudio = AssetsAudioPlayer();

  void playSound(SkippingFrogSounds sound, { bool waitForSoundToFinish = false}) async {

    if (waitForSoundToFinish) {
      var waitSound = AssetsAudioPlayer();
      audios.add(waitSound);
      await waitSound.open(Audio('./assets/sounds/${sound.name}.mp3'));
      audios.remove(waitSound);
    }
    else {
       await assetAudio.open(Audio('./assets/sounds/${sound.name}.mp3'));
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