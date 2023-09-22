import 'package:flutter/material.dart';

class gameScoresDivision extends StatelessWidget {
  gameScoresDivision(
      {Key? key, required this.compScore, required this.genScore})
      : super(key: key);
  late int compScore;
  late int genScore;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        height: 220,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: <Widget>[
                Text(
                  "GenWords Score",
                  style: TextStyle(
                      fontFamily: 'Anton',
                      fontSize: 15,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "${genScore.toString()}",
                  style: TextStyle(fontSize: 44.0, color: Colors.white70),
                )
              ]),
            ),
            Container(
              height: 200,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: <Widget>[
                Text(
                  "CompWords Score",
                  style: TextStyle(
                      fontFamily: 'Anton',
                      fontSize: 15,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "${compScore.toString()}",
                  style: TextStyle(fontSize: 44.0, color: Colors.white70),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
