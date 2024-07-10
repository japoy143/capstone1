import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TotalScoreTable extends StatefulWidget {
  const TotalScoreTable({super.key});

  @override
  State<TotalScoreTable> createState() => _TotalScoreTableState();
}

class _TotalScoreTableState extends State<TotalScoreTable> {
  //db
  late Box<scores> userScoreBox;

  @override
  void initState() {
    userScoreBox = Hive.box<scores>('scores');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: userScoreBox.length,
          itemBuilder: (context, index) {
            final user = userScoreBox.getAt(index);
            return Text(
              user!.totalScore.toString(),
              style: TextStyle(fontSize: 18, fontFamily: 'rubik'),
            );
          }),
    );
  }
}
