import 'dart:async';
import 'dart:math';
import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameBanner.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameOptions.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameOptions2.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameScoresTable.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimer.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimerUI.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameWordsCollected.dart';
import 'package:capstoneapp1/helpers/gamesounds.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'gameAssets.dart';

class MygameUI1 extends StatefulWidget {
  @override
  _MygameUI1State createState() => _MygameUI1State();
}

class _MygameUI1State extends State<MygameUI1> {
  //dictionary
  final dMSAJson = DictionaryMSAFlutter();

  //Scores
  int Score = 0;
  int compScore = 0;
  int genScore = 0;
  //WordCount
  int wordCount = 0;

  List<String> letters = 'QWERTYUIOPASDFGHJKLZXCVBNM'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';
  //if word already exist
  List<String> checker = [];
  TextEditingController userInputController = TextEditingController();

  //Computer Words List
  CompWords compWords = CompWords();

  //Timer 2 minutes
  TimerController _timerform1 = TimerController();
  TimerUI timerUI = TimerUI();

  @override
  void initState() {
    super.initState();
    _timerform1.startTimer(179);
    timerBanner();
    keysLength();
    letters.shuffle();
    keysZero();
  }

  //Timer banner off
  late Timer Timerbanner;
  void timerBanner() {
    Timerbanner = Timer(Duration(seconds: 179), () {
      return showOptions(context);
    });
  }

  late Timer keysToZero;
  void keysZero() {
    keysToZero = Timer(Duration(seconds: 179), () {
      setState(() {
        keyboardLength = 0;
      });
    });
  }

  //game banner
  void showOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (wordCount > 10) {
            return GameOptions1(WordCount: wordCount);
          } else {
            return GameOptionsTry1(WordCount: wordCount);
          }
        });
  }

  void showBanner(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WordUsed();
        });
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void onTapLetter(String letter) {
    setState(() {
      pressedLetters.add(letter);
      userInputController.text = pressedLetters.join('');
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
            wordCount += 1;
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
          checker.add(createdWord);
          wordCount += 1;
          Future.delayed(Duration(seconds: 1), () {
            return onClear();
          });
          setState(() {
            Score += 5;
            genScore += 5;
          });
          return; // Exit the function
        } else {
          tapsounds.Wrong();
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

  //score division
  void onScore() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return gameScoresDivision(compScore: compScore, genScore: genScore);
        });
  }

//reshuffle
  int num = 3;

  @override
  void dispose() {
    super.dispose();
    userInputController.dispose();
    Timerbanner.cancel();
    keysToZero.cancel();
  }

  //GameSounds
  Gamesounds tapsounds = Gamesounds();
  //gameimgs
  IMGS imgs = IMGS();

  //randomize the keyboardlenght

  late int keyboardLength;
  void keysLength() {
    Random rand = Random();
    keyboardLength = rand.nextInt(10) + 5;
  }

  @override
  Widget build(BuildContext context) {
    String collected = letters.take(keyboardLength).join('');

    List<String> charlist = collected.split('');

    return SafeArea(
      child: Column(
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
                    width: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
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
                        width: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WordCollected(
                                      Allwords: checker,
                                    );
                                  });
                            },
                            icon: Icon(Icons.library_add_check),
                            iconSize: 30,
                            color: Colors.white70,
                          ),
                          Container(
                            height: 30,
                            width: 75,
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
                                  const SizedBox(
                                    width: 3.0,
                                  ),
                                  Obx(
                                    () => Text(
                                      _timerform1.time.value,
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
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "WORDY",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300]),
          ),
          Text(
            "woodpicker",
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
                  alignment: WrapAlignment.center,
                  children: charlist.map((e) {
                    return InkWell(
                      onTap: () async {
                        await tapsounds.OntapSounds();
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
                    onTap: onClear,
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(
                        'Clear',
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0, top: 5.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    letters.shuffle();
                    onClear();
                    return keysLength();
                  });
                },
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    'Reshuffle',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[400]),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
