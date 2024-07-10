import 'package:capstoneapp1/helpers/gamesounds.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  int nextPage = 0;

  Visibility myNote(bool visibility, String note) {
    return Visibility(
      visible: visibility,
      child: Container(
        height: 250,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.green[400],
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Note:',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (nextPage > 0) {
                        nextPage--;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Center(
                  child: SizedBox(
                    height: 180,
                    width: 240,
                    child: Center(
                      child: Text(
                        note,
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 24,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (nextPage < 6) {
                        nextPage++;
                      }
                    });
                  },
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        myNote(nextPage == 0,
            'The Goal of the game is to guess a computer related words to earn more points'),
        myNote(nextPage == 1, 'The Score depends on the length of the word '),
        myNote(nextPage == 2, 'The Game Has different category of difficulty'),
        myNote(nextPage == 3,
            'Easy offers a longer timer duration and includes a hint feature'),
        myNote(nextPage == 4,
            'Intermediate offers a shorter timer duration and doesnt have a hint feature'),
        myNote(nextPage == 5,
            'Expert is similar to Intermediate, but it includes a feature that removes a letter every 8 seconds.'),
      ],
    );
  }
}
