import 'package:capstoneapp1/models/scores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({super.key});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
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
              user!.username.toString(),
              style: TextStyle(fontSize: 18, fontFamily: 'rubik'),
            );
          }),
    );
  }
}
