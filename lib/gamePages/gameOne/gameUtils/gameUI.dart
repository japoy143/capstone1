import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameBanner.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameNotifs.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameOptions.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameOptions2.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameScoresTable.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimer.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameTimerUI.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/gameWordsCollected.dart';
import 'package:capstoneapp1/gamePages/gameOne/gameUtils/wordHint.dart';
import 'package:capstoneapp1/helpers/gamesounds.dart';
import 'package:capstoneapp1/models/scores.dart';
import 'package:capstoneapp1/models/wordcollection.dart';
import 'package:dictionaryx/dictionary_msa_json_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import 'gameAssets.dart';
import 'package:intl/intl.dart';

class MygameUI1 extends StatefulWidget {
  late String username;
  late AudioPlayer audioPlayer;
  MygameUI1({required this.username, required this.audioPlayer});

  @override
  _MygameUI1State createState() => _MygameUI1State();
}

class _MygameUI1State extends State<MygameUI1> {
  //dictionary
  final dMSAJson = DictionaryMSAFlutter();

  //Bg music
  AudioPlayer bgMusic = AudioPlayer();

  //database
  late Box<scores> scoreBox;
  late Box<WordCollection> wordcollectionBox;

  //wordPerminute
  int initialWPM = 0;
  int finalWPM = 0;

  //Date now
  DateTime date = DateTime.now();

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
  List<int> ScoreList = [];
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
    randId();
    timerWPM();
    _gameNotifs.gameNotifGameDescription2(context);
    randHintIndex();
    getCompWordIndex();
    shuffleWordHint();

