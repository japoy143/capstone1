import 'dart:math';

import 'package:capstoneapp1/menuPages/gameComponents/gamekeyboard1.dart/gamekeyboard1.dart';
import 'package:flutter/material.dart';

class GameKeyboard extends StatefulWidget {
  const GameKeyboard({super.key});

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  //counter
  int num = 3;

  //randomize the keyboard class
  GameKeyboard1 keyboard = GameKeyboard1();
  //shufflling containers
  @override
  void initState() {
    super.initState();
    keyboard.shuff1();
    keyboard.shuff2();
    keyboard.shuff3();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        keyboard.shuff1(),
        SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 5.0,
        ),
        keyboard.shuff2(),
        SizedBox(
          height: 5.0,
        ),
        keyboard.shuff3(),
        SizedBox(
          height: 50.0,
        ),
        GestureDetector(
          onTap: num > 0
              ? () {
                  setState(() {
                    num -= 1;
                  });
                }
              : null,
          child: Container(
            height: 55.0,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25.0,
                ),
                Text(
                  "Reshuffle",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      num.toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
