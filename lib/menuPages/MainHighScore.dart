import 'package:capstoneapp1/menuPages/Highscores/CompHighScore.dart';
import 'package:capstoneapp1/menuPages/Highscores/GenHighScore.dart';
import 'package:capstoneapp1/menuPages/Highscores/TotalhighScore.dart';
import 'package:capstoneapp1/menuPages/Highscores/WPMHighScore.dart';
import 'package:capstoneapp1/menuPages/newHighScore/tableScores.dart';
import 'package:flutter/material.dart';

class MainHighScores extends StatefulWidget {
  const MainHighScores({super.key});

  @override
  State<MainHighScores> createState() => _MainHighScoresState();
}

class _MainHighScoresState extends State<MainHighScores> {
  List pages = [TotalhighScore(), TableScore()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green[400],
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.green,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: 'Total High Score'),
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart_outlined),
                label: 'Score History Table'),
          ]),
    );
  }
}
