import 'package:flutter/material.dart';

class LoadingScreen1 {
  List<String> title = [
    "W",
    "O",
    "R",
    "D",
    "Y",
  ];

  Widget titleList(BuildContext context, title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 60,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
