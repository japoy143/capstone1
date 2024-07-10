import 'package:flutter/material.dart';

class wordHints extends StatefulWidget {
  wordHints({super.key, required this.hintWord});
  late String hintWord;

  @override
  State<wordHints> createState() => _wordHintState();
}

class _wordHintState extends State<wordHints> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 50,
        width: 150,
        child: Center(
          child: Text(
            "Hint: ${widget.hintWord}",
            style: TextStyle(
                fontSize: 18, fontFamily: 'Anton', color: Colors.green[400]),
          ),
        ),
      ),
    );
  }
}
