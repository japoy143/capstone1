import 'dart:async';
import 'dart:math';

import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameNotifs.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameOptions1.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameOptions2.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameScoreDivision.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameTimer.dart';
import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameWordCollected.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import '../../../components/Dictionaries/ComputerWordsList.dart';
import '../../../helpers/gamesounds.dart';
import 'gameAssets.dart';
import 'gameBanner.dart';

class MygameUI2 extends StatefulWidget {
  late String userName;
  MygameUI2({required this.userName});
  @override
  _MygameUI2State createState() => _MygameUI2State();
}

class _MygameUI2State extends State<MygameUI2> {
  //database
  late Box<scores> scoreBox;

  //WPM
  int initialWPM = 0;
  int finalWPM = 0;

  //Score
  int Score = 0;
  int compScore = 0;
  int genScore = 0;

  int wordCount = 0;

  //dictionary
  final dMSAJson = DictionaryMSAFlutter();

  int seconds = 225;
  TimerController2 _timerform = TimerController2();

  //
  List<String> letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';

  //check if word already  inside this list
  List<String> checker = [];

  TextEditingController userInputController = TextEditingController();

  //classes
  CompWords compWords = CompWords();
  GameNotifs2 _gameNotifs2 = GameNotifs2();

  @override
  void initState() {
    super.initState();
    letters.shuffle();
    _timerform.startTimer(119);
    randId();
    timerBanner();
    timerWPM();
    keysZero();
    scoreBox = Hive.box<scores>('scores');
  }

  void onTapLetter(String letter) {
    setState(() {
      pressedLetters.add(letter);
      userInputController.text = pressedLetters.join('');
    });
  }

  //one minute for WPM
  late Timer TimerWPM;
  void timerWPM() {
    TimerWPM = Timer(Duration(seconds: 60), () {
      finalWPM = initialWPM;
    });
  }

  //randomize id
  int randNum = 0;
  void randId() {
    var random = Random();
    randNum = (random.nextDouble() * 10000).toInt() + 1;
  }

  //keyboardLength to zero
  late Timer keysToZero;
  void keysZero() {
    keysToZero = Timer(Duration(seconds: 120), () {
      setState(() {
        keyboardLength = 0;
      });
    });
  }

  //Timer banner off
  late Timer Timerbanner;
  void timerBanner() {
    Timerbanner = Timer(Duration(seconds: 121), () async {
      await scoreBox.add(scores(
          id: randNum,
          username: widget.userName,
          compScore: compScore,
          genScore: genScore,
          totalScore: Score,
          wordPerMinute: finalWPM));
      print('data Save Successfully');
      return showOptions(context);
    });
  }

