import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:capstoneapp1/components/Dictionaries/GeneralwordsList.dart';
import 'package:flutter/material.dart';

class ShowSelectedGenWord extends StatefulWidget {
  final int indexPass;
  const ShowSelectedGenWord({super.key, required this.indexPass});

  @override
  State<ShowSelectedGenWord> createState() => _ShowSelectedGenWordState();
}

class _ShowSelectedGenWordState extends State<ShowSelectedGenWord> {
  //CompwordList
  GenWords gen = GenWords();

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
              String key = gen.gWords.keys.elementAt(widget.indexPass);
              String value = gen.gWords.values.elementAt(widget.indexPass);
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
  }
}
