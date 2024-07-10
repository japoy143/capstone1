// ... (your imports)

import 'package:capstoneapp1/components/Dictionaries/ComputerWordsList.dart';
import 'package:flutter/material.dart';

class CompWordSearch extends StatefulWidget {
  final String value;
  CompWordSearch({Key? key, required this.value}) : super(key: key);

  @override
  State<CompWordSearch> createState() => _CompWordSearchState();
}

class _CompWordSearchState extends State<CompWordSearch> {
  // CompwordList
  CompWords _compWords = CompWords();

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
          itemBuilder: ((context, value) {
            var _value = _compWords.ComputerWordsList[widget.value];
            return Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.value,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white54,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _value!,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
