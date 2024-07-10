import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameUI.dart';
import 'package:flutter/material.dart';

class Mygame1 extends StatefulWidget {
  Mygame1({super.key, required this.username, required this.audioPlayer});
  late String username;
  late AudioPlayer audioPlayer;

  @override
  State<Mygame1> createState() => _Mygame1State();
}

class _Mygame1State extends State<Mygame1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MygameUI1(
            username: widget.username,
            audioPlayer: widget.audioPlayer,
          ),
        ],
      ),
    );
  }
}
