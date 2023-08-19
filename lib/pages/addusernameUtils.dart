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
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  note,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
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
                  icon: Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (nextPage < 3) {
                        nextPage++;
                      }
                    });
                  },
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: Icon(Icons.arrow_back_ios),
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
        myNote(nextPage == 0, '1'),
        myNote(nextPage == 1, '2'),
        myNote(nextPage == 2, '3'),
        myNote(nextPage == 3, '4'),
      ],
    );
  }
}
