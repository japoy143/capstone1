import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
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
import 'package:pausable_timer/pausable_timer.dart';
import 'package:vibration/vibration.dart';
import '../../../components/Dictionaries/ComputerWordsList.dart';
import '../../../helpers/gamesounds.dart';
import 'gameAssets.dart';
import 'gameBanner.dart';

class MygameUI2 extends StatefulWidget {
  late String userName;
  late AudioPlayer audioPlayer;
  MygameUI2({required this.userName, required this.audioPlayer});
  @override
  _MygameUI2State createState() => _MygameUI2State();
}

class _MygameUI2State extends State<MygameUI2> {
  //timer
  late final PausableTimer timer;
  var countDown = 120;

  //database
  late Box<scores> scoreBox;

  //bgmusic
  AudioPlayer bgmusic3 = AudioPlayer();

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

  //
  List<String> letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';

  //check if word already  inside this list
  List<String> checker = [];
  List<int> scoreList = [];

  TextEditingController userInputController = TextEditingController();

  //classes
  CompWords compWords = CompWords();
  GameNotifs2 _gameNotifs2 = GameNotifs2();

  @override
  void initState() {
    super.initState();
    letters.shuffle();
    CountDown();
    randId();
    timerWPM();
    // _gameNotifs2.gameNotifGameDescription(context);
    _gameNotifs2.gameNotifGameDescription2(context);
    bgmusic3.play(AssetSource('audios/Bgmusic/Victorous.mp3'));
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

  void keysZero() {
    setState(() {
      keyboardLength = 0;
    });
  }

  // //Timer for gameNotif2
  // late Timer TimerGameNotif2;
  // void timerGameNotif2() {
  //   TimerGameNotif2 = Timer(Duration(seconds: 2, milliseconds: 7), () {
  //     return _gameNotifs2.gameNotifGameDescription2(context);
  //   });
  // }

  void CountDown() {
    timer = PausableTimer.periodic(Duration(seconds: 1), () {
      if (countDown == 0) {
        keysZero();
        timerBanner();
        timer.pause();
      } else {
        var minutes = countDown ~/ 60; // integer division for minutes
        var seconds = countDown % 60; // remainder for seconds
        print(
            '$minutes:${seconds.toString().padLeft(2, '0')}'); // format the output as MM:SS

        setState(() {
          countDown--;
        });
      }
    })
      ..start();
  }

  void timerBanner() async {
    if (scoreBox.containsKey(widget.userName)) {
      final user = await scoreBox.get(widget.userName);
      if (Score > user!.totalScore) {
        await scoreBox.put(
            widget.userName,
            scores(
                id: randNum,
                username: widget.userName,
                compScore: compScore,
                genScore: genScore,
                totalScore: Score,
                wordPerMinute: finalWPM));
      }
    }
    if (!scoreBox.containsKey(widget.userName)) {
      await scoreBox.put(
          widget.userName,
          scores(
              id: randNum,
              username: widget.userName,
              compScore: compScore,
              genScore: genScore,
              totalScore: Score,
              wordPerMinute: finalWPM));
      print('Data saved successfully');
    }

    bgmusic3.stop();
    return showOptions(context);
  }

  //Timer banner off
  // late Timer Timerbanner;
  // void timerBanner() {
  //   Timerbanner = Timer(Duration(seconds: 121), () async {
  //     if (scoreBox.containsKey(widget.userName)) {
  //       final user = await scoreBox.get(widget.userName);
  //       if (Score > user!.totalScore) {
  //         await scoreBox.put(
  //             widget.userName,
  //             scores(
  //                 id: randNum,
  //                 username: widget.userName,
  //                 compScore: compScore,
  //                 genScore: genScore,
  //                 totalScore: Score,
  //                 wordPerMinute: finalWPM));
  //       }
  //     }
  //     if (!scoreBox.containsKey(widget.userName)) {
  //       await scoreBox.put(
  //           widget.userName,
  //           scores(
  //               id: randNum,
  //               username: widget.userName,
  //               compScore: compScore,
  //               genScore: genScore,
  //               totalScore: Score,
  //               wordPerMinute: finalWPM));
  //       print('Data saved successfully');
  //     }

  //     bgmusic3.stop();
  //     return showOptions(context);
  //   });
  // }

  //game banner
  void showOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (wordCount > 10) {
            return GameOptions2(
              time: timer,
              WordCount: wordCount,
              username: widget.userName,
              audioPlayer: widget.audioPlayer,
            );
          } else {
            return GameOptionsTry2(
              time: timer,
              WordCount: wordCount,
              username: widget.userName,
              audioPlayer: widget.audioPlayer,
            );
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
        for (var key in compWords.ComputerWordsList.keys) {
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
            if (createdWord.length <= 3) {
              setState(() {
                Score += 5;
                compScore += 5;
                scoreList.add(5);
              });
            } else if (createdWord.length > 3 && createdWord.length <= 6) {
              setState(() {
                Score += 15;
                compScore += 15;
                scoreList.add(15);
              });
            } else if (createdWord.length > 6 && createdWord.length <= 9) {
              setState(() {
                Score += 25;
                compScore += 25;
                scoreList.add(25);
              });
            } else {
              setState(() {
                Score += 45;
                compScore += 45;
                scoreList.add(45);
              });
            }

            if (isWordExist) {
              checker.add(createdWord);
              break; // Exit the loop and the function if the word exists
            }
          }
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
    TimerWPM.cancel();
    timer.cancel();
    bgmusic3.stop();
    widget.audioPlayer.resume();
  }

  //GameSounds
  Gamesounds tapsounds = Gamesounds();
  //gameimgs
  IMGS imgs = IMGS();

  //mute button
  bool? muteButtonPressed = false;

  //keyboardLength
  int keyboardLength = 16;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String collected = letters.take(keyboardLength).join('');
    var minutes = countDown ~/ 60; // integer division for minutes
    var seconds = countDown % 60;

    List<String> charlist = collected.split('');

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 10.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      timer.pause();
                      return showOptions(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                      color: Colors.white70,
                    )),
                SizedBox(
                  width: (screenWidth) * .01,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        muteButtonPressed = !muteButtonPressed!;
                        muteButtonPressed == true
                            ? bgmusic3.pause()
                            : bgmusic3.resume();
                      });
                    },
                    icon: muteButtonPressed == false
                        ? Icon(
                            Icons.volume_up_rounded,
                            size: 30.0,
                            color: Colors.white70,
                          )
                        : Icon(
                            Icons.volume_mute_rounded,
                            size: 30.0,
                            color: Colors.white70,
                          )),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 33.0),
                      child: Text(
                        'Score: ${Score}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (screenWidth) * .01,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return WordCollected2(
                                    allwords: checker,
                                    allscore: scoreList,
                                  );
                                });
                          },
                          icon: Icon(Icons.library_add_check),
                          iconSize: 30,
                          color: Colors.white70,
                        ),
                        Container(
                          height: (screenHeight) * .04,
                          width: (screenWidth) * .20,
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
                                Text(
                                    '$minutes:${seconds.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500))
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
          'WOODPICKER',
          style: TextStyle(
            fontFamily: 'Edusa',
            fontSize: 25.0,
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
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.amber),
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
            padding: const EdgeInsets.only(left: 40.5),
            child: SizedBox(
              height: screenHeight * .27,
              width: screenWidth * .95,
              child: Wrap(
                children: charlist.map((e) {
                  return InkWell(
                    onTap: () async {
                      await tapsounds.OntapSounds();
                      onTapLetter(e);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 5, bottom: 5, top: 5, right: 15),
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
                                color: Colors.amber[500]),
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
                        child: Icon(
                      Icons.backspace,
                      size: 24,
                      color: Colors.amber[500],
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
                          'Next Word',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.amber[500]),
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
                        color: Colors.amber[500]),
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
