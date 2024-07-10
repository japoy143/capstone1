import 'package:capstoneapp1/menuPages/newHighScore/UsersTable.dart';
import 'package:capstoneapp1/menuPages/newHighScore/totalScoreTable.dart';
import 'package:capstoneapp1/menuPages/newHighScore/wpmTable.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TableScore extends StatefulWidget {
  const TableScore({super.key});

  @override
  State<TableScore> createState() => _TableScoreState();
}

class _TableScoreState extends State<TableScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Container(
            height: 700,
            width: 400,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Center(
                      child: Text(
                        'Score History',
                        style: TextStyle(
                            fontFamily: 'rubik',
                            fontSize: 30,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              border: Border.all(color: Colors.black87)),
                          child: Center(
                              child: Text(
                            'User',
                            style: TextStyle(
                                fontFamily: 'rubik',
                                fontSize: 20,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              border: Border.all(color: Colors.black87)),
                          child: Center(
                              child: Text(
                            'WPM',
                            style: TextStyle(
                                fontFamily: 'rubik',
                                fontSize: 20,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              border: Border.all(color: Colors.black87)),
                          child: Center(
                              child: Text(
                            'Total Score',
                            style: TextStyle(
                                fontFamily: 'rubik',
                                fontSize: 20,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Colors.black38)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: UsersTable(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Colors.black38)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: wpmTable(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(color: Colors.black38)),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: TotalScoreTable()),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
