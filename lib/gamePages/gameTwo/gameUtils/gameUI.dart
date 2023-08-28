import 'package:capstoneapp1/gamePages/gameTwo/gameUtils/gameTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/Dictionaries/ComputerWordsList.dart';
import '../../../helpers/gamesounds.dart';
import 'gameAssets.dart';

class MygameUI2 extends StatefulWidget {
  @override
  _MygameUI2State createState() => _MygameUI2State();
}

class _MygameUI2State extends State<MygameUI2> {
  //Score
  int Score = 0;
  // one minute timer

  int seconds = 225;
  TimerController2 _timerform = TimerController2();

  //
  List<String> letters =
      'AAABBCCDDEEEFFGGHHIIIJJKKLLMMNNOOOPPQQRRSSTTUUUVVWWXXYYZZ'.split("");

  List<String> pressedLetters = [];
  String createdWord = '';
  String meaning = '';
  TextEditingController userInputController = TextEditingController();

  CompWords compWords = CompWords();

  @override
  void initState() {
    super.initState();
    letters.shuffle();

    _timerform.startTimer(119);
  }

  void onTapLetter(String letter) {
    setState(() {
      pressedLetters.add(letter);
      userInputController.text = pressedLetters.join('');
    });
  }

  void onSubmit() async {
    await tapsounds.OntapSounds();
    if (pressedLetters.isNotEmpty) {
      bool exist = false;
      createdWord = pressedLetters.join('');
      compWords.ComputerWordsList.forEach((key, value) {
        if (key.toUpperCase() == createdWord.toUpperCase()) {
          print("Word Exist");
          tapsounds.Correct();
          exist = true;
        }
      });
      if (exist == false) {
        tapsounds.Wrong();
      }
    } else {
      print('Word doesnt Exist');
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

  //no reshuffle on game two

  @override
  void dispose() {
    super.dispose();
    userInputController.dispose();
    _timerform.timer?.cancel();
  }

  //GameSounds
  Gamesounds tapsounds = Gamesounds();
  //gameimgs
  IMGS imgs = IMGS();

  @override
  Widget build(BuildContext context) {
    String collected = letters.take(20).join('');

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
                        padding: const EdgeInsets.all(4.0),
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
            height: 5.0,
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
      ),
    );
  }
}
