import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/components/allComputerWords.dart';
import 'package:capstoneapp1/components/allGeneralWords.dart';
import 'package:capstoneapp1/components/computerwordsList.dart';
import 'package:capstoneapp1/components/generalWordsList.dart';

import 'package:capstoneapp1/gamePages/GameCategory.dart';
import 'package:capstoneapp1/gamePages/GameCategory1.dart';
import 'package:capstoneapp1/menuPages/Highscores/TotalhighScore.dart';
import 'package:capstoneapp1/menuPages/MainHighScore.dart';
import 'package:capstoneapp1/models/scores.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class MenuPage extends StatefulWidget {
  MenuPage({super.key, required this.nameUser, required this.audioPlayer});
  late String nameUser;
  late AudioPlayer audioPlayer;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Box<scores> userBox;
  @override
  void initState() {
    userBox = Hive.box<scores>('scores');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.audioPlayer.stop();
  }

  void gamecategory() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GameCategory(
              username: widget.nameUser,
              audioPlayer: widget.audioPlayer,
            )));
  }

  void gamecategory1() async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GameCategory1(
            username: widget.nameUser, audioPlayer: widget.audioPlayer)));
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;
    //statusBar
    //note this only work when scaffold is used because it has status bar automatically
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        widget.audioPlayer.pause();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.green[200],
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (screenHeight - statusBarHeight) * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Text(
                      'Hi ${widget.nameUser.toString()}',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: (screenHeight - statusBarHeight) * .02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: (screenHeight - statusBarHeight) * .35,
                      width: (screenWidht) * .90,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(children: <Widget>[
                        const SizedBox(
                          height: 7.0,
                        ),
                        const Text(
                          'Computer Words',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: (screenHeight - statusBarHeight) * .24,
                          width: (screenWidht) * .80,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: ComputerDict(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllComputerWords()));
                          },
                          child: const Text(
                            'More',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Rubik',
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: userBox.containsKey(widget.nameUser)
                      ? () => gamecategory()
                      : () => gamecategory1(),
                  child: Container(
                    height: (screenHeight - statusBarHeight) * .09,
                    width: (screenWidht) * .50,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Play',
                        style: TextStyle(
                          fontFamily: 'Anton',
                          fontSize: 30.0,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainHighScores()));
                  },
                  child: Container(
                    height: (screenHeight - statusBarHeight) * .09,
                    width: (screenWidht) * .50,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        'HighScores',
                        style: TextStyle(
                          fontFamily: 'Anton',
                          fontSize: 30,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: (screenHeight - statusBarHeight) * .09,
                    width: (screenWidht) * .50,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontFamily: 'Anton',
                          fontSize: 30.0,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    height: (screenHeight - statusBarHeight) * .09,
                    width: (screenWidht) * .50,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Exit',
                        style: TextStyle(
                          fontFamily: 'Anton',
                          fontSize: 30.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
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
