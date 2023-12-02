import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameNotifs.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameOptions1.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameOptions2.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameScoreDivision.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameTimer.dart';
import 'package:capstoneapp1/gamePages/gameThree/gameUtils/gameWordCollected.dart';
import 'package:capstoneapp1/helpers/gamesounds.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import 'gameAssets.dart';
import 'gameBanner.dart';

class MygameUI3 extends StatefulWidget {
  MygameUI3({required this.userName, required this.audioPlayer});
  late String userName;
  late AudioPlayer audioPlayer;
  @override
  _MygameUI3State createState() => _MygameUI3State();
}

class _MygameUI3State extends State<MygameUI3> {
  //database
  late Box<scores> scoreBox;
  //Score
  int Score = 0;
  int compScore = 0;
  int genScore = 0;

  //WPM
  int initialWPM = 0;
  int finalWPM = 0;

  //wordCount
  int wordCount = 0;

  //dictionary
  final dMSAJson = DictionaryMSAFlutter();

  late Timer _newtimer;
  int seconds = 225;
  TimerController3 _timerform = TimerController3();

  //keys
  List<String> letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';

  //checker if the word is already used
  List<String> checker = [];
  TextEditingController userInputController = TextEditingController();

  //bgmusic2
  AudioPlayer bgMusic3 = AudioPlayer();

  GameNotifs3 _gameNotifs3 = GameNotifs3();
  CompWords compWords = CompWords();
  @override
  void initState() {
    super.initState();
    letters.shuffle();
    _startMinusLetter();
    _timerform.startTimer(119);
    timerBanner();
    _gameNotifs3.gameNotifGameDescription(context);
    timerGameNotif2();
    randId();
    timerWPM();
    bgMusic3.play(AssetSource('audios/Bgmusic/FastRun.mp3'));
    scoreBox = Hive.box<scores>('scores');
  }

  void onTapLetter(String letter) {
    setState(() {
      pressedLetters.add(letter);
      userInputController.text = pressedLetters.join('');
    });
  }

  //game banner
  void showBanner(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WordUsed3();
        });
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
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
            _gameNotifs3.gameNotifRight(context);
            wordCount += 1;
            initialWPM += 1;
            Future.delayed(Duration(seconds: 1), () {
              return onClear();
            });
            isWordExist = true;
            if (createdWord.length >= 6) {
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
        Future.delayed(Duration(seconds: 1), () {
          return onClear();
        });
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

  //onclear deletes all
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

  //game banner
  void showOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (wordCount > 10) {
            return GameOptions3(
              WordCount: wordCount,
              username: widget.userName,
              audioPlayer: widget.audioPlayer,
            );
          } else {
            return GameOptionsTry3(
              WordCount: wordCount,
              username: widget.userName,
              audioPlayer: widget.audioPlayer,
            );
          }
        });
  }

  //score division
  void onScore() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return gameScoresDivision3(compScore: compScore, genScore: genScore);
        });
  }

  //Timer for gameNotif2
  late Timer TimerGameNotif2;
  void timerGameNotif2() {
    TimerGameNotif2 = Timer(Duration(seconds: 2, milliseconds: 7), () {
      return _gameNotifs3.gameNotifGameDescription2(context);
    });
  }

  late Timer Timerbanner;
  void timerBanner() {
    Timerbanner = Timer(Duration(seconds: 121), () async {
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

      bgMusic3.stop();
      return showOptions(context);
    });
  }

  int randNum = 0;
  //randomize id
  void randId() {
    var random = Random();
    randNum = (random.nextDouble() * 10000).toInt() + 1;
  }

/*
  //timer for state img
  late StreamSubscription? timerThiefImgSubscription;

  void timerThiefimgs() {
    timerThiefImgSubscription =
        Future.delayed(Duration(seconds: 1, milliseconds: 5))
            .asStream()
            .listen((_) {
      setState(() {
        thiefImg = true;
        thiefImg2 = false;
      });
    });
  }
  */
  void thiefImgsStates() {
    Future.delayed(Duration(seconds: 1, milliseconds: 5), () {
      setState(() {
        thiefImg = true;
        thiefImg2 = false;
      });
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
    Timerbanner.cancel();
    TimerWPM.cancel();
    TimerGameNotif2.cancel();
    bgMusic3.stop();
    widget.audioPlayer.resume();
  }

  //length of letter iteration
  int LetterCount = 15;
  int numcount = 15;
  void _startMinusLetter() {
    _newtimer = Timer.periodic(Duration(seconds: 8), (timer) {
      if (numcount % 15 == 0) {
        if (LetterCount > 0) {
          setState(() {
            LetterCount--;
            thiefImg = false;
            thiefImg2 = true;
          });
          thiefImgsStates();
        }
      }
    });
  }

  late Timer TimerWPM;

  void timerWPM() {
    TimerWPM = Timer(Duration(seconds: 60), () {
      finalWPM = initialWPM;
    });
  }

  // thiefimgs
  var thiefImg = true;
  var thiefImg2 = false;

  // mute button
  bool? muteButtonPressed = false;

  //GameSounds
  Gamesounds tapsounds = Gamesounds();

  //gameimgs
  IMGS imgs = IMGS();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String collected = letters.take(LetterCount).join('');

    List<String> charlist = collected.split('');

    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 10.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        return showOptions(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30.0,
                        color: Colors.white70,
                      )),
                  SizedBox(
                    width: (screenWidth) * .03,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          muteButtonPressed = !muteButtonPressed!;
                          muteButtonPressed == true
                              ? bgMusic3.pause()
                              : bgMusic3.resume();
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
                        padding: EdgeInsets.only(left: 20.0),
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
                        width: (screenWidth) * .02,
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return WordCollected3(Allwords: checker);
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
            height: screenHeight * .03,
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
                imgs.gameImg(thiefImg, 'assets/imgs/thief3.png'),
                imgs.gameImg(thiefImg2, 'assets/imgs/thief2.png'),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
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
            height: screenHeight * .03,
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
                      onTap: () async {
                        await tapsounds.OntapSounds();
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
            padding: const EdgeInsets.only(top: 35.0, bottom: 15.0),
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
                        color: Colors.green[400],
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: num > 0
                        ? () async {
                            await tapsounds.OntapSounds();
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
                            'Next Word',
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
