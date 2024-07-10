import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

class TotalhighScore extends StatefulWidget {
  TotalhighScore({super.key});

  @override
  State<TotalhighScore> createState() => _TotalhighScoreState();
}

class _TotalhighScoreState extends State<TotalhighScore> {
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
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenStatusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scores',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: userScore.length,
          itemBuilder: (context, index) {
            final sorted = sortedScores[index] as scores;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                height: (screenHeight - screenStatusBar) * .32,
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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Column(children: <Widget>[
                            Container(
                              height: 40,
                              width: 190,
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  'Word Per Minute',
                                  style: TextStyle(
                                      fontSize: 16.0,
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
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.green[400],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Total Guessed Word',
                                    style: TextStyle(
                                        fontSize: 16.0,
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
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
