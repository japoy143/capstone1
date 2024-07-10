import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/GameCategory.dart';
import 'package:capstoneapp1/gamePages/GameCategory1.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GameAuth extends StatefulWidget {
  final String username;
  final AudioPlayer audioPlayer;

  GameAuth({Key? key, required this.username, required this.audioPlayer})
      : super(key: key);

  @override
  State<GameAuth> createState() => _GameAuthState();
}

class _GameAuthState extends State<GameAuth> {
  late Box<scores> userScoreBox;

  @override
  void initState() {
    super.initState();
    userScoreBox = Hive.box<scores>('scores');
  }

  @override
  Widget build(BuildContext context) {
    if (userScoreBox.containsKey(widget.username)) {
      return GameCategory(
        username: widget.username,
        audioPlayer: widget.audioPlayer,
      );
    } else {
      return GameCategory1(
        username: widget.username,
        audioPlayer: widget.audioPlayer,
      );
    }
  }
}