    bgMusic.play(AssetSource('audios/Bgmusic/Soar.mp3'));
    scoreBox = Hive.box<scores>('scores');
    wordcollectionBox = Hive.box<WordCollection>('wordcollection');
  }

  int randNum = 0;
  //randomize id
  void randId() {
    var random = Random();
    randNum = (random.nextDouble() * 10000).toInt() + 1;
  }

  //one minute for WPM
  late Timer TimerWPM;

  void timerWPM() {
    TimerWPM = Timer(Duration(seconds: 60), () {
      finalWPM = initialWPM;
    });
  }

  // //Timer for gameNotif2
  // late Timer TimerGameNotif2;
  // void timerGameNotif2() {
  //   TimerGameNotif2 = Timer(Duration(seconds: 2, milliseconds: 7), () {
  //     return;
  //   });
  // }

  //Timer banner off
  late Timer Timerbanner;
  void timerBanner() {
    Timerbanner = Timer(Duration(seconds: 181), () async {
      if (scoreBox.containsKey(widget.username)) {
        final user = await scoreBox.get(widget.username);
        if (Score > user!.totalScore) {
          await scoreBox.put(
              widget.username,
              scores(
                  id: randNum,
                  username: widget.username,
                  compScore: compScore,
                  genScore: genScore,
                  totalScore: Score,
                  wordPerMinute: finalWPM));
        }
      }
      if (!scoreBox.containsKey(widget.username)) {
        await scoreBox.put(
            widget.username,
            scores(
                id: randNum,
                username: widget.username,
                compScore: compScore,
                genScore: genScore,
                totalScore: Score,
                wordPerMinute: finalWPM));
        print('Data saved successfully');
      }
      await wordcollectionBox.add(WordCollection(
          username: widget.username, wordcollected: checker, date: date));
      bgMusic.stop();
      return showOptions(context);
    });
  }

  late Timer keysToZero;
  void keysZero() {
    keysToZero = Timer(Duration(seconds: 181), () {
      setState(() {
        keyboardLength = 0;
        shuffledWordHint = '';
      });
    });
  }

  //game banner
  void showOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          if (wordCount > 10) {
            return GameOptions1(
              WordCount: wordCount,
              username: widget.username,
              audioPlayer: widget.audioPlayer,
            );
          } else {
            return GameOptionsTry1(
              WordCount: wordCount,
              username: widget.username,
              audioPlayer: widget.audioPlayer,
            );
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
            _gameNotifs.gameNotifRight(context);
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
                ScoreList.add(5);
              });
            } else if (createdWord.length > 3 && createdWord.length <= 6) {
              setState(() {
                Score += 15;
                compScore += 15;
                ScoreList.add(15);
              });
            } else if (createdWord.length > 6 && createdWord.length <= 9) {
              setState(() {
                Score += 25;
                compScore += 25;
                ScoreList.add(25);
              });
            } else {
              setState(() {
                Score += 45;
                compScore += 45;
                ScoreList.add(45);
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
    TimerWPM.cancel();

    bgMusic.stop();
    widget.audioPlayer.resume();
  }

  //GameSounds
  Gamesounds tapsounds = Gamesounds();
  //gameimgs
  IMGS imgs = IMGS();

  //randomize the keyboardlenght

  late int keyboardLength;
  void keysLength() {
    Random rand = Random();
    keyboardLength = rand.nextInt(7) + 3;
  }

  //game Hint
  int randHint = 0;
  //randomize id
  void randHintIndex() {
    var random = Random();
    randHint = (random.nextInt(100)) + 1;
  }

  String wordHint = "";
  bool wordHintPressed = false;

  void getCompWordIndex() {
    for (int i = 0; i <= compWords.ComputerWordsList.keys.length; i++) {
      if (i == randHint) {
        wordHint = compWords.ComputerWordsList.keys.elementAt(i);
      }
    }
  }

  //shuffle Hint
  String shuffledWordHint = "";

  void shuffleWordHint() {
    String str = wordHint;
    List<String> newListHint = str.split('');
    newListHint.shuffle();
    String jointStr = newListHint.join();
    shuffledWordHint = jointStr;
  }

  void showHintWord() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return wordHints(hintWord: wordHint);
        });
  }

  //mute button
  bool? muteButtonPressed = false;
  //gameNotifications
  GameNotifs _gameNotifs = GameNotifs();

  @override
  Widget build(BuildContext context) {
    //screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String collected = letters.take(keyboardLength).join('');
    String newCollected =
        collected + shuffledWordHint.toUpperCase().replaceAll(" ", '');
    List<String> charlist = newCollected.split('');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: IconButton(
                      onPressed: () {
                        return showOptions(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30.0,
                        color: Colors.white70,
                      ))),
              IconButton(
                  onPressed: () {
                    setState(() {
                      muteButtonPressed = !muteButtonPressed!;
                      muteButtonPressed == true
                          ? bgMusic.pause()
                          : bgMusic.resume();
                    });
                  },
                  icon: muteButtonPressed == false
                      ? const Icon(
                          Icons.volume_up_rounded,
                          size: 35.0,
                          color: Colors.white70,
                        )
                      : const Icon(
                          Icons.volume_mute_rounded,
                          size: 35.0,
                          color: Colors.white70,
                        )),
              wordHintPressed == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          wordHintPressed = true;
                        });
                        showHintWord();
                      },
                      child: const SizedBox(
                        height: 32,
                        width: 50,
                        child: Image(
                          image: AssetImage(
                            'assets/icons/lightbulb.png',
                          ),
                          color: Colors.white70,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 32,
                      width: 40,
                      child: Image(
                        image: AssetImage('assets/icons/lightbulbused.png'),
                        color: Colors.white70,
                      ),
                    ),
              Row(
                children: <Widget>[
                  Text(
                    'Score: ${Score}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
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
                                return WordCollected(
                                    allwords: checker, allscore: ScoreList);
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
                          border: Border.all(color: Colors.white70, width: 2.0),
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
          ),
        ),
        SizedBox(
          height: (screenHeight) * .02,
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
        SizedBox(
          height: (screenHeight) * .01,
        ),
        Center(
          child: Stack(
            children: [
              imgs.gameImg(true, 'assets/imgs/thief2.png'),
            ],
          ),
        ),
        const SizedBox(
          height: 2.0,
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
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
          height: screenHeight * .05,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: SizedBox(
              height: screenHeight * .23,
              width: screenWidth * .90,
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
                        height: screenHeight * .07,
                        width: screenWidth * .09,
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
                        child: Icon(
                      Icons.backspace,
                      color: Colors.green[400],
                      size: 24,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      letters.shuffle();
                      randHintIndex();
                      getCompWordIndex();
                      shuffleWordHint();
                      wordHintPressed = false;
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
                      'Next Word',
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
      ],
    );
  }
}
