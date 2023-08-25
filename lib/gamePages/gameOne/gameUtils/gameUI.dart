import 'dart:async';

import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gameAssets.dart';

class MygameUI1 extends StatefulWidget {
  @override
  _MygameUI1State createState() => _MygameUI1State();
}

class _MygameUI1State extends State<MygameUI1> {
  //Score
  int Score = 0;
  // one minute timer
  late Timer _timer;
  late Timer _newtimer;
  int seconds = 225;
  TimerController _timerform = TimerController();

  //
  List<String> letters = 'QWERTYUIOPASDFGHJKLZXCVBNM.'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';
  TextEditingController userInputController = TextEditingController();

  Map<String, String> computerWords = {
    'ALU': 'Arithmethic',
    'CPU': "Central Processing Unit",
    'A': "Its ok"
  };

  @override
  void initState() {
    super.initState();
  }

  void onTapLetter(String letter) {
    setState(() {
      pressedLetters.add(letter);
      userInputController.text = pressedLetters.join('');
    });
  }

  void onSubmit() {
    if (pressedLetters.isNotEmpty) {
      createdWord = pressedLetters.join('');
      if (computerWords.containsKey(createdWord)) {
        meaning = computerWords[createdWord]!;
        print(meaning);
      } else {
        print('Word doesnt exist');
      }
    }
  }

  void onDelete() {
    setState(() {
      if (pressedLetters.isNotEmpty) {
        pressedLetters.removeLast();
        userInputController.text = pressedLetters.join('');
      }
      return;
    });
  }

//reshuffle
  int num = 3;

  @override
  void dispose() {
    super.dispose();
    userInputController.dispose();
  }

  //time format

  //gameimgs
  IMGS imgs = IMGS();

  @override
  Widget build(BuildContext context) {
    String collected = letters.take(27).join('');

    List<String> charlist = collected.split('');

    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 30.0,
                            color: Colors.white70,
                          ))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Score: ${Score}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 65.0,
                      ),
                      Container(
                        height: 30,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white70, width: 2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No timer",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Rubik"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'WORDY',
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300]),
          ),
          Text(
            'woodpicker',
            style: TextStyle(
              fontFamily: 'Edusa',
              fontSize: 35.0,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Center(
            child: Stack(
              children: [
                imgs.gameImg(true, 'assets/imgs/thief2.png'),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            height: 50,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0)),
            child: TextField(
              controller: userInputController,
              readOnly: true,
              style: const TextStyle(color: Colors.green),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.green),
              ),
            ),
          ),
          const SizedBox(
            height: 45.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                height: 170,
                width: 400,
                child: Wrap(
                  children: charlist.map((e) {
                    return InkWell(
                      onTap: () {
                        onTapLetter(e);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6.5, top: 5.0, bottom: 5.0),
                        child: Container(
                          height: 45,
                          width: 35.5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.green[400]),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      height: 40,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.green[400]),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onSubmit,
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400]),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
