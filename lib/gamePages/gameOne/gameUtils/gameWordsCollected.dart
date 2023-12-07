import 'package:flutter/material.dart';

class WordCollected extends StatelessWidget {
  WordCollected({Key, key, required this.Allwords}) : super(key: key);

  late List<String> Allwords;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        width: 300,
        child: Column(children: <Widget>[
          Text(
            'Words Collected',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Anton', color: Colors.green[400]),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.green[400]),
              height: 250,
              width: 280,
              child: ListView(
                children: Allwords.map((e) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            e,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ))
        ]),
      ),
    );
  }
}
