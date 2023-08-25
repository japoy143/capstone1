import 'package:flutter/material.dart';

import 'Dictionaries/ComputerWordsList.dart';

class ShowSelectedComWords extends StatefulWidget {
  final int IndexPass;
  const ShowSelectedComWords({super.key, required this.IndexPass});

  @override
  State<ShowSelectedComWords> createState() => _ShowSelectedComWordsState();
}

class _ShowSelectedComWordsState extends State<ShowSelectedComWords> {
  //CompwordList
  CompWords comp = CompWords();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meaning"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: ((context, index) {
              String key =
                  comp.ComputerWordsList.keys.elementAt(widget.IndexPass);
              String value =
                  comp.ComputerWordsList.values.elementAt(widget.IndexPass);
              return Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          key,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 145,
                          width: 320,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white54),
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            })),
      ),
    );
    ;
  }
}
