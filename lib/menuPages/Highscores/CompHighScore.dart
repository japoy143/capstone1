import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class ComphighScore extends StatefulWidget {
  ComphighScore({super.key});

  @override
  State<ComphighScore> createState() => _ComphighScoreState();
}

class _ComphighScoreState extends State<ComphighScore> {
  late Box<scores> userScore;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userScore = Hive.box<scores>('scores');
    sort();
  }

  late List<scores> sortedScores;
  void sort() {
    sortedScores = userScore.values.toList()
      ..sort((a, b) => b.compScore.compareTo(a.compScore));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenStatusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Computer Words High Scores',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: ListView.builder(
          itemCount: userScore.length,
          itemBuilder: (context, index) {
            final sorted = sortedScores[index] as scores;

            return Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                height: (screenHeight - screenStatusBar) * .30,
                width: screenWidth * .70,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onLongPress: () {
                        setState(() {
                          userScore.deleteAt(index);
                        });
                        Vibration.vibrate();
                      },
                      child: Container(
                        height: 40,
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                            child: Text(
                          sorted.username,
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              letterSpacing: 2.0),
                        )),
                      ),
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
                                sorted.wordPerMinute.toString(),
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
                                sorted.totalScore.toString(),
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
                                sorted.compScore.toString(),
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
                                  'Gen Score ',
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
                                sorted.genScore.toString(),
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
