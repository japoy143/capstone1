import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hi Rainier!',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
                Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.green, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      'WPM: 100',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        'General Words',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  Container(
                    height: 250,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 7.0,
                      ),
                      Text(
                        'Computer Words',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    'Play',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    'HighScores',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    'Exit',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
