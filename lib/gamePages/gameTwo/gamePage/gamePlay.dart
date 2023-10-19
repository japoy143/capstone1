import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameUI.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameUI.dart';
import 'package:flutter/material.dart';

class Mygame2 extends StatelessWidget {
  Mygame2({super.key, required this.userName, required this.audioPlayer});
  late String userName;
  late AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MygameUI2(
            userName: userName,
            audioPlayer: audioPlayer,
          ),
        ],
      ),
    );
  }
}
