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
      appBar: AppBar(
        title: Text('Play Game'),
      ),
    );
  }
}
