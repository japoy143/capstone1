import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class wpmTable extends StatefulWidget {
  const wpmTable({super.key});

  @override
  State<wpmTable> createState() => _wpmTableState();
}

class _wpmTableState extends State<wpmTable> {
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
              user!.wordPerMinute.toString(),
              style: TextStyle(fontSize: 18, fontFamily: 'rubik'),
            );
          }),
    );
  }
}
