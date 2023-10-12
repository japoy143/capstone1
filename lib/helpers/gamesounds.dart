import 'package:audioplayers/audioplayers.dart';

class Gamesounds {
  final player = AudioPlayer();
  final cache = AudioCache();

  GameOpening() async {
    try {
      String file = 'audios/Opening.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught erorr not playing music $e ');
    }
  }

  GameOpeningStop() {
    player.stop();
  }

  Future<void> OntapSounds() async {
    try {
      String file = 'audios/tap.wav';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  OntapSoundsOff() {
    player.stop();
  }

  OntapStop() {
    player.stop();
  }

  Correct() async {
    try {
      String file = 'audios/correct.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  Wrong() async {
    try {
      String file = 'audios/wrong.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  Invalid() async {
    try {
      String file = 'audios/invalid.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }
}
