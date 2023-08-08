import 'package:flutter/material.dart';

class highScore extends StatefulWidget {
  const highScore({super.key});

  @override
  State<highScore> createState() => _highScoreState();
}

class _highScoreState extends State<highScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Scores'),
      ),
    );
  }
}