  //game banner
  void showOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (wordCount > 10) {
            return GameOptions2(
                WordCount: wordCount, username: widget.userName);
          } else {
            return GameOptionsTry2(
                WordCount: wordCount, username: widget.userName);
          }
        });
  }

  //game banner
  void showBanner(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WordUsed2();
        });
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  //score division
  void onScore() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return gameScoresDivision2(compScore: compScore, genScore: genScore);
        });
  }

  void onSubmit() async {
    await tapsounds.OntapSounds();
    if (pressedLetters.isNotEmpty && pressedLetters.length > 1) {
      createdWord = pressedLetters.join('');
      bool isWordExist = false;
      bool isWordUsed = false;
      checker.forEach((element) {
        if (element == createdWord) {
          isWordUsed = true;
        }
      });
      if (!isWordUsed) {
        compWords.ComputerWordsList.forEach((key, value) {
          if (key.toUpperCase() == createdWord.toUpperCase()) {
            print("Word Exist");
            tapsounds.Correct();
            _gameNotifs2.gameNotifRight(context);
            wordCount += 1;
            initialWPM += 1;
            Future.delayed(Duration(seconds: 1), () {
              return onClear();
            });
            isWordExist = true;
            if (createdWord.length > 6) {
              setState(() {
                Score += 15;
                compScore += 15;
              });
            } else {
              setState(() {
                Score += 10;
                compScore += 10;
              });
            }
            return;
          }
        });

        if (isWordExist) {
          checker.add(createdWord);
          return; // Exit the function if the word exists
        }

        if (await dMSAJson.hasEntry(createdWord.toLowerCase())) {
          tapsounds.Correct();
          _gameNotifs2.gameNotifRight(context);
          checker.add(createdWord);
          wordCount += 1;
          Future.delayed(Duration(seconds: 1), () {
            return onClear();
          });
          if (createdWord.length >= 6) {
            setState(() {
              Score += 10;
              compScore += 10;
            });
          } else {
            setState(() {
              Score += 5;
              compScore += 5;
            });
          }
          initialWPM += 1;
          return; // Exit the function
        } else {
          _gameNotifs2.gameNotifWrong(context);
          tapsounds.Wrong();
          Vibration.vibrate();
          Future.delayed(Duration(seconds: 1), () {
            return onClear();
          });
        }
      } else {
        showBanner(context);
        tapsounds.Invalid();
        print("Word used");
      }
    }
  }

  //delete all
  void onClear() async {
    await tapsounds.OntapSounds();
    setState(() {
      if (pressedLetters.isNotEmpty) {
        pressedLetters.clear();
        userInputController.text = '';
      }
      return;
    });
  }

  void onDelete() async {
    await tapsounds.OntapSounds();
    setState(() {
      if (pressedLetters.isNotEmpty) {
        pressedLetters.removeLast();
        userInputController.text = pressedLetters.join('');
      }
      return;
    });
  }

  //no reshuffle on game two

  @override
  void dispose() {
    super.dispose();
    userInputController.dispose();
    _timerform.timer?.cancel();
    TimerWPM.cancel();
    Timerbanner.cancel();
    keysToZero.cancel();
  }

  //GameSounds
  Gamesounds tapsounds = Gamesounds();
  //gameimgs
  IMGS imgs = IMGS();

  //keyboardLength
  int keyboardLength = 16;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String collected = letters.take(keyboardLength).join('');

    List<String> charlist = collected.split('');

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IconButton(
                        onPressed: () {
                          return showOptions(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 30.0,
                          color: Colors.white70,
                        ))),
                SizedBox(
                  width: (screenWidth) * .04,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: GestureDetector(
                        onTap: onScore,
                        child: Text(
                          'Score: ${Score}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (screenWidth) * .03,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return WordCollected2(Allwords: checker);
                                });
                          },
                          icon: Icon(Icons.library_add_check),
                          iconSize: 30,
                          color: Colors.white70,
                        ),
                        Container(
                          height: (screenHeight) * .04,
                          width: (screenWidth) * .22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.white70, width: 2.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.av_timer_sharp,
                                  color: Colors.white70,
                                ),
                                SizedBox(
                                  width: (screenWidth) * .01,
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
                    )
                  ],
                ),
              ],
            )),
        SizedBox(
          height: (screenHeight) * .02,
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
        SizedBox(
          height: screenHeight * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: screenWidth * .10),
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
            IconButton(
              onPressed: onClear,
              icon: Icon(
                Icons.delete,
                color: Colors.white70,
              ),
            )
          ],
        ),
        SizedBox(
          height: screenHeight * .04,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.5),
            child: SizedBox(
              height: 230,
              width: 400,
              child: Wrap(
                children: charlist.map((e) {
                  return InkWell(
                    onTap: () async {
                      await tapsounds.OntapSounds();
                      onTapLetter(e);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, bottom: 10, top: 10, right: 20),
                      child: Container(
                        height: 50,
                        width: 65,
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
        SizedBox(
          height: screenHeight * .04,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
          ),
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
                  onTap: () async {
                    await tapsounds.OntapSounds();
                    setState(() {
                      letters.shuffle();
                    });
                  },
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
                          width: 35,
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
    );
  }
}
