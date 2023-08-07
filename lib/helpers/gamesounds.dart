import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Gamesounds {
  final player = AudioPlayer();
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
}
