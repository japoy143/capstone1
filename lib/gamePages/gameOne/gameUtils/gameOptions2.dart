import 'package:capstoneapp1/gamePages/GameCategory.dart';
import 'package:capstoneapp1/gamePages/gameOne/gamePage/gamePlay.dart';
import 'package:flutter/material.dart';

class GameOptionsTry1 extends StatefulWidget {
  GameOptionsTry1({Key? key, required this.WordCount}) : super(key: key);
  late int WordCount;

  @override
  State<GameOptionsTry1> createState() => _GameOptionsTry1State();
}

class _GameOptionsTry1State extends State<GameOptionsTry1> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 270,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Container(
                  height: 70,
                  width: 130,
                  child: Center(
                    child: Text(
                      "Try Again You Only Get ${widget.WordCount}",
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
                        builder: (BuildContext context) => Mygame1()),
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
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 170,
                  child: Center(
                    child: Text('Close',
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
