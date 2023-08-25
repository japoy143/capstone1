import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameUI.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameUI.dart';
import 'package:flutter/material.dart';

class Mygame2 extends StatelessWidget {
  const Mygame2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MygameUI2(),
        ],
      ),
    );
  }
}
