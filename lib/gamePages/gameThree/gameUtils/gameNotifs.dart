import 'package:flutter/material.dart';

class GameNotifs3 {
  void gameNotifWrong(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context as BuildContext).size.height * .08,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(child: Text('Create Another Word')),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context as BuildContext).size.height - 140,
          ),
          duration: Duration(seconds: 1, milliseconds: 5),
        ),
      );
    });
  }

  void gameNotifRight(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context as BuildContext).size.height * .08,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/imgs/con1.png')),
                Text('Congratulations Correct Word'),
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset('assets/imgs/con1.png')),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context as BuildContext).size.height - 140,
          ),
          duration: Duration(seconds: 1, milliseconds: 5),
        ),
      );
    });
  }

  void gameNotifGameDescription(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: MediaQuery.of(context as BuildContext).size.height * .12,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  'Create a Word That is Computer related word  Other words is accepted considered as Bonus words ',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context as BuildContext).size.height - 200,
          ),
          duration: Duration(seconds: 2, milliseconds: 5),
        ),
      );
    });
  }

  void gameNotifGameDescription2(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: MediaQuery.of(context as BuildContext).size.height * .12,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  'Computer Words has a higher equivalent points and points also varies on its word length',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context as BuildContext).size.height - 200,
          ),
          duration: Duration(seconds: 2, milliseconds: 5),
        ),
      );
    });
  }
}
