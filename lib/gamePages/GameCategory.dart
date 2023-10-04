import 'package:capstoneapp1/gamePages/gameOne/gamePage/gamePlay.dart';
import 'package:capstoneapp1/gamePages/gameThree/gamePage/gamePlay.dart';

import 'package:capstoneapp1/gamePages/gameTwo/gamePage/gamePlay.dart';
import 'package:capstoneapp1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameCategory extends StatefulWidget {
  GameCategory({super.key, required this.username});
  late String username;

  @override
  State<GameCategory> createState() => _GameCategoryState();
}

class _GameCategoryState extends State<GameCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Mygame1(username: widget.username))),
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
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Mygame2(
                          userName: widget.username,
                        ))),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.green[400],
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
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Mygame3(
                          userName: widget.username,
                        ))),
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.green[400],
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
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
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
    );
  }
}
