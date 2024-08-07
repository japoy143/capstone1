import 'package:flutter/material.dart';

class gameScoresDivision3 extends StatelessWidget {
  gameScoresDivision3(
      {Key? key, required this.compScore, required this.genScore})
      : super(key: key);
  late int compScore;
  late int genScore;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        height: screenHeight * .30,
        width: screenWidth * .70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: screenHeight * .25,
              width: screenWidth * .33,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: <Widget>[
                Text(
                  "GenWords Score",
                  style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
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
              height: screenHeight * .25,
              width: screenWidth * .33,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: <Widget>[
                Text(
                  "CompWords Score",
                  style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
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
