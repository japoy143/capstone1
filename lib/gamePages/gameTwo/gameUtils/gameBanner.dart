import 'package:flutter/material.dart';

class WordUsed2 extends StatelessWidget {
  const WordUsed2({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 20,
        width: 150,
        child: Center(
          child: Text(
            "Word is Already Used",
            style: TextStyle(
                fontSize: 18, fontFamily: 'Anton', color: Colors.green[400]),
          ),
        ),
      ),
    );
  }
}
