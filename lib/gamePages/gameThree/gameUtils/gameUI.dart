import 'dart:async';

import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimer.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gameAssets.dart';

class MygameUI3 extends StatefulWidget {
  @override
  _MygameUI3State createState() => _MygameUI3State();
}

class _MygameUI3State extends State<MygameUI3> {
  //Score
  int Score = 0;
  // one minute timer
  late Timer _timer;
  late Timer _newtimer;
  int seconds = 225;
  TimerController3 _timerform = TimerController3();

  //
  List<String> letters =
      'AAABBCCDDEEEFFGGHHIIIJJKKLLMMNNOOOPPQQRRSSTTUUUVVWWXXYYZZ'.split("");

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
    letters.shuffle();

    _startMinusLetter();
    _timerform.startTimer(224);
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
    _timerform.timer?.cancel();
    _newtimer.cancel();
  }

  //timer funct
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        }
      });
    });
  }

  //length of letter iteration
  int LetterCount = 15;
  int numcount = 15;
  void _startMinusLetter() {
    _newtimer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (numcount % 15 == 0) {
        if (LetterCount > 0) {
          setState(() {
            LetterCount--;
          });
        }
      }
    });
  }

  //time format

  //gameimgs
  IMGS imgs = IMGS();

  @override
  Widget build(BuildContext context) {
    String collected = letters.take(LetterCount).join('');

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
                        'Score:${Score}',
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
                            children: [
                              const Icon(
                                Icons.av_timer_sharp,
                                color: Colors.white70,
                              ),
                              const SizedBox(
                                width: 3.0,
                              ),
                              Obx(
                                () => Text(
                                  _timerform.time.value,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            'WORDY',
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300]),
          ),
          Text(
            'woodpicker',
            style: TextStyle(
              fontFamily: 'Edusa',
              fontSize: 30.0,
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
            width: 250,
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
            height: 15.0,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: SizedBox(
                height: 230,
                width: 400,
                child: Wrap(
                  children: charlist.map((e) {
                    return InkWell(
                      onTap: () {
                        onTapLetter(e);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          width: 60,
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
            padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      height: 40,
                      width: 100,
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
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: num > 0
                        ? () {
                            setState(() {
                              num -= 1;
                              letters.shuffle();
                            });
                          }
                        : null,
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 27,
                          ),
                          Text(
                            'Reshuffle',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.green[400]),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                num.toString(),
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[400]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onSubmit,
                  child: Container(
                    height: 40,
                    width: 100,
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
