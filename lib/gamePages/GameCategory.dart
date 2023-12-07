import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/gamePages/gameOne/gamePage/gamePlay.dart';
import 'package:capstoneapp1/gamePages/gameThree/gamePage/gamePlay.dart';

import 'package:capstoneapp1/gamePages/gameTwo/gamePage/gamePlay.dart';
import 'package:capstoneapp1/helpers/gamesounds.dart';
import 'package:capstoneapp1/main.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../pages/menuPage.dart';

class GameCategory extends StatefulWidget {
  GameCategory({super.key, required this.username, required this.audioPlayer});
  late String username;
  late AudioPlayer audioPlayer;

  @override
  State<GameCategory> createState() => _GameCategoryState();
}

class _GameCategoryState extends State<GameCategory> {
  late Box<scores> userScoreBox;

  Gamesounds _gamesounds = Gamesounds();

  @override
  void initState() {
    userScoreBox = Hive.box<scores>('scores');
    _gamesounds.Stop(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.audioPlayer.stop();
  }

  void targetScoreIntermediate() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Mygame2(
              userName: widget.username,
              audioPlayer: widget.audioPlayer,
            )));
    widget.audioPlayer.pause();
  }

  void targetScoreExpert() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Mygame3(
              userName: widget.username,
              audioPlayer: widget.audioPlayer,
            )));
    widget.audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    final userScore = userScoreBox.get(widget.username);
    return WillPopScope(
      onWillPop: () async {
        widget.audioPlayer.pause();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.green[200],
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Game Category',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white54),
                ),
                SizedBox(
                  height: 70,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Mygame1(
                              username: widget.username,
                              audioPlayer: widget.audioPlayer,
                            )));
                    widget.audioPlayer.pause();
                  },
                  child: Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        'Easy',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'Anton',
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                  onTap: userScore!.totalScore > 50
                      ? () => targetScoreIntermediate()
                      : null,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: userScore!.totalScore >= 100
                            ? Colors.green[400]
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                        child: Text(
                      'Intermediate',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontFamily: 'Anton',
                          color: Colors.white70),
                    )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your total score must reach atleast 100 \n              Your totalscore ${userScore!.totalScore}",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: userScore!.totalScore > 100
                      ? () => targetScoreExpert()
                      : null,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: userScore!.totalScore > 150
                            ? Colors.green[400]
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        'Expert',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'Anton',
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your total score must reach atleast 150 \n              Your totalscore ${userScore!.totalScore}",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MenuPage(
                            nameUser: widget.username,
                            audioPlayer: widget.audioPlayer)));
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'Anton',
                            color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
