import 'package:flutter/material.dart';

class GameKeyboard1 {
  Row shuff1() {
    List<String> row1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    row1.shuffle();
    String collectedRow1 = "";
    for (int i = 0; i < 6; i++) {
      String newRow1 = row1[i];
      collectedRow1 += newRow1;
    }
    List<String> charlist = collectedRow1.split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: charlist.map((e) {
        return InkWell(
          onTap: () {
            print(e);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade300,
              ),
              child: Text(
                "${e}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Row shuff2() {
    List<String> row1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    row1.shuffle();
    String collectedRow1 = "";
    for (int i = 0; i < 8; i++) {
      String newRow1 = row1[i];
      collectedRow1 += newRow1;
    }
    List<String> charlist = collectedRow1.split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: charlist.map((e) {
        return InkWell(
          onTap: () {
            print(e);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade300,
              ),
              child: Text(
                "${e}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Row shuff3() {
    List<String> row1 = "AIEOUBCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    row1.shuffle();
    String collectedRow1 = "";
    for (int i = 0; i < 9; i++) {
      String newRow1 = row1[i];
      collectedRow1 += newRow1;
    }
    List<String> charlist = collectedRow1.split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: charlist.map((e) {
        return InkWell(
          onTap: () {
            print(e);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade300,
              ),
              child: Text(
                "${e}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
