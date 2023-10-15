import 'package:capstoneapp1/pages/addusernameUtils.dart';
import 'package:capstoneapp1/pages/menuPage.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class AddUsername extends StatefulWidget {
  AddUsername({Key? key});

  @override
  State<AddUsername> createState() => _AddUsernameState();
}

class _AddUsernameState extends State<AddUsername> {
  Note _note = Note();

  TextEditingController usernameController = TextEditingController();

  AudioPlayer audioPlayer = AudioPlayer();

  late Box userBox;
  bool isTextFieldEmpty = true;

  void Onsave() async {
    try {
      await userBox.add(usernameController.text);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuPage(
                nameUser: usernameController.text,
                audioPlayer: audioPlayer,
              )));
      print('Data Save Successfully');
    } catch (e) {
      print(e);
    }
  }

  void onDelete(int index) {
    userBox.deleteAt(index);
    print('deleted');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('newUsers');
    audioPlayer.play(
      AssetSource('audios/Bgmusic/SadDay.mp3'),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    ///screen height and width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //status bar
    final screenStatusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Wrap the Column with Expanded
            SizedBox(
              height: (screenHeight - screenStatusBar) * .16,
            ),
            Text(
              "Create Username",
              style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 20.0,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: (screenHeight - screenStatusBar) * .01,
            ),
            Center(
              child: Container(
                height: (screenHeight - screenStatusBar) * .10,
                width: (screenWidth) * .85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: (screenWidth) * .05,
                    ),
                    SizedBox(
                      width: (screenWidth) * .65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              isTextFieldEmpty = value.isEmpty;
                            });
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          style: const TextStyle(color: Colors.white70),
                          decoration: const InputDecoration(
                              focusColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white70)),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                          controller: usernameController,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: isTextFieldEmpty ? null : Onsave,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: (screenHeight - screenStatusBar) * .08,
            ),
            Text(
              'Select Users',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Rubik',
                  color: Colors.green[400],
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: (screenHeight - screenStatusBar) * .29,
              width: (screenWidth) * .50,
              child: ListView.builder(
                  itemCount: userBox.length,
                  itemBuilder: (context, index) {
                    final newusers = userBox.getAt(index);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MenuPage(
                                    nameUser: newusers,
                                    audioPlayer: audioPlayer,
                                  )));
                        },
                        onLongPress: () {
                          setState(() {
                            userBox.deleteAt(index);
                            Vibration.vibrate();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(9.0)),
                          child: Center(
                            child: Text(
                              newusers,
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Note(),
            ),
          ],
        ),
      ),
    );
  }
}
