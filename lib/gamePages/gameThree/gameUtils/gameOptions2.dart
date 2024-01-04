import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/GameCategory.dart';
import 'package:capstoneapp1/gamePages/gameOne/gamePage/gamePlay.dart';
import 'package:capstoneapp1/gamePages/gameThree/gamePage/gamePlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Gameauth.dart';

class GameOptionsTry3 extends StatefulWidget {
  GameOptionsTry3(
      {Key? key,
      required this.WordCount,
      required this.username,
      required this.audioPlayer})
      : super(key: key);
  late int WordCount;
  late String username;
  late AudioPlayer audioPlayer;

  @override
  State<GameOptionsTry3> createState() => _GameOptionsTry1State();
}

class _GameOptionsTry1State extends State<GameOptionsTry3> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 270,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  height: 80,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Oops! Sorry ${widget.username} you didnt reach the minimum guessed words.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Mygame3(
                                userName: widget.username,
                                audioPlayer: widget.audioPlayer,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 170,
                  child: Center(
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: "Anton",
                          color: Colors.black54),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GameAuth(
                            username: widget.username,
                            audioPlayer: widget.audioPlayer)));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 170,
                  child: Center(
                    child: Text('Game Categories',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Anton",
                            color: Colors.black54)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 170,
                  child: Center(
                    child: Text('Main-Menu',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Anton",
                            color: Colors.black54)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
