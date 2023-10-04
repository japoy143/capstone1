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
}
