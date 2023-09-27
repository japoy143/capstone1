import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class highScore extends StatefulWidget {
  const highScore({super.key});

  @override
  State<highScore> createState() => _highScoreState();
}

class _highScoreState extends State<highScore> {
  late Box<scores> userScore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userScore = Hive.box('scores');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('High Scores'),
      ),
      body: ListView.builder(
          itemCount: userScore.length,
          itemBuilder: (context, index) {
            final Scores = userScore.getAt(index) as scores;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                height: 235,
                width: 200,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 220,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                          child: Text(
                        Scores.username,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            letterSpacing: 2.0),
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Word Per Minute',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      letterSpacing: 2.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                Scores.wordPerMinute.toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik'),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Total Score',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      letterSpacing: 2.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                Scores.totalScore.toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  'CompScore',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      letterSpacing: 2.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                Scores.compScore.toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik'),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Bonus Score ${Scores.compScore}',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      letterSpacing: 2.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                Scores.genScore.toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.green[400],
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
