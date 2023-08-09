import 'package:capstoneapp1/menuPages/gameComponents/game_keyboard.dart';
import 'package:flutter/material.dart';

class playGame extends StatefulWidget {
  const playGame({super.key});

  @override
  State<playGame> createState() => _playGameState();
}

class _playGameState extends State<playGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "WORDY ",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          GameKeyboard(),
        ],
      ),
    );
  }
}
