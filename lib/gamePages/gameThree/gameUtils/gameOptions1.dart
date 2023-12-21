import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/GameCategory.dart';
import 'package:capstoneapp1/gamePages/gameOne/gamePage/gamePlay.dart';
import 'package:capstoneapp1/gamePages/gameThree/gamePage/gamePlay.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gamePage/gamePlay.dart';
import 'package:flutter/material.dart';

import '../../Gameauth.dart';

class GameOptions3 extends StatefulWidget {
  GameOptions3(
      {Key? key,
      required this.WordCount,
      required this.username,
      required this.audioPlayer})
      : super(key: key);
  late int WordCount;
  late String username;
  late AudioPlayer audioPlayer;

  @override
  State<GameOptions3> createState() => _GameOptions1State();
}

class _GameOptions1State extends State<GameOptions3> {
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
                  height: 70,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Congratulations ${widget.username} \n you've reach the minimum guessed words",
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
                            )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[400],
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
                      color: Colors.green[400],
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
                      color: Colors.green[400],
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
