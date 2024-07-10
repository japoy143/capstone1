import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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

  Stop(BuildContext context) {
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

  FastRun() async {
    try {
      String file = 'audios/Bgmusic/FastRun.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  Soar() async {
    try {
      String file = 'audios/Bgmusic/Soar.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  SlowChill() async {
    try {
      String file = 'audios/Bgmusic/SlowChill.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  SadDay(BuildContext context) async {
    try {
      String file = 'audios/Bgmusic/SadDay.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }

  Victorous() async {
    try {
      String file = 'audios/Bgmusic/Victorous.mp3';
      await player.play(AssetSource(file));
    } catch (e) {
      print('caught error not playing music $e');
    }
  }
}
