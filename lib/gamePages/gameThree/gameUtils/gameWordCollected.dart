import 'package:flutter/material.dart';

class WordCollected3 extends StatelessWidget {
  WordCollected3({Key, key, required this.allwords, required this.allscore})
      : super(key: key);

  late List<String> allwords;
  late List<int> allscore;

  @override
  Widget build(BuildContext context) {
    List<Widget> combined = allwords.map((word) {
      int index = allwords.indexOf(word);
      String score = allscore[index].toString();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$word - $score',
            style: TextStyle(
                fontFamily: 'Rubik',
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 20.0),
          ),
        ],
      );
    }).toList();
    return AlertDialog(
      content: Container(
        height: 300,
        width: 300,
        child: Column(children: <Widget>[
          Text(
            'Words Collected',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Anton', color: Colors.green[400]),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.green[400]),
              height: 250,
              width: 280,
              child: ListView(children: combined))
        ]),
      ),
    );
  }
}
