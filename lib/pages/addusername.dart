import 'package:capstoneapp1/pages/menuPage.dart';
import 'package:flutter/material.dart';

class AddUsername extends StatelessWidget {
  const AddUsername({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Wrap the Column with Expanded
          const SizedBox(
            height: 200,
          ),
          Text(
            "Create Nickname",
            style: TextStyle(
                color: Colors.green[300],
                fontSize: 20.0,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 80,
              width: 330,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).primaryColor),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 260,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            focusColor: Colors.black,
                            enabledBorder: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MenuPage()));
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 300.0,
          ),
          Container(
            height: 95,
            width: 225,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'WORDY',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Rubik',
                        fontSize: 32.0),
                  ),
                ),
                Center(
                  child: Text(
                    'woodpicker',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Edusa',
                        fontSize: 32.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
